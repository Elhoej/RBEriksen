//
//  PDFFrontPage.swift
//  RBEriksen
//
//  Created by Simon Elhoej Steinmejer on 23/07/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class PDFFrontPage: UIView
{
    let width = UIScreen.main.bounds.width - 40
    let imageHeight = (UIScreen.main.bounds.height - 250) / 4
    
    let titleLabel: UILabel =
    {
        let label = UILabel(frame: CGRect(x: 0, y: 95, width: UIScreen.main.bounds.width, height: 120))
        
        label.numberOfLines = 4
//        label.font = UIFont(name: "Montserrat-Regular", size: 22)
//        label.textColor = .black
//        label.text = "Test title"
//        label.textAlignment = .center
        
        return label
    }()
    
    lazy var logoImageView: UIImageView =
        {
            let iv = UIImageView(frame: CGRect(x: self.frame.width - 140, y: 16, width: 80, height: 80))
            iv.image = #imageLiteral(resourceName: "rberiksen logo")
            iv.contentMode = .scaleAspectFill
            
            return iv
    }()
    
    lazy var frontCarImageView: UIImageView =
        {
            let iv = UIImageView(frame: CGRect(x: 60, y: 240, width: width - 80, height: imageHeight))
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            
            return iv
    }()
    
    lazy var wheelContainerView: ContainerView =
    {
        let cv = ContainerView(title: "Dækmønster", subTitle1: "Forhjul", value1: "", subTitle2: "Baghjul", value2: "")
        cv.subTitleLabel1.textColor = .black
        cv.titleLabel.textColor = .black
        cv.valueLabel1.textColor = .black
        cv.valueLabel2.textColor = .black
        cv.subTitleLabel2.textColor = .black
        cv.titleLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        cv.subTitleLabel1.font = UIFont(name: "Montserrat-Regular", size: 12)
        cv.subTitleLabel2.font = UIFont(name: "Montserrat-Regular", size: 12)
        cv.valueLabel1.font = UIFont(name: "Montserrat-Regular", size: 10)
        cv.valueLabel2.font = UIFont(name: "Montserrat-Regular", size: 10)
        cv.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 100)
        
        return cv
    }()
    
    lazy var brakeDiscContainerView: ContainerView =
    {
        let cv = ContainerView(title: "Stand på bremser", subTitle1: "Bremser for", value1: "", subTitle2: "Bremser bag", value2: "")
        cv.subTitleLabel1.textColor = .black
        cv.titleLabel.textColor = .black
        cv.valueLabel1.textColor = .black
        cv.valueLabel2.textColor = .black
        cv.subTitleLabel2.textColor = .black
        cv.titleLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        cv.subTitleLabel1.font = UIFont(name: "Montserrat-Regular", size: 12)
        cv.subTitleLabel2.font = UIFont(name: "Montserrat-Regular", size: 12)
        cv.valueLabel1.font = UIFont(name: "Montserrat-Regular", size: 10)
        cv.valueLabel2.font = UIFont(name: "Montserrat-Regular", size: 10)
        cv.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 100)
        
        return cv
    }()
    
    lazy var serviceContainerView: ContainerView =
    {
        let cv = ContainerView(title: "Næste service", subTitle1: "Kilometer", value1: DataContainer.shared.serviceKilometers ?? "", subTitle2: "Dage", value2: DataContainer.shared.serviceDays ?? "")
        cv.subTitleLabel1.textColor = .black
        cv.titleLabel.textColor = .black
        cv.valueLabel1.textColor = .black
        cv.valueLabel2.textColor = .black
        cv.subTitleLabel2.textColor = .black
        cv.titleLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        cv.subTitleLabel1.font = UIFont(name: "Montserrat-Regular", size: 12)
        cv.subTitleLabel2.font = UIFont(name: "Montserrat-Regular", size: 12)
        cv.valueLabel1.font = UIFont(name: "Montserrat-Regular", size: 10)
        cv.valueLabel2.font = UIFont(name: "Montserrat-Regular", size: 10)
        cv.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 100)
        
        return cv
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(logoImageView)
        addSubview(frontCarImageView)
        let containerStackView = UIStackView(arrangedSubviews: [serviceContainerView, brakeDiscContainerView, wheelContainerView])
        containerStackView.axis = .vertical
        containerStackView.distribution = .fillEqually
        containerStackView.frame = CGRect(x: 20, y: 300 + imageHeight, width: width, height: 300)
        
        addSubview(containerStackView)
    }
    
    func setValues(title: String ,frontWheel: String, backWheel: String, frontBrake: String, backBrake: String, kilometers: String, days: String)
    {
        let attributedText = NSMutableAttributedString(string: "Besigtigelse af", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .medium), NSAttributedStringKey.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: "\n\n\(title)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: UIColor.black]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.string.count))
        
        titleLabel.attributedText = attributedText
        wheelContainerView.setNewValues(value1: frontWheel, value2: backWheel)
        brakeDiscContainerView.setNewValues(value1: frontBrake, value2: backBrake)
        serviceContainerView.setNewValues(value1: kilometers, value2: days)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
























