//
//  ImageViewWithZoom.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 25/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class ImageViewWithZoom: UIImageView
{
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    var startingImageView: UIImageView?
    var zoomingImageView: UIImageView?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performZoomInForStartingImageView)))
    }
    
    @objc func performZoomInForStartingImageView()
    {
        self.startingImageView = self
        self.startingImageView?.isHidden = true
        
        self.startingFrame = startingImageView?.superview?.convert(startingImageView!.frame, to: nil)
        
        zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView?.image = startingImageView?.image
        zoomingImageView?.isUserInteractionEnabled = true
        zoomingImageView?.contentMode = .scaleAspectFill
        
        if let keyWindow = UIApplication.shared.keyWindow
        {
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.backgroundColor = UIColor.black
            blackBackgroundView?.alpha = 0
            blackBackgroundView?.isUserInteractionEnabled = true
            blackBackgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
            zoomingImageView?.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture)))
            zoomingImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
            
            keyWindow.addSubview(blackBackgroundView!)
            keyWindow.addSubview(zoomingImageView!)
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackBackgroundView?.alpha = 1
                
                let height = self.startingFrame!.height / self.startingFrame!.width * keyWindow.frame.width
                
                self.zoomingImageView?.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                
                self.zoomingImageView?.center = keyWindow.center
                
            }, completion: nil)
            
        }
    }
    
    @objc func handleZoomOut()
    {
        zoomingImageView?.layer.cornerRadius = 8
        zoomingImageView?.clipsToBounds = true
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.zoomingImageView?.frame = self.startingFrame!
            self.blackBackgroundView?.alpha = 0
            
        }, completion: { (completed: Bool) in
            
            self.zoomingImageView?.removeFromSuperview()
            self.startingImageView?.isHidden = false
        })
    }
    
    @objc func handlePinchGesture(recognizer: UIPinchGestureRecognizer)
    {
        if let view = recognizer.view
        {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
