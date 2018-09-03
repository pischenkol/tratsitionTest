//
//  Animatable.swift
//  tracTest
//
//  Created by Lina Pischenko on 8/31/18.
//  Copyright © 2018 PischenkoLina. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

enum ViewAnimation: Int {
    case backgroundColor = 0
    case backgroundMove
    case backgroundOpen
    case backgroundAbstraction
    case cornerRadius
    case borderRadius
    case gradient
    case outerShadow
    case height
    case textColor
    case textSize
    case textSpace
    case textMove
    case textShadow
    case textOpacity
    case textRainbow
    case textfieldMove
    case rotation
    case transform
    case scale
    case count
}

class Animator: NSObject {
    
    func applyAnimation (view: UIView, animatioIndex: ViewAnimation) {
        switch animatioIndex {
        case .backgroundColor:
            backgroundColorAnimation(view: view)
        case .backgroundMove:
            backgroundMoveAnimation(view: view)
        case .backgroundOpen:
            backgroundOpenAnimation(view: view)
        case .backgroundAbstraction:
            backgroundAbstractionAnimation(view: view)
        case .cornerRadius:
            cornerRadiusAnimation(view: view)
        case .borderRadius:
            borderRadiusAnimation(view: view)
        case .gradient:
            gradientShadowAnimation(view: view)
        case .outerShadow:
            outerShadowAnimation(view: view)
        case .height:
            heightAnimation(view: view)
        case .textColor:
            textColorAnimation(view: view)
        case .textSize:
            textSizeAnimation(view: view)
        case .textSpace:
            textSpaceAnimation(view: view)
        case .textMove:
            textMoveAnimation(view: view)
        case .textShadow:
            textShadowAnimation(view: view)
        case .textOpacity:
            textOpacityAnimation(view: view)
        case .textRainbow:
            textRainbowAnimation(view: view)
        case .textfieldMove:
            textfieldMoveAnimation(view: view)
        case .rotation:
            rotationAnimation(view: view)
        case .transform:
            transformAnimation(view: view)
        case .scale:
            scaleAnimation(view: view)
        default:
            break
        }
    }
    
