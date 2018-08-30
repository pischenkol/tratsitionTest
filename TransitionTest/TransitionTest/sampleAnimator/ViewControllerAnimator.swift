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
        var endLabelPosition:CGPoint = CGPoint()
        
        switch currentState {
        case .fullsize:
            fullsizeFrame = thumbnailFrame
            endLabelPosition = CGPoint.init(x: 70, y: self.mainView.frame.height - 50)
        case .thumbnail:
            fullsizeFrame = mainView.frame
            endLabelPosition = CGPoint.init(x: self.mainView.center.x, y: 50)
        default:
            break
        }
        
        animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.8, animations: {
            self.sampleView.frame = fullsizeFrame
            UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeCubic], animations: {
                switch self.currentState {
                case .fullsize:
                    self.keyFrameLabelAnimation(endViewPosition: endLabelPosition)
                case .thumbnail:
                    self.keyFrameLabelAnimation(endViewPosition: endLabelPosition)
                default:
                    break
                }
            })
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
            
            progress = max(0.0001, min(0.9999, progress))//need hold progress 0>progress<1 - for not end animation
            animator.fractionComplete = progress
        }
    }
    
    func endAnimation (translation:CGPoint, velocity:CGPoint) {
        
        if let animator = self.animator {
            
            switch currentState {
            case .thumbnail:
                currentState = translation.y >= minEndingDistance ? .thumbnail : .fullsize
            case .fullsize:
                  currentState = translation.y >= minEndingDistance ? .thumbnail : .fullsize
            default:
                break
            }
            
            let vector = CGVector(dx: velocity.x / 100, dy: velocity.y / 100)
            let spgingParameters = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: vector)
            
            animator.continueAnimation(withTimingParameters: spgingParameters, durationFactor: 1)
        }
    }
    
    func  keyFrameLabelAnimation (endViewPosition: CGPoint) {
        
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {
            self.sampleLabel.center = CGPoint(x: 200, y: 500)
            self.sampleLabel.textColor = .green
        })
        
        UIView.addKeyframe(withRelativeStartTime: 0.31, relativeDuration: 0.3, animations: {
            self.sampleLabel.center = CGPoint(x: 300, y: self.mainView.center.y)
            self.sampleLabel.textColor = .blue
        })
        
        UIView.addKeyframe(withRelativeStartTime: 0.61, relativeDuration: 0.39, animations: {
            self.sampleLabel.center = CGPoint(x: endViewPosition.x, y: endViewPosition.y)
            self.sampleLabel.textColor = .green
        })
        
    }
}
