//
//  ImageViewWithZoom.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 25/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class ImageViewWithZoom: UIImageView, UIScrollViewDelegate
{
    var startingFrame: CGRect?
    var blackBackgroundView: UIScrollView?
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
        zoomingImageView?.isUserInteractionEnabled = false
        zoomingImageView?.contentMode = .scaleAspectFill
        
        if let keyWindow = UIApplication.shared.keyWindow
        {
            blackBackgroundView = UIScrollView(frame: keyWindow.frame)
            blackBackgroundView?.delegate = self
//            blackBackgroundView?.scrollRectToVisible((zoomingImageView?.frame)!, animated: true)
            blackBackgroundView?.minimumZoomScale = 1.0
            blackBackgroundView?.maximumZoomScale = 10.0
            blackBackgroundView?.backgroundColor = UIColor.black
            blackBackgroundView?.alpha = 0
            blackBackgroundView?.isUserInteractionEnabled = true
            blackBackgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
            
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
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        return zoomingImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView)
    {
        
        let subView = zoomingImageView
        
        let zeroPointFive: CGFloat = 0.5
        
        let offsetX = max(((scrollView.bounds.size.width - scrollView.contentSize.width) * zeroPointFive), 0.0)
        
        let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * zeroPointFive, 0.0)
        
        // adjust the center of image view
        
        subView?.center = CGPoint(x: scrollView.contentSize.width * zeroPointFive + offsetX, y: scrollView.contentSize.height * zeroPointFive + offsetY)
        
//        subView?.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY)
        
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            scrollView.zoomScale = 1.0
            
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
