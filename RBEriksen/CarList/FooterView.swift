//
//  FooterView.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 08/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class FooterView: UICollectionReusableView
{
    let versionLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Version 0.1.0\nDeveloped by Simon Elhøj Steinmejer"
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = .lightGray
        label.sizeToFit()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(versionLabel)
        
        versionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        versionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
