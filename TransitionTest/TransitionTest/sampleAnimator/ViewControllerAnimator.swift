//
//  ViewControllerAnimator.swift
//  TransitionTest
//
//  Created by Lina Pischenko on 8/29/18.
//  Copyright © 2018 PischenkoLina. All rights reserved.
//

import UIKit

// MARK: - State

 enum ViewState {
    case fullsize
    case thumbnail
}

class ViewControllerAnimator: NSObject {
    
    let minEndingDistance  = UIScreen.main.bounds.size.height / 6

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sampleView: UIImageView!
    @IBOutlet weak var sampleLabel: UILabel!
    @IBOutlet weak var panGestureRecognizer: UIPanGestureRecognizer!
    
    var animator:UIViewPropertyAnimator?
    var currentState:ViewState!
    var thumbnailFrame:CGRect!// initial state rect
    
    // MARK: Public functions
    public func initialSetup() {
        thumbnailFrame = sampleView.frame
        currentState = .thumbnail
    }
    
    public func didChangeOrientation(orientation: UIDeviceOrientation) {
        thumbnailFrame = sampleView.frame
    }
    
    // MARK: Action
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: sampleView.superview)
        
        switch recognizer.state {
        case .began:
            startAnimation()
        case .changed:
            move(translation: translation)
        case .ended:
            let velocity = recognizer.velocity(in: sampleView.superview)
            endAnimation(translation: translation, velocity: velocity)
            
        default:
              break
        }
    }
    
    func startAnimation() {
        
        var fullsizeFrame:CGRect = CGRect()
        
        switch currentState {
        case .fullsize:
            fullsizeFrame = thumbnailFrame
        case .thumbnail:
            fullsizeFrame = mainView.frame
        default:
              break
        }
        
        animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.8, animations: {
            self.sampleView.frame = fullsizeFrame
        })
    }
    
    func move (translation:CGPoint) {
        if let animator = self.animator {
            let yTranslation = mainView.center.y + translation.y
            
            var progress:CGFloat = 0
            
            switch currentState {
            case .thumbnail:
                progress = 1 - (yTranslation / mainView.center.y)
            case .fullsize:
                progress = (yTranslation / mainView.center.y) - 1
            default:
                  break
            }
            
            progress = max(0.0001, min(0.9999, progress))//need hold progress 0>progress<1 - for not and animation
            animator.fractionComplete = progress
        }
    }
    
    func endAnimation (translation:CGPoint, velocity:CGPoint) {
        
        if let animator = self.animator {
            panGestureRecognizer.isEnabled = false //turn off gestureRecognizer for and animation-
            
            switch currentState {
            case .thumbnail:
                if translation.y <= -minEndingDistance  || velocity.y <= -minEndingDistance {
                    animator.isReversed = false
                    animator.addCompletion({ (position:UIViewAnimatingPosition) in
                        self.currentState = .fullsize
                        self.panGestureRecognizer.isEnabled = true
                    })
                }else {
                    animator.isReversed = true
                    animator.addCompletion({ (position:UIViewAnimatingPosition) in
                        self.currentState = .thumbnail
                        self.panGestureRecognizer.isEnabled = true
                    })
                }
            case .fullsize:
                if translation.y >= minEndingDistance || velocity.y >= minEndingDistance {
                    animator.isReversed = false
                    animator.addCompletion({ (position:UIViewAnimatingPosition) in
                        self.currentState = .thumbnail
                        self.panGestureRecognizer.isEnabled = true
                    })
                }else {
                    animator.isReversed = true
                    animator.addCompletion({ (position:UIViewAnimatingPosition) in
                        self.currentState = .fullsize
                        self.panGestureRecognizer.isEnabled = true
                    })
                }
            default:
                 break
            }
            
            let vector = CGVector(dx: velocity.x / 100, dy: velocity.y / 100)
            let spgingParameters = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: vector)
            
            animator.continueAnimation(withTimingParameters: spgingParameters, durationFactor: 1)
        }
    }
    
}
