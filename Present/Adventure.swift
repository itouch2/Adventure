//
//  Adventure.swift
//  Present
//
//  Created by You Tu on 2018/4/22.
//  Copyright © 2018年 You Tu. All rights reserved.
//

import UIKit
import LTMorphingLabel
import SnapKit
import AVFoundation

class Adventure: UIViewController {
    
    var index = 0
    
    var pieces: Array<Piece> = []
    var pieceMapping = [PieceType: PieceViewProtocol]()
    
    var travel = TravelView()
    var app = AppView()
    var cook = CookView()
    var piece = PieceView()
    var apple = AppleView()
    
    var player = AVAudioPlayer.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        prepare()
        play()
        next()
    }
    
    func prepare() {
        let diaryList: String = Bundle.main.path(forResource: "adventure", ofType:"plist")!
        let data: NSArray = NSArray(contentsOfFile:diaryList)!
        
        for word in data {
            let pieceInfo: NSDictionary = word as! NSDictionary
            let piece = Piece.init(dict: pieceInfo)
            pieces.append(piece)
        }
        
        pieceMapping = [PieceType.travel: travel,
                        PieceType.cook: cook,
                        PieceType.app: app,
                        PieceType.piece: piece,
                        PieceType.apple: apple]
        
        for (_, element) in pieceMapping {
            let pieceView = element as! UIView
            view.addSubview(pieceView)
            pieceView.snp.makeConstraints { (make) in
                make.left.equalToSuperview()
                make.top.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
    }
    
    func play() {
        let path = Bundle.main.path(forResource: "On-Our-Way", ofType:"mp3")
        guard let resource = path else {
            return
        }
        let url = URL(fileURLWithPath: resource)
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player.play()
        } catch {
            print("couldn't load file :(")
        }
    }
    
    func next() {
        if index >= pieces.count{
            index = 0
        }
        
        let piece = pieces[index]
        for (key, element) in pieceMapping {
            let pieceView = element as! UIView
            pieceView.isHidden = !(key == piece.type)
        }
        
        var pieceView = pieceMapping[piece.type!]
        pieceView?.piece = piece
        index += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + piece.duration) {
            self.next()
        }
    }
}

