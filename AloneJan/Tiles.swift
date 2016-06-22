//
//  Tiles.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/22.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import Foundation

class Tiles {
    
    static let tiles = [
        Tile(type: TileType.Honours, string: "東", image: "ji1-66-90-s-emb.png", number: nil),
        Tile(type: TileType.Honours, string: "南", image: "ji2-66-90-s-emb.png", number: nil),
        Tile(type: TileType.Honours, string: "西", image: "ji3-66-90-s-emb.png", number: nil),
        Tile(type: TileType.Honours, string: "北", image: "ji4-66-90-s-emb.png", number: nil),
        Tile(type: TileType.Honours, string: "発", image: "ji5-66-90-s-emb.png", number: nil),
        Tile(type: TileType.Honours, string: "白", image: "ji6-66-90-s-emb.png", number: nil),
        Tile(type: TileType.Honours, string: "中", image: "ji7-66-90-s-emb.png", number: nil),
        Tile(type: TileType.Circles, string: "①", image: "pin1-66-90-s-emb.png", number: 1),
        Tile(type: TileType.Circles, string: "②", image: "pin2-66-90-s-emb.png", number: 2),
        Tile(type: TileType.Circles, string: "③", image: "pin3-66-90-s-emb.png", number: 3),
        Tile(type: TileType.Circles, string: "④", image: "pin4-66-90-s-emb.png", number: 4),
        Tile(type: TileType.Circles, string: "⑤", image: "pin5-66-90-s-emb.png", number: 5),
        Tile(type: TileType.Circles, string: "⑥", image: "pin6-66-90-s-emb.png", number: 6),
        Tile(type: TileType.Circles, string: "⑦", image: "pin7-66-90-s-emb.png", number: 7),
        Tile(type: TileType.Circles, string: "⑧", image: "pin8-66-90-s-emb.png", number: 8),
        Tile(type: TileType.Circles, string: "⑨", image: "pin9-66-90-s-emb.png", number: 9),
        Tile(type: TileType.Bamboos, string: "1", image: "sou1-66-90-s-emb.png", number: 1),
        Tile(type: TileType.Bamboos, string: "2", image: "sou2-66-90-s-emb.png", number: 2),
        Tile(type: TileType.Bamboos, string: "3", image: "sou3-66-90-s-emb.png", number: 3),
        Tile(type: TileType.Bamboos, string: "4", image: "sou4-66-90-s-emb.png", number: 4),
        Tile(type: TileType.Bamboos, string: "5", image: "sou5-66-90-s-emb.png", number: 5),
        Tile(type: TileType.Bamboos, string: "6", image: "sou6-66-90-s-emb.png", number: 6),
        Tile(type: TileType.Bamboos, string: "7", image: "sou7-66-90-s-emb.png", number: 7),
        Tile(type: TileType.Bamboos, string: "8", image: "sou8-66-90-s-emb.png", number: 8),
        Tile(type: TileType.Bamboos, string: "9", image: "sou9-66-90-s-emb.png", number: 9),
        Tile(type: TileType.Characters, string: "一", image: "man1-66-90-s-emb.png", number: 1),
        Tile(type: TileType.Characters, string: "二", image: "man2-66-90-s-emb.png", number: 2),
        Tile(type: TileType.Characters, string: "三", image: "man3-66-90-s-emb.png", number: 3),
        Tile(type: TileType.Characters, string: "四", image: "man4-66-90-s-emb.png", number: 4),
        Tile(type: TileType.Characters, string: "五", image: "man5-66-90-s-emb.png", number: 5),
        Tile(type: TileType.Characters, string: "六", image: "man6-66-90-s-emb.png", number: 6),
        Tile(type: TileType.Characters, string: "七", image: "man7-66-90-s-emb.png", number: 7),
        Tile(type: TileType.Characters, string: "八", image: "man8-66-90-s-emb.png", number: 8),
        Tile(type: TileType.Characters, string: "九", image: "man9-66-90-s-emb.png", number: 9)
    ]
    
    var wall = [Tile]()
    
    init() {
        for _ in 0..<4 {
            self.wall += Tiles.tiles
        }
        ArrayUtils.shuffle(&wall)
    }
    
}
