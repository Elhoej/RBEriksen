//
//  UploadingView.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 11/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class UploadingView: UIView
{
    let statusLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 26)
        label.textColor = .white
        label.sizeToFit()
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    let carImage: CarAnimationImageView =
    {
        let carImage = CarAnimationImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        return carImage
    }()
    
    let roadLine: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(white: 0.0, alpha: 0.9)
        
        addSubview(carImage)
        addSubview(statusLabel)
        addSubview(roadLine)
        
        statusLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 200, paddingLeft: 10, paddingRight: 10, paddingBottom: 0, width: 0, height: 0)
        
        roadLine.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 1)
        roadLine.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
//        carImage.handleCarAnimation(frame.minX - 40, frame.midY - 5, frame.maxX + 40, frame.midY - 5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}























