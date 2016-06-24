//
//  SettingViewController.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/24.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    
    var switchArray = [UISwitch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "設定"
//        self.view.backgroundColor = .grayColor()
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        for type in TileType.allValues {
            let tileTypeSwitch = UISwitch()
            tileTypeSwitch.tag = type.rawValue
//            tileTypeSwitch.tintColor = UIColor.blackColor()
//            tileTypeSwitch.onTintColor = UIColor.redColor()
//            tileTypeSwitch.thumbTintColor = UIColor.blackColor()
//            tileTypeSwitch.backgroundColor = UIColor.yellowColor()
            tileTypeSwitch.on = true
            tileTypeSwitch.addTarget(self, action: #selector(SettingViewController.tileTypeSwitched), forControlEvents: .ValueChanged)
            switchArray.append(tileTypeSwitch)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return switchArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(format: "%@を有効にする", TileType(rawValue: indexPath.row + 1)!.description)
//        cell.contentView.addSubview(switchArray[indexPath.row])
        cell.accessoryView = switchArray[indexPath.row]
        return cell
    }
    
    func tileTypeSwitched(sender: UISwitch) {
        print("sender.tag:", sender.tag, "sender.on:", sender.on)
    }
    
}
