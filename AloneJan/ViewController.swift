//
//  ViewController.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/22.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var tiles = Tiles()
    var hand = [Tile]()
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for _ in 0 ..< 13 {
            let tsumo = tiles.wall.removeLast()
            hand.append(tsumo)
            print(tsumo.string)
        }
        
        
        
        let screenWidth = Double(UIScreen.mainScreen().bounds.size.width)
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
        
        print("bfr tiles.wall.count: \(tiles.wall.count)")
        print("bfr hand.count: \(hand.count)")
        hand.removeAtIndex(indexPath.row)
        let tsumo = tiles.wall.removeLast()
        hand.insert(tsumo, atIndex: indexPath.row)
        print("afr tiles.wall.count: \(tiles.wall.count)")
        print("afr hand.count: \(hand.count)")
        
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        let image = UIImage(named: tsumo.image)
        let imageView = UIImageView(image: image)
        imageView.layer.borderColor = UIColor.blueColor().CGColor
        imageView.backgroundColor = .blueColor()
        
        cell?.contentView.addSubview(imageView)
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

}

