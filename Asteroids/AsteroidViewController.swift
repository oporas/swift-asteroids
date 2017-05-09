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
    private var ship: SpaceshipView!
    
    private var asteroidBehavior = AsteroidBehavior()
    
    private lazy var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: self.asteroidField)

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initializeIfNeeded()
        animator.addBehavior(asteroidBehavior)
        asteroidBehavior.pushAllAsteroids()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animator.removeBehavior(asteroidBehavior)
    }
    
    private func initializeIfNeeded() {
        if asteroidField == nil {
            asteroidField = AsteroidFieldView(frame: CGRect(center: view.bounds.mid, size: view.bounds.size))
            view.addSubview(asteroidField)
            let shipSize = view.bounds.size.minEdge * Constants.shipSizetoMinBoundsEdgeRatio
            ship = SpaceshipView(frame: CGRect(squareCenteredAt: asteroidField.center, size: shipSize))
            view.addSubview(ship)
            repositionShip()
            asteroidField.addAsteroids(count: Constants.initialAsteroidCount)
            asteroidField.asteroidBehavior = asteroidBehavior
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        asteroidField?.center = view.bounds.mid
        repositionShip()
    }
    
    private func repositionShip() {
        if asteroidField != nil {
            ship.center = asteroidField.center
            //Activate shield when ship hits an asteroid
            asteroidBehavior.setBoundary(ship.shieldBoundary(in: asteroidField), named: Constants.shipBoundaryName) {
                [weak self] in
                if let ship = self?.ship {
                    if !ship.shieldIsActive {
                    ship.shieldIsActive = true
                    ship.shieldLevel -= Constants.Shield.activationCost // Remove shields hitpoints
                    // Deactivate shield after duration (From Constants.Shield)
                    Timer.scheduledTimer(withTimeInterval: Constants.Shield.duration, repeats: false) { timer in
                        ship.shieldIsActive = false
                        // Autoress ship for testing
                        if ship.shieldLevel == 0 {
                            ship.shieldLevel = 100
                            }
                        }
                    }
                }
            }
        }
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

