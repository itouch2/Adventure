//
//  GradientView.swift
//  Present
//
//  Created by You Tu on 2018/4/23.
//  Copyright © 2018年 You Tu. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    let gradient = CAGradientLayer()
    var colors: Array<Any>?
    var locations: Array<NSNumber>
    var endPoint: CGPoint
    var startPoint: CGPoint
    
    var contentView: UIView? {
        didSet {
            gradient.mask = contentView?.layer
        }
    }
    
    override init(frame: CGRect) {
        locations = []
        endPoint = .zero
        startPoint = .zero
        
        super.init(frame: frame)
        
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor("#CC7BFF").cgColor, UIColor("#FF2969").cgColor]
        layer.addSublayer(gradient)
        
        gradient.mask = contentView?.layer
    }
    
    override func layoutSubviews() {
        gradient.frame = bounds
    }
    
    func gradienting() {
        let animation = CABasicAnimation.init(keyPath: "colors")
        animation.fromValue = gradient.colors
        let toColors = [UIColor("#FF2969").cgColor, UIColor("#FFC00C").cgColor]
        animation.toValue = toColors
        animation.duration = 1.8
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        gradient.add(animation, forKey:"animateGradient")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
