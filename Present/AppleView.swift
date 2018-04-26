//
//  AppleView.swift
//  Present
//
//  Created by You Tu on 2018/4/26.
//  Copyright © 2018年 You Tu. All rights reserved.
//

import UIKit

class AppleView: GradientView, PieceViewProtocol {

    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView = imageView
    }
    
    override func layoutSubviews() {
        let length: CGFloat = 100
        gradient.frame = CGRect(x: (self.frame.width - length) / 2, y: (self.frame.height - length) / 2 - length / 2, width: length, height: length);
        imageView.frame = gradient.bounds
    }
    
    var piece: Piece? {
        didSet {
            refresh()
        }
    }
    
    func refresh() {
        super.gradienting()
        imageView.image = UIImage.init(named: (piece?.image)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
