//
//  AsteroidFieldView.swift
//  Asteroids
//
//  Created by ooras on 09/05/2017.
//  Copyright © 2017 op. All rights reserved.
//

import UIKit

class AsteroidFieldView: UIView {

    var scale: CGFloat = 0.002
    var minAsteroidSize: CGFloat = 0.25
    var maxAsteroidSize: CGFloat = 2.00
    
    func addAsteroids(count: Int, exclusionZone: CGRect = CGRect.zero) {
        assert(!bounds.isEmpty, "can't add asteroids to an empty field")
        let averageAsteroidSize = bounds.size * scale
        for _ in 0..<count {
            let asteroid = AsteroidView()
            asteroid.frame.size = (asteroid.frame.size / (asteroid.frame.size.area / averageAsteroidSize.area)) * CGFloat.random(in: minAsteroidSize..<maxAsteroidSize)
            repeat {
                asteroid.frame.origin = bounds.randomPoint
            } while !exclusionZone.isEmpty && asteroid.frame.intersects(exclusionZone)
            addSubview(asteroid)
        }
    }

}
