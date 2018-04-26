//
//  AppView.swift
//  Present
//
//  Created by You Tu on 2018/4/24.
//  Copyright © 2018年 You Tu. All rights reserved.
//

import UIKit
import LTMorphingLabel
import SnapKit

class AppView: UIView, PieceViewProtocol {

    var imageView: UIImageView = UIImageView()
    var label = GradientLabel.init(type: .morpha)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(230)
            make.width.equalTo(105)
            make.height.equalTo(105)
        }
        
        label.backgroundColor = UIColor.clear
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(120)
        }
    }
    
    var piece: Piece? {
        didSet {
            refresh()
        }
    }
    
    func refresh() -> Void {
        let travelImage = UIImage.init(named: (piece?.image)!)
        if piece?.appType == .shake {
            self.shakeTheLogo()
            (label.label as! LTMorphingLabel).morphingEffect = .sparkle
        } else {
            (label.label as! LTMorphingLabel).morphingEffect = .fall
        }
        
        UIView.transition(with: imageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: { self.imageView.image = travelImage },
                          completion: nil)
        
        label.text = piece?.words
        label.color = piece?.color
    }
    
    func shakeTheLogo() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 1.5
        animation.values = [0, -8.0, -20.0, 20.0, -18.0, 18.0, -15.0, 15.0, -12.0, 12.0, -8.0, 8.0, -5.0, 5.0, 0.0 ]
        imageView.layer.add(animation, forKey: "shake")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHidden: Bool {
        didSet {
            if self.isHidden {
                imageView.image = nil
                label.text = nil
            }
        }
    }
}
