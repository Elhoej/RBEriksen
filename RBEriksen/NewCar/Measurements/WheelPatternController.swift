//
//  FrontLeftWheelController.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 09/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class WheelPatternController: UIViewController
{
    let backButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "left-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        
        return button
    }()
    
    let wheelPatternLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Udmåling af\ndækmønster"
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.numberOfLines = 2
        label.sizeToFit()
        
        return label
    }()
    
    let frontWheelPatternTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Foran"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        tf.becomeFirstResponder()
        
        return tf
    }()
    
    let frontWheelPatternUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let frontWheelPatternCheckedImageView: UIImageView =
    {
        let image = UIImageView(image: #imageLiteral(resourceName: "checked-icon").withRenderingMode(.alwaysTemplate))
        image.tintColor = .lightBlue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0
        
        return image
    }()
    
    let backWheelPatternTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Bagved"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let backWheelPatternUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let backWheelPatternCheckedImageView: UIImageView =
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
        guard let frontWheelMeasurement = frontWheelPatternTextField.text else { return }
        guard let backWheelMeasurement = backWheelPatternTextField.text else { return }
        
        DataContainer.shared.frontWheelPatternMeasurement = "\(frontWheelMeasurement) mm"
        DataContainer.shared.backWheelPatternMeasurement = "\(backWheelMeasurement) mm"
        
        let brakeDiscController = BrakeDiscController()
        navigationController?.pushViewController(brakeDiscController, animated: true)
    }
    
    @objc private func handleGoBack()
    {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleEditingChanged()
    {
        guard let frontWheelMeasurement = frontWheelPatternTextField.text else { return }
        guard let backWheelMeasurement = backWheelPatternTextField.text else { return }
        let isValid = !frontWheelMeasurement.isEmpty && !backWheelMeasurement.isEmpty

        nextButton.isEnabled = isValid ? true : false

        UIView.animate(withDuration: 0.3)
        {
            self.frontWheelPatternCheckedImageView.alpha = frontWheelMeasurement.isEmpty ? 0 : 1
            self.backWheelPatternCheckedImageView.alpha = backWheelMeasurement.isEmpty ? 0 : 1
            self.nextButton.alpha = isValid ? 1 : 0.5
        }
    }
    
    fileprivate func setupUI()
    {
        view.addSubview(frostEffect)
        view.addSubview(backButton)
        view.addSubview(wheelPatternLabel)
        view.addSubview(frontWheelPatternTextField)
        view.addSubview(frontWheelPatternCheckedImageView)
        view.addSubview(frontWheelPatternUnderline)
        view.addSubview(backWheelPatternTextField)
        view.addSubview(backWheelPatternCheckedImageView)
        view.addSubview(backWheelPatternUnderline)
        view.addSubview(nextButton)
        
        frostEffect.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 11, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        
        wheelPatternLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 90, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        frontWheelPatternTextField.anchor(top: wheelPatternLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 55, paddingLeft: 18, paddingRight: 55, paddingBottom: 0, width: 0, height: 40)
        
        frontWheelPatternCheckedImageView.anchor(top: nil, left: frontWheelPatternTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        frontWheelPatternCheckedImageView.centerYAnchor.constraint(equalTo: frontWheelPatternTextField.centerYAnchor, constant: 4).isActive = true
        
        frontWheelPatternUnderline.anchor(top: frontWheelPatternTextField.bottomAnchor, left: frontWheelPatternTextField.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 55, paddingBottom: 0, width: 0, height: 1)
        
        backWheelPatternTextField.anchor(top: frontWheelPatternTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 30, paddingLeft: 18, paddingRight: 55, paddingBottom: 0, width: 0, height: 40)
        
        backWheelPatternCheckedImageView.anchor(top: nil, left: backWheelPatternTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        backWheelPatternCheckedImageView.centerYAnchor.constraint(equalTo: backWheelPatternTextField.centerYAnchor, constant: 4).isActive = true
        
        backWheelPatternUnderline.anchor(top: backWheelPatternTextField.bottomAnchor, left: backWheelPatternTextField.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 55, paddingBottom: 0, width: 0, height: 1)
        
        nextButton.anchor(top: backWheelPatternUnderline.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 50)
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}












































