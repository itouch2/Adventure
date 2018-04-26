//
//  GradientLabel.swift
//  Present
//
//  Created by You Tu on 2018/4/22.
//  Copyright © 2018年 You Tu. All rights reserved.
//

import UIKit
import SnapKit
import LTMorphingLabel

enum GradientLabelType {
    case normal
    case morpha
    case shimmer
}

class GradientLabel: GradientView {
    var type: GradientLabelType?
    init(type: GradientLabelType) {
        super.init(frame: CGRect.zero)
        
        self.type = type
        switch type {
        case .normal:
            label = UILabel()
        case .morpha:
            label = LTMorphingLabel()
            (label as! LTMorphingLabel).morphingEffect = .fall
            self.addSubview(label)
            label.removeFromSuperview()
        default:
            label = UILabel()
        }
        
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        
        contentView = label
    }

    var label: UILabel = UILabel()
    
    override func layoutSubviews() {
        gradient.frame = self.bounds
        label.frame = self.bounds
    }
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    var color: UIColor? {
        didSet {
            gradient.colors = nil
            gradient.backgroundColor = self.color?.cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

