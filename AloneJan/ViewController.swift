//
//  ViewController.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/22.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let screenWidth = Double(UIScreen.mainScreen().bounds.size.width)
    let screenHeight = Double(UIScreen.mainScreen().bounds.size.height)
    
    let handCount = 14

    private let pointLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", forState: .Normal)
        button.titleLabel!.font = UIFont(name: "Cochin-Bold", size: 20)
        button.backgroundColor = .redColor()
        button.layer.cornerRadius = 10.0
        button.layer.borderColor = UIColor.lightGrayColor().CGColor
        button.layer.borderWidth = 1.0
        button.setTitleColor(.blackColor(), forState: .Normal)
        button.setTitleColor(.darkGrayColor(), forState: .Highlighted)
        return button
    }()
    
    private let sortButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sort", forState: .Normal)
        button.backgroundColor = .greenColor()
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let imageWidth: CGFloat = 32.0 // Fixed size
        let imageHeight: CGFloat = 45.0 // Fixed size
        let margin: CGFloat = 0.5
        let width = (UIScreen.mainScreen().bounds.size.width - (margin * (14 + 1))) / 14
        let height = width / imageWidth * imageHeight
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(width, height)
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin)
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = .whiteColor()
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    var field = Field()
    var player: Player!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ホーム"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.onClick))
        self.view.backgroundColor = .whiteColor()
        
        // TODO: このへん init() とかにまとめる
        player = field.players[0] //field.players[Int(arc4random_uniform(UInt32(4)))] 現状index out of rangeなっちゃう
        
        updatePointLabel()
        updateConditionLabel()
        updateCountLabel()
        resetButton.addTarget(self, action: #selector(ViewController.tappedResetButton), forControlEvents: .TouchUpInside)
        sortButton.addTarget(self, action: #selector(ViewController.tappedSortButton), forControlEvents: .TouchUpInside)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(pointLabel)
        self.view.addSubview(conditionLabel)
        self.view.addSubview(countLabel)
        self.view.addSubview(resetButton)
        self.view.addSubview(sortButton)
        self.view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        pointLabel.frame     = CGRect(x: 10, y: 100, width: screenWidth, height: 50)
        conditionLabel.frame = CGRect(x: 10, y: 150, width: screenWidth, height: 50)
        countLabel.frame     = CGRect(x: 10, y: 200, width: screenWidth, height: 50)
        resetButton.frame    = CGRect(x: 10, y: 250, width: 100, height: 50)
        sortButton.frame     = CGRect(x: 150, y: 250, width: 100, height: 50)
        collectionView.frame = CGRect(x: 0, y: (screenHeight/3)*2, width: screenWidth, height: screenHeight/3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if field.stack.isEmpty {
            return
        }
        player.discardHand(indexPath.row)
        player.drawFrom(&field.stack)
        updateCountLabel()
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return handCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        let image = UIImage(named: player.hand[indexPath.row].image)
        let imageView = UIImageView(image: image)
        imageView.frame = cell.bounds
        cell.contentView.addSubview(imageView)
        return cell
    }
    
    func tappedResetButton() {
        field = Field()
        player = field.players[0] //field.players[Int(arc4random_uniform(UInt32(4)))]
        updatePointLabel()
        updateConditionLabel()
        updateCountLabel()
        collectionView.reloadData()
    }
    
    func tappedSortButton() {
        player.sortHand()
        collectionView.reloadData()
    }

    func updatePointLabel() {
        var text = ""
        for player in field.players {
            text += String(format: "%@:%d ", player.wind.description, player.point)
        }
        pointLabel.text = text
    }
    
    func updateConditionLabel() {
        conditionLabel.text = String(format: "%@%d局 %@家 %d本場 供託: %d ドラ: %@", field.round.description, field.hand, player.wind.description, field.honba, field.deposit, field.dora.string)
    }
    
    func updateCountLabel() {
        countLabel.text = String(format: "[%d]", field.stack.count)
    }
    
    func onClick() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
}