//
//  CarCell.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 08/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class CarCell: UICollectionViewCell
{
    lazy var carImageView: ImageViewWithGradient =
    {
        let carImageView = ImageViewWithGradient(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 200))
        carImageView.image = UIImage(named: "test-car")
        carImageView.contentMode = .scaleAspectFill
        carImageView.layer.cornerRadius = 8
        carImageView.clipsToBounds = true
        carImageView.layer.masksToBounds = true
        
        return carImageView
    }()
    
    let carNameLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Audi A4 Coupé"
        label.textColor = .lightBlue
        label.font = UIFont(name: "Montserrat-Italic", size: 20)
        label.sizeToFit()
        
        return label
    }()
    
    let dateLabel: UILabel =
    {
        let label = UILabel()
        label.text = "08/05"
        label.textColor = .lightBlue
        label.font = UIFont(name: "Montserrat-Italic", size: 20)
        label.sizeToFit()
        
        return label
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    
        layer.cornerRadius = 8
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        setupUI()
    }
    
    private func setupUI()
    {
        addSubview(carImageView)
        addSubview(carNameLabel)
        addSubview(dateLabel)
        
        carNameLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingRight: 0, paddingBottom: -5, width: 0, height: 0)
        
        dateLabel.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 12, paddingBottom: -5, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ImageViewWithGradient: UIImageView
{
    let myGradientLayer: CAGradientLayer
    
    override init(frame: CGRect)
    {
        myGradientLayer = CAGradientLayer()
        super.init(frame: frame)
        self.setup()
    }
    
    func setup()
    {
        myGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.6)
        myGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        let colors: [CGColor] = [UIColor.clear.cgColor, UIColor.dark.cgColor]
        myGradientLayer.colors = colors
        myGradientLayer.isOpaque = false
        myGradientLayer.locations = [0.0, 0.9]
        self.layer.addSublayer(myGradientLayer)
    }
    
    override func layoutSubviews()
    {
        myGradientLayer.frame = self.layer.bounds
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}



