//
//  CarDamageCell.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 16/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class CarDamageCell: UICollectionViewCell
{
    let carDamageImageView: ImageViewWithZoom =
    {
        let iv = ImageViewWithZoom(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        
        return iv
    }()
    
    let exampleLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Eksempel"
        label.font = UIFont(name: "Montserrat-Regular", size: 34)
        label.textColor = .darkGray
        label.alpha = 0.8
        label.textAlignment = .center
        label.sizeToFit()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        backgroundColor = .clear
        layer.cornerRadius = 8
        
        addSubview(carDamageImageView)
        carDamageImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        carDamageImageView.addSubview(exampleLabel)
        exampleLabel.centerXAnchor.constraint(equalTo: carDamageImageView.centerXAnchor).isActive = true
        exampleLabel.centerYAnchor.constraint(equalTo: carDamageImageView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}










