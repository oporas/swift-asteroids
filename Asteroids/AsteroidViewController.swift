//
//  AsteroidViewController.swift
//  Asteroids
//
//  Created by ooras on 09/05/2017.
//  Copyright © 2017 op. All rights reserved.
//

import UIKit

class AsteroidViewController: UIViewController {
    
    
    private var asteroidField: AsteroidFieldView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initializeIfNeeded()
    }
    
    private func initializeIfNeeded() {
        if asteroidField == nil {
            asteroidField = AsteroidFieldView(frame: CGRect(center: view.bounds.mid, size: view.bounds.size))
            view.addSubview(asteroidField)
            asteroidField.addAsteroids(count: Constants.initialAsteroidCount)
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        asteroidField?.center = view.bounds.mid
    }
    
    private struct Constants {
        static let initialAsteroidCount = 20
        static let shipBoundaryName = "Ship"
        static let shipSizetoMinBoundsEdgeRatio: CGFloat = 1/5
        static let asteroidFieldMagnitude: CGFloat = 10
        static let normalizedDistanceOfShipFromEdge: CGFloat = 0.2
        static let burnAcceleration: CGFloat = 0.07
        
        struct Shield {
            static let duration: TimeInterval = 1.0
            static let updateInterval: TimeInterval = 0.2
            static let regenerationRate: Double = 5
            static let activationCost: Double = 15
            static var regenerationPerUpdate: Double {
                return Constants.Shield.regenerationRate * Constants.Shield.updateInterval
            }
            static var activationCostPerUpdate: Double {
                return Constants.Shield.activationCost / (Constants.Shield.duration/Constants.Shield.updateInterval)
            }
        }
        
//        static let defaultShipDirection: [UIInterfaceOrientation: CGFloat] = []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

