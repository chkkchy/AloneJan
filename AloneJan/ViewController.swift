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

    var pointLabel: UILabel!
    var conditionLabel: UILabel!
    var countLabel: UILabel!
    var resetButton: UIButton!
    var sortButton: UIButton!
    
    var collectionView: UICollectionView!
    
    var field = Field()
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "ホーム"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.onClick))
        self.view.backgroundColor = .whiteColor()
        
        // TODO: このへん init() とかにまとめる
        player = field.players[0] //field.players[Int(arc4random_uniform(UInt32(4)))] 現状index out of rangeなっちゃう
        
        pointLabel = UILabel(frame: CGRect(x: 10, y: 100, width: screenWidth, height: 50))
        updatePointLabel()
        self.view.addSubview(pointLabel)
        
        conditionLabel = UILabel(frame: CGRect(x: 10, y: 150, width: screenWidth, height: 50))
        updateConditionLabel()
        self.view.addSubview(conditionLabel)
        
        countLabel = UILabel(frame: CGRect(x: 10, y: 200, width: screenWidth, height: 50))
        updateCountLabel()
        self.view.addSubview(countLabel)
        
        resetButton = UIButton(frame: CGRect(x: 10, y: 250, width: 100, height: 50))
        resetButton.setTitle("Reset", forState: .Normal)
        resetButton.titleLabel!.font = UIFont(name: "Cochin-Bold", size: 20)
        resetButton.backgroundColor = .redColor()
        resetButton.layer.cornerRadius = 10.0
        resetButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        resetButton.layer.borderWidth = 1.0
        resetButton.setTitleColor(.blackColor(), forState: .Normal)
        resetButton.setTitleColor(.darkGrayColor(), forState: .Highlighted)
        resetButton.addTarget(self, action: #selector(ViewController.tappedResetButton), forControlEvents: .TouchUpInside)
        self.view.addSubview(resetButton)
        
        sortButton = UIButton(frame: CGRect(x: 150, y: 250, width: 100, height: 50))
        sortButton.setTitle("Sort", forState: .Normal)
        sortButton.backgroundColor = .greenColor()
        sortButton.addTarget(self, action: #selector(ViewController.tappedSortButton), forControlEvents: .TouchUpInside)
        self.view.addSubview(sortButton)
        
        // :TODO
        let image = UIImage(named: "ji7-66-90-s-emb.png")
        print("image", image?.size.width, image?.size.width)
        print(view.bounds.size.width)
        let w = (view.bounds.size.width - (0.5 * (14 + 1))) / 14
        let h = w / (image?.size.width)! * (image?.size.height)!
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(w, h)
        layout.minimumInteritemSpacing = 0.5
        layout.sectionInset = UIEdgeInsetsMake(0, 0.5, 0, 0.5)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .whiteColor()
        collectionView.frame = CGRect(x: 0, y: (screenHeight/3)*2, width: screenWidth, height: screenHeight/3)
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
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
        var text = String(format: "<%@家>", player.wind.description)
        for player in field.players {
            text += String(format: "%@:%d ", player.wind.description, player.point)
        }
        pointLabel.text = text
    }
    
    func updateConditionLabel() {
        conditionLabel.text = String(format: "%@ %d局 %d本場 供託: %d ドラ: %@", field.round.description, field.hand, field.honba, field.deposit, field.dora.string)
    }
    
    func updateCountLabel() {
        countLabel.text = String(format: "[%d]", field.stack.count)
    }
    
    func onClick() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
}