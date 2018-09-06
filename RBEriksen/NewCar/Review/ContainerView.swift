//
//  ContainerView.swift
//  RBEriksen
//
//  Created by Simon Elhoej Steinmejer on 26/07/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class ContainerView: UIView
{
    let titleLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 30)
        label.textColor = .white
        label.sizeToFit()
        label.numberOfLines = 2
        
        return label
    }()
    
    let subTitleLabel1: UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let valueLabel1: UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let subTitleLabel2: UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let valueLabel2: UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    init(title: String, subTitle1: String, value1: String, subTitle2: String, value2: String)
    {
        super.init(frame: .zero)
        
        titleLabel.text = title
        subTitleLabel1.text = subTitle1
        valueLabel1.text = value1
        subTitleLabel2.text = subTitle2
        valueLabel2.text = value2
        
        layer.cornerRadius = 12
        backgroundColor = .clear
        
        setupBlurEffect()
        setupUIElements()
    }
    
    func setNewValues(value1: String, value2: String)
    {
        valueLabel1.text = value1
        valueLabel2.text = value2
    }
    
    private func setupBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: .light)
        let blueView = UIVisualEffectView(effect: blurEffect)
        blueView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blueView.frame = self.bounds
        blueView.layer.cornerRadius = 12
        blueView.layer.masksToBounds = true
        addSubview(blueView)
    }
    
    private func setupUIElements()
    {
        addSubview(titleLabel)
        addSubview(subTitleLabel1)
        addSubview(valueLabel1)
        addSubview(subTitleLabel2)
        addSubview(valueLabel2)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        subTitleLabel1.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 12, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        valueLabel1.anchor(top: subTitleLabel1.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 3, paddingLeft: 12, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        subTitleLabel2.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 200, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        valueLabel2.anchor(top: subTitleLabel2.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 3, paddingLeft: 200, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}























