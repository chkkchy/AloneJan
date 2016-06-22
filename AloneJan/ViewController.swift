//
//  ViewController.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/22.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

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
        
        
        
        for _ in 0 ..< 13 {
            let tsumo = tiles.wall.removeLast()
            hand.append(tsumo)
            print(tsumo.string)
        }
        
        
        
        
        leftWallCountLabel.frame = CGRect(x: 30, y: 30, width: 100, height: 50)
        leftWallCountLabel.text = String(format: "のこり:%d", tiles.wall.count)
        tsumoCountLabel.frame = CGRect(x: 150, y: 30, width: 100, height: 50)
        tsumoCountLabel.text = String(format: "つも:%d", 136 - (hand.count + tiles.wall.count))
        self.view.addSubview(leftWallCountLabel)
        self.view.addSubview(tsumoCountLabel)
        
        resetButton.frame = CGRect(x: 30, y: 100, width: 100, height: 50)
        resetButton.setTitle("Reset", forState: .Normal)
        resetButton.backgroundColor = .greenColor()
        resetButton.addTarget(self, action: #selector(ViewController.resetWall), forControlEvents: .TouchUpInside)
        self.view.addSubview(resetButton)
        
        
        
        
        
        let w = (view.bounds.size.width - (13 * 2) - (2 * 2)) / 13
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(w, 50)
        layout.minimumInteritemSpacing = 2.0
        layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.frame = CGRect(x: 0, y: 500, width: screenWidth, height: 100)
        collectionView.layer.borderColor = UIColor.grayColor().CGColor
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
        imageView.layer.borderColor = UIColor.blueColor().CGColor
        imageView.backgroundColor = .blueColor()
        // blur effect
//        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
//        blurView.alpha = 0.2
//        blurView.frame = imageView.bounds
//        imageView.addSubview(blurView)
        
        cell?.contentView.addSubview(imageView)
        
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = .grayColor()
        
        let image = UIImage(named: hand[indexPath.row].image)
        let imageView = UIImageView(image: image)
        imageView.layer.borderColor = UIColor.redColor().CGColor
        imageView.backgroundColor = .redColor()
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    func drawFromWall() {
    }
    
    func resetWall() {
        tiles = Tiles()
        hand = []
        for _ in 0 ..< 13 {
            let tsumo = tiles.wall.removeLast()
            hand.append(tsumo)
            print(tsumo.string)
        }
        
        // reset collection view
        collectionView.reloadData()
    }

}

