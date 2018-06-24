//
//  CarAnimationImageView.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 08/06/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class CarAnimationImageView: UIImageView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        isHidden = true
        image = #imageLiteral(resourceName: "sportscar").withRenderingMode(.alwaysTemplate)
        tintColor = .white
        contentMode = .scaleAspectFit
    }
    
    public func handleCarAnimation(_ startX: CGFloat, _ startY:CGFloat, _ endX: CGFloat, _ endY: CGFloat)
    {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addLine(to: CGPoint(x: endX, y: endY))
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = CFTimeInterval(1.6)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float.infinity
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.layer.add(animation, forKey: nil)
        self.isHidden = false
    }
    
    public func cancelCarAnimation()
    {
        self.layer.removeAllAnimations()
        self.isHidden = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
