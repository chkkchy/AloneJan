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

    var countLabel: UILabel!
    var conditionLabel: UILabel!
    var resetButton: UIButton!
    var sortButton: UIButton!
    
    var collectionView: UICollectionView!
    
    var field = Field()
    let player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        player.drawFrom(&field.stack, count: handCount)
        
        countLabel = UILabel(frame: CGRect(x: 30, y: 100, width: screenWidth, height: 50))
        updateCountLabel()
        self.view.addSubview(countLabel)
        
        conditionLabel = UILabel(frame: CGRect(x: 30, y: 150, width: screenWidth, height: 50))
        updateConditionLabel()
        self.view.addSubview(conditionLabel)
        
        resetButton = UIButton(frame: CGRect(x: 30, y: 200, width: 100, height: 50))
        resetButton.setTitle("Reset", forState: .Normal)
        resetButton.backgroundColor = .redColor()
        resetButton.addTarget(self, action: #selector(ViewController.tappedResetButton), forControlEvents: .TouchUpInside)
        self.view.addSubview(resetButton)
        
        sortButton = UIButton(frame: CGRect(x: 150, y: 200, width: 100, height: 50))
        sortButton.setTitle("Sort", forState: .Normal)
        sortButton.backgroundColor = .greenColor()
        sortButton.addTarget(self, action: #selector(ViewController.tappedSortButton), forControlEvents: .TouchUpInside)
        self.view.addSubview(sortButton)
        
        // :TODO
        let image = UIImage(named: "ji7-66-90-s-emb.png")
        let w = (view.bounds.size.width - (14 * 2) - (2 * 2)) / 14
        let h = w / (image?.size.width)! * (image?.size.height)!
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(w, h)
        layout.minimumInteritemSpacing = 1.5
        layout.sectionInset = UIEdgeInsetsMake((CGFloat(screenHeight/2)-h)/2, 0, 0, 0)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.frame = CGRect(x: 0, y: screenHeight/2, width: screenWidth, height: screenHeight/2)
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
        if field.isTerminalOfStack {
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
        player.hand = []
        player.drawFrom(&field.stack, count: handCount)
        updateCountLabel()
        updateConditionLabel()
        collectionView.reloadData()
    }
    
    func tappedSortButton() {
        player.sortHand()
        collectionView.reloadData()
    }

    func updateCountLabel() {
        countLabel.text = String(format: "%d : %d",
                                 field.stack.count, 136 - (player.hand.count + field.stack.count))
    }
    
    func updateConditionLabel() {
        print(field.round)
        conditionLabel.text = String(format: "%@ %d局 %d本場 供託: %d ドラ: %@",
                                     field.round.description, field.hand, field.honba, field.deposit, field.dora.string)
    }
    
}