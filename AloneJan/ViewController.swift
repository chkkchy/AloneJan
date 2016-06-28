//
//  ViewController.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/22.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let screenWidth = Double(UIScreen.mainScreen().bounds.size.width)
    private let screenHeight = Double(UIScreen.mainScreen().bounds.size.height)
    
    private let maxHandCount = 14
    private let defaultPlayerCount = 4
    
    private let handCollectionViewCellReuseId = "hand"
    private let disgardedCollectionViewCellReuseId = "disgarded"

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
    
    private let handCollectionView: UICollectionView = {
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
        collectionView.backgroundColor = .clearColor()
        return collectionView
    }()
    
    private let disgardedCollectionView: UICollectionView = {
        let imageWidth: CGFloat = 32.0 // Fixed size
        let imageHeight: CGFloat = 45.0 // Fixed size
        let margin: CGFloat = 0.5
        let width = (UIScreen.mainScreen().bounds.size.width - (margin * (14 + 1))) / 14
        let height = width / imageWidth * imageHeight
        let m = (UIScreen.mainScreen().bounds.size.width - (width * 6 + 1.5 * 5)) / 2
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(width, height)
        layout.minimumInteritemSpacing = 1.5
        layout.minimumLineSpacing = 1.5
        layout.sectionInset = UIEdgeInsetsMake(0, m, 0, m)
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clearColor()
        return collectionView
    }()
    
    private var field: Field!
    private var player: Player!
    private var playerId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ホーム"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.onClick))
        self.view.backgroundColor = .whiteColor()
        
        resetButton.addTarget(self, action: #selector(ViewController.tappedResetButton), forControlEvents: .TouchUpInside)
        sortButton.addTarget(self, action: #selector(ViewController.tappedSortButton), forControlEvents: .TouchUpInside)
        handCollectionView.delegate = self
        handCollectionView.dataSource = self
        handCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: handCollectionViewCellReuseId)
        disgardedCollectionView.delegate = self
        disgardedCollectionView.dataSource = self
        disgardedCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: disgardedCollectionViewCellReuseId)
        
        self.view.addSubview(pointLabel)
        self.view.addSubview(conditionLabel)
        self.view.addSubview(countLabel)
        self.view.addSubview(resetButton)
        self.view.addSubview(sortButton)
        self.view.addSubview(handCollectionView)
        self.view.addSubview(disgardedCollectionView)
        
        reset()
    }
    
    override func viewDidLayoutSubviews() {
        pointLabel.frame     = CGRect(x: 10, y: 100, width: screenWidth, height: 50)
        conditionLabel.frame = CGRect(x: 10, y: 150, width: screenWidth, height: 50)
        countLabel.frame     = CGRect(x: 10, y: 200, width: screenWidth, height: 50)
        resetButton.frame    = CGRect(x: 10, y: 250, width: 100, height: 50)
        sortButton.frame     = CGRect(x: 150, y: 250, width: 100, height: 50)
        handCollectionView.frame = CGRect(x: 0, y: (screenHeight/4)*3, width: screenWidth, height: screenHeight/4)
        disgardedCollectionView.frame = CGRect(x: 0, y: screenHeight/2, width: screenWidth, height: screenHeight/4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView.self == disgardedCollectionView {
            return
        }
        if player.hand.count < maxHandCount {
            player.drawFrom(&field.stack)
            handCollectionView.reloadData()
            updateCountLabel()
            return
        }
        player.discardHand(indexPath.row)
        handCollectionView.reloadData()
        disgardedCollectionView.reloadData()
        // other players draw
        for i in 0..<defaultPlayerCount {
            if i == playerId {
                continue
            }
            field.players[i].drawFrom(&field.stack)
            field.players[i].discardTsumo()
            updateCountLabel()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.self {
        case handCollectionView:
            return player.hand.count
        case disgardedCollectionView:
            return player.disgarded.count
        default:
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var reuseIdentifier: String!
        var image: UIImage!
        switch collectionView.self {
        case handCollectionView:
            reuseIdentifier = handCollectionViewCellReuseId
            image = UIImage(named: player.hand[indexPath.row].image)
        case disgardedCollectionView:
            reuseIdentifier = disgardedCollectionViewCellReuseId
            image = UIImage(named: player.disgarded[indexPath.row].image)
        default:
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        let imageView = UIImageView(image: image)
        imageView.frame = cell.bounds
        cell.contentView.addSubview(imageView)
        return cell
    }
    
    func tappedResetButton() {
        reset()
    }
    
    func tappedSortButton() {
        player.sortHand()
        handCollectionView.reloadData()
    }

    func updatePointLabel() {
        var text = ""
        for player in field.players {
            text += String(format: "%@:%d ", player.wind.description, player.point)
        }
        pointLabel.text = text
    }
    
    func updateConditionLabel() {
        conditionLabel.text = String(
            format: "%@%d局 %@家 %d本場 供託: %d ドラ: %@",
            field.round.description, field.hand, player.wind.description, field.honba, field.deposit, field.dora.string
        )
    }
    
    func updateCountLabel() {
        countLabel.text = String(format: "[%d]", field.stack.count)
    }
    
    func onClick() {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    func reset() {
        field = Field()
        playerId = Int(arc4random_uniform(UInt32(defaultPlayerCount)))
        player = field.players[playerId]
        // other players draw
        for i in 0..<defaultPlayerCount {
            if field.players[i].wind.rawValue < player.wind.rawValue {
                field.players[i].drawFrom(&field.stack)
                field.players[i].discardTsumo()
            }
        }
        updatePointLabel()
        updateConditionLabel()
        updateCountLabel()
        handCollectionView.reloadData()
        disgardedCollectionView.reloadData()
    }

}