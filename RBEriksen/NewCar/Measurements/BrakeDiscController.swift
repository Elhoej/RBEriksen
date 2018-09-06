//
//  BrakeDiscController.swift
//  RBEriksen
//
//  Created by Simon Elhoej Steinmejer on 26/07/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class BrakeDiscController: UIViewController
{
    let backButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "left-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        
        return button
    }()
    
    let brakeDiscTitleLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Stand på\nbremser"
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.numberOfLines = 2
        label.sizeToFit()
        
        return label
    }()
    
    let frontBrakeDiscTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "For"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        tf.becomeFirstResponder()
        
        return tf
    }()
    
    let frontBrakeDiscUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let frontBrakeDiscCheckedImageView: UIImageView =
    {
        let image = UIImageView(image: #imageLiteral(resourceName: "checked-icon").withRenderingMode(.alwaysTemplate))
        image.tintColor = .lightBlue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0
        
        return image
    }()
    
    let backBrakeDiscTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Bag"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let backBrakeDiscUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let backBrakeDiscCheckedImageView: UIImageView =
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
        guard let frontBrakeDiscMeasurement = frontBrakeDiscTextField.text else { return }
        guard let backBrakeDiscMeasurement = backBrakeDiscTextField.text else { return }
        
//        let frontBrakeDiscMeasurementString = frontBrakeDiscMeasurement.formattedWithSeparator
//        let backBrakeDiscMeasurementString = backBrakeDiscMeasurement.formattedWithSeparator
        
        DataContainer.shared.frontBrakeDiscMeasurement = frontBrakeDiscMeasurement
        DataContainer.shared.backBrakeDiscMeasurement = backBrakeDiscMeasurement
        
        let serviceController = ServiceController()
        navigationController?.pushViewController(serviceController, animated: true)
    }
    
    @objc private func handleGoBack()
    {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleEditingChanged()
    {
        guard let frontBrakeDiscMeasurement = frontBrakeDiscTextField.text else { return }
        guard let backBrakeDiscMeasurement = backBrakeDiscTextField.text else { return }
        let isValid = !frontBrakeDiscMeasurement.isEmpty && !backBrakeDiscMeasurement.isEmpty
        
        nextButton.isEnabled = isValid ? true : false
        
        UIView.animate(withDuration: 0.3)
        {
            self.frontBrakeDiscCheckedImageView.alpha = frontBrakeDiscMeasurement.isEmpty ? 0 : 1
            self.backBrakeDiscCheckedImageView.alpha = backBrakeDiscMeasurement.isEmpty ? 0 : 1
            self.nextButton.alpha = isValid ? 1 : 0.5
        }
    }
    
    fileprivate func setupUI()
    {
        view.addSubview(frostEffect)
        view.addSubview(backButton)
        view.addSubview(brakeDiscTitleLabel)
        view.addSubview(frontBrakeDiscTextField)
        view.addSubview(frontBrakeDiscCheckedImageView)
        view.addSubview(frontBrakeDiscUnderline)
        view.addSubview(backBrakeDiscTextField)
        view.addSubview(backBrakeDiscCheckedImageView)
        view.addSubview(backBrakeDiscUnderline)
        view.addSubview(nextButton)
        
        frostEffect.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 11, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        
         brakeDiscTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 90, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        frontBrakeDiscTextField.anchor(top: brakeDiscTitleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 55, paddingLeft: 18, paddingRight: 55, paddingBottom: 0, width: 0, height: 40)
        
        frontBrakeDiscCheckedImageView.anchor(top: nil, left: frontBrakeDiscTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        frontBrakeDiscCheckedImageView.centerYAnchor.constraint(equalTo: frontBrakeDiscTextField.centerYAnchor, constant: 4).isActive = true
        
        frontBrakeDiscUnderline.anchor(top: frontBrakeDiscTextField.bottomAnchor, left: frontBrakeDiscTextField.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 55, paddingBottom: 0, width: 0, height: 1)
        
        backBrakeDiscTextField.anchor(top: frontBrakeDiscTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 30, paddingLeft: 18, paddingRight: 55, paddingBottom: 0, width: 0, height: 40)
        
        backBrakeDiscCheckedImageView.anchor(top: nil, left: backBrakeDiscTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        backBrakeDiscCheckedImageView.centerYAnchor.constraint(equalTo: backBrakeDiscTextField.centerYAnchor, constant: 4).isActive = true
        
        backBrakeDiscUnderline.anchor(top: backBrakeDiscTextField.bottomAnchor, left: backBrakeDiscTextField.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 55, paddingBottom: 0, width: 0, height: 1)
        
        nextButton.anchor(top: backBrakeDiscUnderline.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 50)
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}
