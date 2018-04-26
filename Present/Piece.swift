//
//  Piece.swift
//  Present
//
//  Created by You Tu on 2018/4/23.
//  Copyright © 2018年 You Tu. All rights reserved.
//

import Foundation

enum PieceMorphaLabelType: Int {
    case scale = 0
    case evaporate
    case fall
    case pixelate
    case sparkle
    case burn
    case anvil
}

enum PieceLabelType: String {
    case normal
    case morpha
    case shimmer
}

enum PieceType: String {
    case piece
    case app
    case cook
    case travel
    case apple
}

enum PieceTravelType: String {
    case top
    case bottom
    case center
}

enum PieceAppType: String {
    case normal
    case shake
}

class Piece {
    var words: String?
    var type: PieceType?
    var labelType: PieceLabelType?
    var morphaLabelType: PieceMorphaLabelType = .scale
    var colors: Array<Any>?
    var image: String?
    var color: UIColor?
    var travelType: PieceTravelType?
    var appType: PieceAppType = .normal
    var duration: Double = 1
    var fontSize: CGFloat = 32
    var offset: CGFloat = 0
    var alignment: NSTextAlignment = .left
    
    init(dict: NSDictionary) {
        words = dict["words"] as? String
        type = PieceType.init(rawValue: dict["type"] as! String)
        image = dict["imageName"] as? String
        labelType = PieceLabelType.init(rawValue: dict["labelType"] as! String)
        
        if let optional = dict["color"] {
            color = UIColor(optional as! String)
        }
        if let optional = dict["travelType"] as? String {
            travelType = PieceTravelType.init(rawValue: optional)
        }
        if let optional = dict["duration"] as? Double {
            duration = optional
        }
        if let optional = dict["fontSize"] as? CGFloat {
            fontSize = optional
        }
        if let optional = dict["appType"] as? String {
            appType = PieceAppType.init(rawValue: optional)!
        }
        if let optional = dict["morphaLabelType"] as? Int {
            morphaLabelType = PieceMorphaLabelType.init(rawValue: optional)!
        }
        if let optional = dict["offset"] as? CGFloat {
            offset = optional
        }
        if let optional = dict["alignment"] as? String {
            alignment = (optional == "left") ? .left : .right
        }
    }
}
