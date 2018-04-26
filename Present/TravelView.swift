//
//  TravelView.swift
//  Present
//
//  Created by You Tu on 2018/4/23.
//  Copyright © 2018年 You Tu. All rights reserved.
//

import UIKit
import SnapKit

class TravelView: UIView, PieceViewProtocol {

    var imageView: UIImageView = UIImageView()
    var label: UILabel = UILabel()
    var maskedLabel: UILabel = RSMaskedLabel()
    
    var vibrancyEffectView: UIVisualEffectView?
    var topConstraint: Constraint?
    var bottomConstraint: Constraint?
    var centerConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let vibrancyEffect = UIVibrancyEffect.init(blurEffect: blurEffect)
        vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        addSubview(vibrancyEffectView!)
        vibrancyEffectView!.snp.makeConstraints { (make) in
            topConstraint = make.top.equalTo(60).constraint
            bottomConstraint = make.bottom.equalTo(-150).constraint
            centerConstraint = make.centerY.equalToSuperview().constraint
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        topConstraint?.deactivate()
        centerConstraint?.deactivate()

        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Light", size: 22)
        label.textColor = UIColor.white
        vibrancyEffectView!.contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        maskedLabel.backgroundColor = UIColor.init(white: 1, alpha: 0.55)
        maskedLabel.layer.cornerRadius = 6
        maskedLabel.textAlignment = .center
        maskedLabel.font = label.font
        addSubview(maskedLabel)
        maskedLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
    }
    
    var piece: Piece? {
        didSet {
            refresh()
        }
    }
    
    var i = 0
    func refresh() -> Void {
        // refresh the image
        let travelImage = UIImage.init(named: (piece?.image)!)
        UIView.transition(with: imageView,
                          duration: 0.65,
                          options: .transitionCrossDissolve,
                          animations: { self.imageView.image = travelImage },
                          completion: nil)
        
        // refresh the text
        if let travelType = piece?.travelType {
            switch travelType {
            case .top:
                topConstraint?.activate()
                centerConstraint?.deactivate()
                bottomConstraint?.deactivate()
                label.isHidden = false
                maskedLabel.isHidden = true
            case .center:
                centerConstraint?.activate()
                bottomConstraint?.deactivate()
                topConstraint?.deactivate()
                label.isHidden = true
                maskedLabel.isHidden = false
            case .bottom:
                topConstraint?.deactivate()
                centerConstraint?.deactivate()
                bottomConstraint?.activate()
                label.isHidden = false
                maskedLabel.isHidden = true
            }
        }
        
        label.text = piece?.words
        maskedLabel.text = piece?.words
        
        UIView.animate(withDuration: 1.5) {
            self.i += 1
            let x: CGFloat = ((self.i % 2 == 0) ? 1 : -1) * 35
            self.imageView.center = CGPoint(x: self.imageView.center.x + x, y: self.imageView.center.y)
            
            self.vibrancyEffectView?.center = CGPoint(x: (self.vibrancyEffectView?.center.x)! + x / 2.5, y: (self.vibrancyEffectView?.center.y)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHidden: Bool {
        didSet {
            if isHidden {
                imageView.image = nil
            }
        }
    }
}
