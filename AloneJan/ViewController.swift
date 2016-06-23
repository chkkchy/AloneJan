//
//  ViewController.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/22.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let handCount = 14

    var leftWallCountLabel = UILabel()
    var tsumoCountLabel = UILabel()
    var resetButton = UIButton()
    
    var collectionView: UICollectionView!
    
    var tiles = Tiles()
    var hand = [Tile]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let screenWidth = Double(UIScreen.mainScreen().bounds.size.width)
        let screenHeight = Double(UIScreen.mainScreen().bounds.size.height)
        
        
        
        for _ in 0 ..< handCount {
            let tsumo = tiles.wall.removeLast()
            hand.append(tsumo)
            print(tsumo.string)
        }
        
        
        
        
        leftWallCountLabel.frame = CGRect(x: 30, y: 100, width: 100, height: 50)
        leftWallCountLabel.text = String(format: "のこり:%d", tiles.wall.count)
        tsumoCountLabel.frame = CGRect(x: 150, y: 100, width: 100, height: 50)
        tsumoCountLabel.text = String(format: "つも:%d", 136 - (hand.count + tiles.wall.count))
        self.view.addSubview(leftWallCountLabel)
        self.view.addSubview(tsumoCountLabel)
        
        resetButton.frame = CGRect(x: 30, y: 200, width: 100, height: 50)
        resetButton.setTitle("Reset", forState: .Normal)
        resetButton.backgroundColor = .greenColor()
        resetButton.addTarget(self, action: #selector(ViewController.resetWall), forControlEvents: .TouchUpInside)
        self.view.addSubview(resetButton)
        
        
        
        
        
        // test
        let image = UIImage(named: "ji7-66-90-s-emb.png")
        let w = (view.bounds.size.width - (14 * 2) - (2 * 2)) / 14
        let h = w / (image?.size.width)! * (image?.size.height)!
        print(w, image?.size.width, image?.size.height, h)
        
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
        print("Selected \(indexPath.row)")
        
        if tiles.wall.count == 0 {
            resetWall()
        }
        
        hand.removeAtIndex(indexPath.row)
        let tsumo = tiles.wall.removeLast()
//        hand.insert(tsumo, atIndex: indexPath.row)
        hand.insert(tsumo, atIndex: hand.count)
        
        
        leftWallCountLabel.text = String(format: "のこり:%d", tiles.wall.count)
        tsumoCountLabel.text = String(format: "つも:%d", 136 - (hand.count + tiles.wall.count))
        
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        let image = UIImage(named: tsumo.image)
        let imageView = UIImageView(image: image)
        imageView.frame = cell!.bounds
        // blur effect
//        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
//        blurView.alpha = 0.2
//        blurView.frame = imageView.bounds
//        imageView.addSubview(blurView)
        
        cell!.contentView.addSubview(imageView)
        
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return handCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = .grayColor()
        
        let image = UIImage(named: hand[indexPath.row].image)
        let imageView = UIImageView(image: image)
        imageView.frame = cell.bounds
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    func drawFromWall() {
    }
    
    func resetWall() {
        tiles = Tiles()
        hand = []
        for _ in 0 ..< handCount {
            let tsumo = tiles.wall.removeLast()
            hand.append(tsumo)
            print(tsumo.string)
        }
        
        leftWallCountLabel.text = String(format: "のこり:%d", tiles.wall.count)
        tsumoCountLabel.text = String(format: "つも:%d", 136 - (hand.count + tiles.wall.count))
        
        // reset collection view
        collectionView.reloadData()
    }

}