    func backgroundColorAnimation (view: UIView) {
        
        let backgroundColor = view.backgroundColor
        
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeCubic], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.backgroundColor = .black
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                view.backgroundColor = backgroundColor
            })
        })
    }
    
    func backgroundMoveAnimation (view: UIView) {
        
        let imageView = UIImageView.init(frame: CGRect.init(x: view.frame.origin.x - view.frame.width, y: view.frame.origin.y - view.frame.height, width: view.frame.width * 4, height: view.frame.height * 4))
        
        imageView.image = #imageLiteral(resourceName: "background")
        imageView.contentMode = .scaleToFill
        
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeCubic], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.addSubview(imageView)
                imageView.center = CGPoint.init(x: view.center.x + view.frame.width, y: view.center.y + view.frame.height)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                imageView.center = CGPoint.init(x: view.center.x - view.frame.width, y: view.center.y - view.frame.height)
            })
            
        }, completion: { (success: Bool) in
            imageView.removeFromSuperview()
        })
    }
    
    func backgroundOpenAnimation (view: UIView) {
        
        let topImageView = UIImageView.init(frame: CGRect.init(x: view.frame.origin.x, y: view.frame.origin.y , width: view.frame.width , height: view.frame.height/2))
        topImageView.image = #imageLiteral(resourceName: "texture3")
        topImageView.contentMode = .scaleToFill
        
        let bottomImageView = UIImageView.init(frame: CGRect.init(x: view.frame.origin.x, y: view.frame.origin.y + view.center.y, width: view.frame.width, height: view.frame.height/2))
        bottomImageView.image = #imageLiteral(resourceName: "texture3")
        bottomImageView.contentMode = .scaleToFill
        
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.addSubview(topImageView)
                view.addSubview(bottomImageView)
                topImageView.center.y = view.center.y - view.frame.height
                bottomImageView.center.y = view.center.y + view.frame.height
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                topImageView.center.y = view.center.y + view.frame.height
                bottomImageView.center.y = view.center.y - view.frame.height
            })
            
        }, completion: { (success: Bool) in
            topImageView.removeFromSuperview()
            bottomImageView.removeFromSuperview()
        })
    }
    
    func backgroundAbstractionAnimation (view: UIView) {
        
        var addedImages = Array<UIImageView>()
        
        let bottomImageView = UIImageView.init(frame: view.frame)
        bottomImageView.image = #imageLiteral(resourceName: "shield")
        bottomImageView.contentMode = .scaleAspectFill
        view.addSubview(bottomImageView)
        
        //bottom
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            let topImageView = UIImageView.init(frame: view.frame)
            topImageView.image = #imageLiteral(resourceName: "shield")
            topImageView.contentMode = .scaleAspectFill
            addedImages.append(topImageView)
            view.addSubview(topImageView)
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                topImageView.center.y = view.center.y + view.frame.size.height
                topImageView.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                topImageView.center.y = view.center.y - view.frame.size.height/2
                topImageView.transform = CGAffineTransform(scaleX: 0.2,y: 0.2)
            })
        }, completion: { (success: Bool) in
        })
        
        //top
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            let topImageView = UIImageView.init(frame: view.frame)
            topImageView.image = #imageLiteral(resourceName: "shield")
            topImageView.contentMode = .scaleAspectFill
            addedImages.append(topImageView)
            view.addSubview(topImageView)
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                topImageView.center.y = view.center.y - view.frame.size.height
                topImageView.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                topImageView.center.y = view.center.y + view.frame.size.height/2
                topImageView.transform = CGAffineTransform(scaleX: 0.2,y: 0.2)
            })
        }, completion: { (success: Bool) in
        })
        
        //top-left
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            let topImageView = UIImageView.init(frame: view.frame)
            topImageView.image = #imageLiteral(resourceName: "shield")
            topImageView.contentMode = .scaleAspectFill
            addedImages.append(topImageView)
            view.addSubview(topImageView)
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x - view.frame.size.width/4
                topImageView.center.y = view.center.y - view.frame.size.width/4
                topImageView.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x + view.frame.size.width/4
                topImageView.center.y = view.center.y + view.frame.size.width/4
                topImageView.transform = CGAffineTransform(scaleX: 0.2,y: 0.2)
            })
        }, completion: { (success: Bool) in
        })
        
        //bottom-right
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            let topImageView = UIImageView.init(frame: view.frame)
            topImageView.image = #imageLiteral(resourceName: "shield")
            topImageView.contentMode = .scaleAspectFill
            addedImages.append(topImageView)
            view.addSubview(topImageView)
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x + view.frame.size.width/4
                topImageView.center.y = view.center.y + view.frame.size.width/4
                topImageView.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x - view.frame.size.width/4
                topImageView.center.y = view.center.y - view.frame.size.width/4
                topImageView.transform = CGAffineTransform(scaleX: 0.2,y: 0.2)
            })
        }, completion: { (success: Bool) in
        })
        
        //bottom-left
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            let topImageView = UIImageView.init(frame: view.frame)
            topImageView.image = #imageLiteral(resourceName: "shield")
            topImageView.contentMode = .scaleAspectFill
            addedImages.append(topImageView)
            view.addSubview(topImageView)
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x - view.frame.size.width/4
                topImageView.center.y = view.center.y + view.frame.size.width/4
                topImageView.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x + view.frame.size.width/4
                topImageView.center.y = view.center.y - view.frame.size.width/4
                topImageView.transform = CGAffineTransform(scaleX: 0.2,y: 0.2)
            })
        }, completion: { (success: Bool) in
        })
        
        //top-right
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            let topImageView = UIImageView.init(frame: view.frame)
            topImageView.image = #imageLiteral(resourceName: "shield")
            topImageView.contentMode = .scaleAspectFill
            addedImages.append(topImageView)
            view.addSubview(topImageView)
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x + view.frame.size.width/4
                topImageView.center.y = view.center.y - view.frame.size.width/4
                topImageView.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x - view.frame.size.width/4
                topImageView.center.y = view.center.y + view.frame.size.width/4
                topImageView.transform = CGAffineTransform(scaleX: 0.2,y: 0.2)
            })
        }, completion: { (success: Bool) in
        })
        
        //left
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            let topImageView = UIImageView.init(frame: view.frame)
            topImageView.image = #imageLiteral(resourceName: "shield")
            topImageView.contentMode = .scaleAspectFill
            addedImages.append(topImageView)
            view.addSubview(topImageView)
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x - view.frame.size.width
                topImageView.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x + view.frame.size.width/3
                topImageView.transform = CGAffineTransform(scaleX: 0.2,y: 0.2)
            })
        }, completion: { (success: Bool) in
        })
        
        //right
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            let topImageView = UIImageView.init(frame: view.frame)
            topImageView.image = #imageLiteral(resourceName: "shield")
            topImageView.contentMode = .scaleAspectFill
            addedImages.append(topImageView)
            view.addSubview(topImageView)
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x + view.frame.size.width
                topImageView.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                topImageView.center.x = view.center.x - view.frame.size.width/3
                topImageView.transform = CGAffineTransform(scaleX: 0.2,y: 0.2)
            })
        }, completion: { (success: Bool) in
            
            bottomImageView.removeFromSuperview()
            for imageView in addedImages {
                imageView.removeFromSuperview()
            }
        })
    }
    
    func cornerRadiusAnimation (view: UIView) {
        
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.layer.cornerRadius = view.bounds.size.height / 2
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                view.layer.cornerRadius = 0
            })
            
        }, completion: { (success: Bool) in
        })
    }
    
    func borderRadiusAnimation (view: UIView) {
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
                view.layer.cornerRadius = view.bounds.size.height / 2
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                view.layer.cornerRadius = 0
            })
            
        }, completion: { (success: Bool) in
        })
    }
    
    func gradientShadowAnimation (view: UIView) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x:0.0, y:1)
        gradient.endPoint = CGPoint(x:1.0, y:0.5)
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.locations =  [0, 1]
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        animation.toValue = [UIColor.green.cgColor, UIColor.blue.cgColor]
        animation.duration = 1.0
        animation.autoreverses = true
        
        gradient.add(animation, forKey: "colors")
        
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                view.layer.addSublayer(gradient)
            })
        }, completion: { (success: Bool) in
            //gradient.removeFromSuperlayer()
        })
    }
    
    func outerShadowAnimation (view: UIView) {
        
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.transform = CGAffineTransform(scaleX: 0, y: 0)
                view.layer.opacity = 0.5
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.transform = CGAffineTransform.identity
                view.layer.opacity = 0
            })
        }, completion: { (success: Bool) in
        })
    }
    
    func textColorAnimation (view: UIView) {
        
        let whiteLabel = UILabel.init(frame: view.bounds)
        whiteLabel.textColor = .white
        whiteLabel.center = view.center
        whiteLabel.text = String(format: "%zd", 10)
        whiteLabel.textAlignment = .center
        whiteLabel.font.withSize(30)
        view.addSubview(whiteLabel)
        
        let blackLabel = UILabel.init(frame: view.bounds)
        blackLabel.textColor = .black
        blackLabel.layer.opacity = 0
        blackLabel.center = view.center
        blackLabel.text = String(format: "%zd", 10)
        blackLabel.textAlignment = .center
        blackLabel.font.withSize(30)
        view.addSubview(blackLabel)
        
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                whiteLabel.layer.opacity = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                blackLabel.layer.opacity = 1
            })
        }, completion: { (success: Bool) in
            whiteLabel.removeFromSuperview()
            blackLabel.removeFromSuperview()
        })
    }
    
    func textSizeAnimation (view: UIView) {
        let label = UILabel.init(frame: view.bounds)
        label.textColor = .white
        label.center = view.center
        label.text = String(format: "%zd", arc4random()%10)
        label.textAlignment = .center
        label.font.withSize(30)
        view.addSubview(label)
        
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                label.transform = CGAffineTransform(scaleX: 2, y: 2)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                label.transform = CGAffineTransform.identity
            })
        }, completion: { (success: Bool) in
            label.removeFromSuperview()
        })
    }
    
    func heightAnimation (view: UIView) {
        
        let height = view.bounds.size.height
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.frame.size.height = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                view.frame.size.height = height
            })
        }, completion: { (success: Bool) in
        })
    }
    
    func textSpaceAnimation (view: UIView) {
        
        let rightLabel = UILabel.init(frame: view.bounds)
        rightLabel.textColor = .white
        rightLabel.center = view.center
        rightLabel.text = String(format: "%zd", arc4random()%10)
        rightLabel.textAlignment = .center
        rightLabel.font.withSize(50)
        
        let leftLabel = UILabel.init(frame: view.bounds)
        leftLabel.textColor = .white
        leftLabel.center = view.center
        leftLabel.text = String(format: "%zd", arc4random()%10)
        leftLabel.textAlignment = .center
        leftLabel.font.withSize(50)
        
        let text  = String(format: "%zd", 10)
        rightLabel.text = text.substring(from: 1)
        leftLabel.text = text.substring(to: 1)
        view.addSubview(rightLabel)
        view.addSubview(leftLabel)
        
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                rightLabel.center.x = view.center.x + view.frame.size.width
                leftLabel.center.x = view.center.x - view.frame.size.width
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                rightLabel.transform = CGAffineTransform.identity
                leftLabel.transform = CGAffineTransform.identity
            })
        }, completion: { (success: Bool) in
            rightLabel.removeFromSuperview()
            leftLabel.removeFromSuperview()
        })
    }
    
    func textfieldMoveAnimation (view: UIView) {
        let label = UILabel.init(frame: view.bounds)
        label.textColor = .white
        label.center.x = view.frame.origin.x + (view.frame.size.width / 2)
        label.center.y = view.frame.origin.y
        label.text = String(format: "%zd", arc4random()%10)
        label.textAlignment = .center
        label.font.withSize(30)
        view.addSubview(label)
        
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                label.center.y += view.frame.size.height
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                label.center.y = view.frame.origin.y
            })
        }, completion: { (success: Bool) in
            label.removeFromSuperview()
        })
    }

    func textMoveAnimation (view: UIView) {
        
        let label = UILabel.init(frame: view.bounds)
        label.textColor = .white
        label.center.x = view.frame.origin.x
        label.center.y = view.frame.origin.y + (view.frame.size.height / 2)
        label.text = String(format: "%zd", arc4random()%10)
        label.textAlignment = .center
        label.font.withSize(30)
        view.addSubview(label)
        
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                label.center.x += view.frame.size.width
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                label.center.x = view.frame.origin.x
            })
        }, completion: { (success: Bool) in
            label.removeFromSuperview()
        })
    }
    
    func textShadowAnimation (view: UIView) {
        
        let shadowLabel = UILabel.init(frame: view.bounds)
        shadowLabel.textColor = .black
        shadowLabel.center = view.center
        shadowLabel.text = String(format: "%zd", 10)
        shadowLabel.textAlignment = .center
        shadowLabel.font.withSize(50)
        
        let label = UILabel.init(frame: view.bounds)
        label.textColor = .white
        label.center = view.center
        label.text = String(format: "%zd", 10)
        label.textAlignment = .center
        label.font.withSize(50)
        
        view.addSubview(shadowLabel)
        view.addSubview(label)
        
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                shadowLabel.center.x = view.center.x + view.frame.size.width/6
                shadowLabel.center.y = view.center.y + view.frame.size.height/6
                shadowLabel.layer.opacity = 0.5
            })
        }, completion: { (success: Bool) in
            shadowLabel.removeFromSuperview()
            label.removeFromSuperview()
        })
    }
    
    func textOpacityAnimation (view: UIView) {
        
        let label = UILabel.init(frame: view.bounds)
        label.textColor = .white
        label.center = view.center
        label.text = String(format: "%zd", 10)
        label.textAlignment = .center
        label.font.withSize(50)
        
        view.addSubview(label)
        
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                label.layer.opacity = 0.2
            })
        }, completion: { (success: Bool) in
            label.removeFromSuperview()
        })
    }
    
    func textRainbowAnimation (view: UIView) {
        
        let labelWhite = UILabel.init(frame: view.frame)
        labelWhite.textColor = .white
        labelWhite.center = view.center
        labelWhite.text = String(format: "%zd", 10)
        labelWhite.textAlignment = .center
        labelWhite.font.withSize(50)
        
        let labelRed = UILabel.init(frame: view.frame)
        labelRed.textColor = .red
        labelRed.center = view.center
        labelRed.text = String(format: "%zd", 10)
        labelRed.textAlignment = .center
        labelRed.font.withSize(50)
        
        let labelOrange = UILabel.init(frame: view.frame)
        labelOrange.textColor = .orange
        labelOrange.center = view.center
        labelOrange.text = String(format: "%zd", 10)
        labelOrange.textAlignment = .center
        labelOrange.font.withSize(50)
        
        let labelYellow = UILabel.init(frame: view.frame)
        labelYellow.textColor = .yellow
        labelYellow.center = view.center
        labelYellow.text = String(format: "%zd", 10)
        labelYellow.textAlignment = .center
        labelYellow.font.withSize(50)
        
        let labelGreen = UILabel.init(frame: view.frame)
        labelGreen.textColor = .green
        labelGreen.center = view.center
        labelGreen.text = String(format: "%zd", 10)
        labelGreen.textAlignment = .center
        labelGreen.font.withSize(50)
        
        let labelBlue = UILabel.init(frame: view.frame)
        labelBlue.textColor = UIColor(red:0.28, green:0.79, blue:0.96, alpha:1.00)
        labelBlue.center = view.center
        labelBlue.text = String(format: "%zd", 10)
        labelBlue.textAlignment = .center
        labelBlue.font.withSize(50)
        
        let labelPurple = UILabel.init(frame: view.frame)
        labelPurple.textColor = .purple
        labelPurple.center = view.center
        labelPurple.text = String(format: "%zd", 10)
        labelPurple.textAlignment = .center
        labelPurple.font.withSize(50)
        
        view.addSubview(labelPurple)
        view.addSubview(labelYellow)
        view.addSubview(labelBlue)
        
        view.addSubview(labelWhite)
        
        view.addSubview(labelGreen)
        view.addSubview(labelOrange)
        view.addSubview(labelRed)
        
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
                labelPurple.center.x = view.center.x + 50
                labelPurple.center.y = view.center.y + 50
                
                labelBlue.center.x = view.center.x + 30
                labelBlue.center.y = view.center.y + 30
                
                labelGreen.center.x = view.center.x + 10
                labelGreen.center.y = view.center.y + 10
                
                labelRed.center.x = view.center.x - 50
                labelRed.center.y = view.center.y - 50
                
                labelOrange.center.x = view.center.x - 30
                labelOrange.center.y = view.center.y - 30
                
                labelYellow.center.x = view.center.x - 10
                labelYellow.center.y = view.center.y - 10
            })
        }, completion: { (success: Bool) in
            labelPurple.removeFromSuperview()
            labelWhite.removeFromSuperview()
            labelBlue.removeFromSuperview()
            labelGreen.removeFromSuperview()
            labelYellow.removeFromSuperview()
            labelOrange.removeFromSuperview()
            labelRed.removeFromSuperview()
        })
    }
    
    func rotationAnimation (view: UIView) {
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.transform = CGAffineTransform(rotationAngle: 360)
            })
            
        }, completion: { (success: Bool) in
        })
        
    }
    
    func transformAnimation (view: UIView) {
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            })
            
        }, completion: { (success: Bool) in
        })
    }
    
    func scaleAnimation (view: UIView) {
        
        UIView.animateKeyframes(withDuration: 2, delay: 0.0, options: [.calculationModeLinear], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi)).concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi)).concatenating(CGAffineTransform(scaleX: 0, y: 0))
            })
            
        }, completion: { (success: Bool) in
            view.transform = CGAffineTransform.identity
        })
    }
}
