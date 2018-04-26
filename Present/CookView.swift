//
//  CookView.swift
//  Present
//
//  Created by You Tu on 2018/4/24.
//  Copyright © 2018年 You Tu. All rights reserved.
//

import UIKit

class CookView: UIView, PieceViewProtocol {

    var imageView: UIImageView = UIImageView()
    var label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(180)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.width)
        }
        
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = UIColor.white
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(80)
        }
    }
    
    var piece: Piece? {
        didSet {
            refresh()
        }
    }
    
    func refresh() -> Void {
        let travelImage = UIImage.init(named: (piece?.image)!)
        UIView.transition(with: imageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: { self.imageView.image = travelImage },
                          completion: nil)
        label.text = piece?.words
        label.textColor = piece?.color
        
        label.snp.updateConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10 + (piece?.offset)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHidden: Bool {
        didSet {
            if self.isHidden {
                imageView.image = nil
            }
        }
    }
}
