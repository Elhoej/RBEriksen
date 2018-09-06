//
//  PageView.swift
//  RBEriksen
//
//  Created by Simon Elhoej Steinmejer on 30/06/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import PDFGenerator

class PDFPageTemplate: UIView
{
    var imageViewArray = [UIImageView]()
    var labelArray = [UILabel]()
    
    let imageHeight = (UIScreen.main.bounds.height - 250) / 4
    let imageWidth = UIScreen.main.bounds.width - 120
    let space: CGFloat = 20
    let titleSpace: CGFloat = 10
    let titleHeight: CGFloat = 20
    
    lazy var imageView1: UIImageView =
    {
        let iv = UIImageView(frame: CGRect(x: 60, y: space + titleHeight + titleSpace, width: imageWidth, height: imageHeight))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    lazy var imageView2: UIImageView =
    {
        let iv = UIImageView(frame: CGRect(x: 60, y: ((space + titleHeight + titleSpace) * 2) + imageHeight, width: imageWidth, height: imageHeight))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    lazy var imageView3: UIImageView =
    {
        let iv = UIImageView(frame: CGRect(x: 60, y: ((space + titleHeight + titleSpace) * 3) + (imageHeight * 2), width: imageWidth, height: imageHeight))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    lazy var imageView4: UIImageView =
    {
        let iv = UIImageView(frame: CGRect(x: 60, y: ((space + titleHeight + titleSpace) * 4) + (imageHeight * 3), width: imageWidth, height: imageHeight))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let carNameLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var titleLabel1: UILabel =
    {
        let label = UILabel(frame: CGRect(x: 20, y: space, width: imageWidth, height: titleHeight))
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = .black
        
        return label
    }()
    
    lazy var titleLabel2: UILabel =
    {
        let label = UILabel(frame: CGRect(x: 20, y: space + titleHeight + titleSpace + imageHeight + space, width: imageWidth, height: titleHeight))
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = .black
        
        return label
    }()
    
    lazy var titleLabel3: UILabel =
    {
        let label = UILabel(frame: CGRect(x: 20, y: ((titleHeight + titleSpace + imageHeight + space) * 2) + space, width: imageWidth, height: titleHeight))
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = .black
        
        return label
    }()
    
    lazy var titleLabel4: UILabel =
    {
        let label = UILabel(frame: CGRect(x: 20, y: ((titleHeight + titleSpace + imageHeight + space) * 3) + space, width: imageWidth, height: titleHeight))
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = .black
        
        return label
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        imageViewArray = [imageView1, imageView2, imageView3, imageView4]
        labelArray = [titleLabel1, titleLabel2, titleLabel3, titleLabel4]
        
        setupUI()
    }
    
    fileprivate func setupUI()
    {
        addSubview(carNameLabel)
        addSubview(imageView1)
        addSubview(imageView2)
        addSubview(imageView3)
        addSubview(imageView4)

        addSubview(titleLabel1)
        addSubview(titleLabel2)
        addSubview(titleLabel3)
        addSubview(titleLabel4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





















