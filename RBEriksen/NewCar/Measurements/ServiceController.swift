//
//  ServiceController.swift
//  RBEriksen
//
//  Created by Simon Elhoej Steinmejer on 26/07/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class ServiceController: UIViewController
{
    let backButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "left-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        
        return button
    }()
    
    let serviceTitleLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Næste service"
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.numberOfLines = 2
        label.sizeToFit()
        
        return label
    }()
    
    let serviceKilometerTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Antal kilometer"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        tf.becomeFirstResponder()
        
        return tf
    }()
    
    let serviceKilometerUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let serviceKilometerCheckedImageView: UIImageView =
    {
        let image = UIImageView(image: #imageLiteral(resourceName: "checked-icon").withRenderingMode(.alwaysTemplate))
        image.tintColor = .lightBlue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0
        
        return image
    }()
    
    let serviceDaysTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Antal dage"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let serviceDaysUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let serviceDaysCheckedImageView: UIImageView =
    {
        let image = UIImageView(image: #imageLiteral(resourceName: "checked-icon").withRenderingMode(.alwaysTemplate))
        image.tintColor = .lightBlue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0
        
        return image
    }()
    
    let nextButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "right-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = .lightBlue
        button.alpha = 0.5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleNextView), for: .touchUpInside)
        
        return button
    }()
    
    let frostEffect: UIVisualEffectView =
    {
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        frost.autoresizingMask = .flexibleWidth
        
        return frost
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.setGradientBackground(colorOne: UIColor.dark.cgColor, colorTwo: UIColor.darkBlue.cgColor)
        
        setupUI()
    }
    
    @objc private func handleNextView()
    {
        guard let serviceKilometers = Int(serviceKilometerTextField.text!) else { return }
        guard let serviceDays = serviceDaysTextField.text else { return }
        
        let serviceKilometersString = serviceKilometers.formattedWithSeparator
        
        DataContainer.shared.serviceKilometers = serviceKilometersString
        DataContainer.shared.serviceDays = serviceDays
        
        let reviewController = ReviewController()
        navigationController?.pushViewController(reviewController, animated: true)
    }
    
    @objc private func handleGoBack()
    {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleEditingChanged()
    {
        guard let serviceKilometers = serviceKilometerTextField.text else { return }
        guard let serviceDays = serviceDaysTextField.text else { return }
        let isValid = !serviceKilometers.isEmpty && !serviceDays.isEmpty
        
        nextButton.isEnabled = isValid ? true : false
        
        UIView.animate(withDuration: 0.3)
        {
            self.serviceKilometerCheckedImageView.alpha = serviceKilometers.isEmpty ? 0 : 1
            self.serviceDaysCheckedImageView.alpha = serviceDays.isEmpty ? 0 : 1
            self.nextButton.alpha = isValid ? 1 : 0.5
        }
    }
    
    fileprivate func setupUI()
    {
        view.addSubview(frostEffect)
        view.addSubview(backButton)
        view.addSubview(serviceTitleLabel)
        view.addSubview(serviceKilometerTextField)
        view.addSubview(serviceKilometerCheckedImageView)
        view.addSubview(serviceKilometerUnderline)
        view.addSubview(serviceDaysTextField)
        view.addSubview(serviceDaysCheckedImageView)
        view.addSubview(serviceDaysUnderline)
        view.addSubview(nextButton)
        
        frostEffect.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 11, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        
        serviceTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 90, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        serviceKilometerTextField.anchor(top: serviceTitleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 55, paddingLeft: 18, paddingRight: 55, paddingBottom: 0, width: 0, height: 40)
        
        serviceKilometerCheckedImageView.anchor(top: nil, left: serviceKilometerTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        serviceKilometerCheckedImageView.centerYAnchor.constraint(equalTo: serviceKilometerTextField.centerYAnchor, constant: 4).isActive = true
        
        serviceKilometerUnderline.anchor(top: serviceKilometerTextField.bottomAnchor, left: serviceKilometerTextField.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 55, paddingBottom: 0, width: 0, height: 1)
        
        serviceDaysTextField.anchor(top: serviceKilometerTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 30, paddingLeft: 18, paddingRight: 55, paddingBottom: 0, width: 0, height: 40)
        
        serviceDaysCheckedImageView.anchor(top: nil, left: serviceDaysTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        serviceDaysCheckedImageView.centerYAnchor.constraint(equalTo: serviceDaysTextField.centerYAnchor, constant: 4).isActive = true
        
        serviceDaysUnderline.anchor(top: serviceDaysTextField.bottomAnchor, left: serviceDaysTextField.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 55, paddingBottom: 0, width: 0, height: 1)
        
        nextButton.anchor(top: serviceDaysUnderline.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 50)
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}
