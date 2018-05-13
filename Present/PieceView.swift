//
//  PieceView.swift
//  Present
//
//  Created by You Tu on 2018/4/23.
//  Copyright © 2018年 You Tu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import LTMorphingLabel

class PieceView: UIView, PieceViewProtocol {
    
    let morphaLabel = GradientLabel.init(type: .morpha)
    let normalLabel = GradientLabel.init(type: .normal)
    
    override init(frame: CGRect) {
        locations = []
        endPoint = .zero
        startPoint = .zero
        
        super.init(frame: frame)
        
        // morpha label
        addSubview(morphaLabel)
        morphaLabel.snp.makeConstraints { (make) in
            make.top.equalTo(-120)
            make.bottom.equalToSuperview()
            make.left.equalTo(80)
            make.right.equalTo(-80)
        }
        morphaLabel.label.textAlignment = .center
        (morphaLabel.label as! LTMorphingLabel).morphingEffect = .scale
        
        // normal label
        addSubview(normalLabel)
        normalLabel.snp.makeConstraints { (make) in
            make.top.equalTo(-120)
            make.bottom.equalToSuperview()
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }
    }
    
    var colors: Array<Any>?
    var locations: Array<NSNumber>
    var endPoint: CGPoint
    var startPoint: CGPoint
    var text: String?
    var color: UIColor?
    
    var piece: Piece? {
        didSet {
            refresh()
        }
    }
    
    func refresh() -> Void {
        morphaLabel.isHidden = !(piece?.labelType == .morpha)
        normalLabel.isHidden = !(piece?.labelType == .normal)
        
        normalLabel.text = piece?.words
        normalLabel.label.font = normalLabel.label.font.withSize((piece?.fontSize)!)
        normalLabel.label.textAlignment = (piece?.alignment)!
        
        morphaLabel.text = piece?.words
        morphaLabel.label.font = morphaLabel.label.font.withSize((piece?.fontSize)!)
        (morphaLabel.label as! LTMorphingLabel).morphingEffect = LTMorphingEffect.init(rawValue: (piece?.morphaLabelType.rawValue)!)!

        print("%d", (morphaLabel.label as! LTMorphingLabel).morphingEffect)
        
        morphaLabel.gradienting()
        normalLabel.gradienting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHidden: Bool {
        didSet {
            if self.isHidden {
                morphaLabel.text = nil
                normalLabel.text = nil
            }
        }
    }
}
