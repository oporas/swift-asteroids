//
//  AsteroidView.swift
//  Asteroids
//
//  Created by ooras on 09/05/2017.
//  Copyright © 2017 op. All rights reserved.
//

import UIKit

class AsteroidView: UIImageView {
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        image = UIImage(named: "asteroid\((arc4random()%5)+1)")
        frame.size = image?.size ?? CGSize.zero
    }
}
