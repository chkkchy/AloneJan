//
//  Field.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/23.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import Foundation

class Field {
    
    static let tiles = [
        Tile(type: .Honours, string: "東", image: "ji1-66-90-s-emb.png", number: 1),
        Tile(type: .Honours, string: "南", image: "ji2-66-90-s-emb.png", number: 2),
        Tile(type: .Honours, string: "西", image: "ji3-66-90-s-emb.png", number: 3),
        Tile(type: .Honours, string: "北", image: "ji4-66-90-s-emb.png", number: 4),
        Tile(type: .Honours, string: "発", image: "ji5-66-90-s-emb.png", number: 5),
        Tile(type: .Honours, string: "白", image: "ji6-66-90-s-emb.png", number: 6),
        Tile(type: .Honours, string: "中", image: "ji7-66-90-s-emb.png", number: 7),
        Tile(type: .Circles, string: "①", image: "pin1-66-90-s-emb.png", number: 1),
        Tile(type: .Circles, string: "②", image: "pin2-66-90-s-emb.png", number: 2),
        Tile(type: .Circles, string: "③", image: "pin3-66-90-s-emb.png", number: 3),
        Tile(type: .Circles, string: "④", image: "pin4-66-90-s-emb.png", number: 4),
        Tile(type: .Circles, string: "⑤", image: "pin5-66-90-s-emb.png", number: 5),
        Tile(type: .Circles, string: "⑥", image: "pin6-66-90-s-emb.png", number: 6),
        Tile(type: .Circles, string: "⑦", image: "pin7-66-90-s-emb.png", number: 7),
        Tile(type: .Circles, string: "⑧", image: "pin8-66-90-s-emb.png", number: 8),
        Tile(type: .Circles, string: "⑨", image: "pin9-66-90-s-emb.png", number: 9),
        Tile(type: .Bamboos, string: "1", image: "sou1-66-90-s-emb.png", number: 1),
        Tile(type: .Bamboos, string: "2", image: "sou2-66-90-s-emb.png", number: 2),
        Tile(type: .Bamboos, string: "3", image: "sou3-66-90-s-emb.png", number: 3),
        Tile(type: .Bamboos, string: "4", image: "sou4-66-90-s-emb.png", number: 4),
        Tile(type: .Bamboos, string: "5", image: "sou5-66-90-s-emb.png", number: 5),
        Tile(type: .Bamboos, string: "6", image: "sou6-66-90-s-emb.png", number: 6),
        Tile(type: .Bamboos, string: "7", image: "sou7-66-90-s-emb.png", number: 7),
        Tile(type: .Bamboos, string: "8", image: "sou8-66-90-s-emb.png", number: 8),
        Tile(type: .Bamboos, string: "9", image: "sou9-66-90-s-emb.png", number: 9),
        Tile(type: .Characters, string: "一", image: "man1-66-90-s-emb.png", number: 1),
        Tile(type: .Characters, string: "二", image: "man2-66-90-s-emb.png", number: 2),
        Tile(type: .Characters, string: "三", image: "man3-66-90-s-emb.png", number: 3),
        Tile(type: .Characters, string: "四", image: "man4-66-90-s-emb.png", number: 4),
        Tile(type: .Characters, string: "五", image: "man5-66-90-s-emb.png", number: 5),
        Tile(type: .Characters, string: "六", image: "man6-66-90-s-emb.png", number: 6),
        Tile(type: .Characters, string: "七", image: "man7-66-90-s-emb.png", number: 7),
        Tile(type: .Characters, string: "八", image: "man8-66-90-s-emb.png", number: 8),
        Tile(type: .Characters, string: "九", image: "man9-66-90-s-emb.png", number: 9)
    ]
    
    let deadStackCount = 14
    
    var round: WindType!
    
    var hand: Int
    
    var honba: Int
    
    var deposit: Int
    
    var stack: [Tile]
    
    var deadStack: [Tile]
    
    var dora: Tile
    
    var players: [Player]
    
//    var isTerminalOfStack: Bool {
//        return stack.count == deadStackCount
//    }
    
    init() {
        round = WindType(rawValue: Int(arc4random_uniform(UInt32(2))) + 1)
        hand = Int(arc4random_uniform(UInt32(4))) + 1
        honba = Int(arc4random_uniform(UInt32(3)))
        deposit = (Int(arc4random_uniform(UInt32(3)))) * 1000
        stack = []
        for _ in 0..<4 {
            stack += Field.tiles
        }
        ArrayUtils.shuffle(&stack)
        deadStack = Array(stack[1...deadStackCount])
        stack[1...deadStackCount] = []
        dora = deadStack.first!
        players = [
            Player(wind: .East),
            Player(wind: .South),
            Player(wind: .West),
            Player(wind: .North)
        ]
        for player in players {
            let drawCount = 13 // TODO: as default def?
            player.drawFrom(&stack, count: drawCount)
        }
        stirPlayersPoint()
    }
    
    private func stirPlayersPoint() {
        for i in 1...30 {
            let pt = i * 100
            var rnds = [Int](0..<4)
            ArrayUtils.shuffle(&rnds)
            let from = players[rnds.removeLast()]
            let to = players[rnds.removeLast()]
            from.point -= pt
            to.point += pt
        }
        players[Int(arc4random_uniform(UInt32(3)))].point -= deposit
    }
    
}