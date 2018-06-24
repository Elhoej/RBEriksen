//
//  BrakeDiscMeasurementsController.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 10/05/18.
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
    
    let brakeDiscLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Udmåling af\nbremseskiver"
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.numberOfLines = 2
        label.sizeToFit()
        
        return label
    }()
    
    let frontLeftBrakeDiscTextField: UITextField =
    {
        let tf = UITextField()
        tf.font = UIFont(name: "Montserrat-Regular", size: 28)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let frontLeftBrakeDiscLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Venstre forhjul"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let frontLeftBrakeDiscUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let frontLeftBrakeDiscCheckedImageView: UIImageView =
    {
        let image = UIImageView(image: #imageLiteral(resourceName: "checked-icon").withRenderingMode(.alwaysTemplate))
        image.tintColor = .lightBlue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0
        
        return image
    }()
    
    let frontRightBrakeDiscTextField: UITextField =
    {
        let tf = UITextField()
        tf.font = UIFont(name: "Montserrat-Regular", size: 28)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let frontRightBrakeDiscLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Højre forhjul"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let frontRightBrakeDiscUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let frontRightBrakeDiscCheckedImageView: UIImageView =
    {
        let image = UIImageView(image: #imageLiteral(resourceName: "checked-icon").withRenderingMode(.alwaysTemplate))
        image.tintColor = .lightBlue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0
        
        return image
    }()
    
    let backRightBrakeDiscTextField: UITextField =
    {
        let tf = UITextField()
        tf.font = UIFont(name: "Montserrat-Regular", size: 28)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        tf.becomeFirstResponder()
        
        return tf
    }()
    
    let backRightBrakeDiscLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Højre baghjul"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let backRightBrakeDiscUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let backRightBrakeDiscCheckedImageView: UIImageView =
    {
        let image = UIImageView(image: #imageLiteral(resourceName: "checked-icon").withRenderingMode(.alwaysTemplate))
        image.tintColor = .lightBlue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0
        
        return image
    }()
    
    let backLeftBrakeDiscTextField: UITextField =
    {
        let tf = UITextField()
        tf.font = UIFont(name: "Montserrat-Regular", size: 28)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .decimalPad
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let backLeftBrakeDiscLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Venstre baghjul"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let backLeftBrakeDiscUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let backLeftBrakeDiscCheckedImageView: UIImageView =
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
        guard let backRightBrakeDisc = backRightBrakeDiscTextField.text else { return }
        guard let frontRightBrakeDisc = frontRightBrakeDiscTextField.text else { return }
        guard let backLeftBrakeDisc = backLeftBrakeDiscTextField.text else { return }
        guard let frontLeftBrakeDisc = frontLeftBrakeDiscTextField.text else { return }

        guard let backRightDouble = Double(backRightBrakeDisc.replacingOccurrences(of: ",", with: ".")) else { return }
        guard let frontRightDouble = Double(frontRightBrakeDisc.replacingOccurrences(of: ",", with: ".")) else { return }
        guard let backLeftDouble = Double(backLeftBrakeDisc.replacingOccurrences(of: ",", with: ".")) else { return }
        guard let frontLeftDouble = Double(frontLeftBrakeDisc.replacingOccurrences(of: ",", with: ".")) else { return }
        
        DataContainer.shared.backRightBrakeDiscMeasurement = backRightDouble
        DataContainer.shared.frontRightBrakeDiscMeasurement = frontRightDouble
        DataContainer.shared.backLeftBrakeDiscMeasurement = backLeftDouble
        DataContainer.shared.frontLeftBrakeDiscMeasurement = frontLeftDouble
        
        let reviewController = ReviewController()
        navigationController?.pushViewController(reviewController, animated: true)
    }
    
    @objc private func handleGoBack()
    {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleEditingChanged()
    {
        guard let backRightBrakeDisc = backRightBrakeDiscTextField.text else { return }
        guard let frontRightBrakeDisc = frontRightBrakeDiscTextField.text else { return }
        guard let backLeftBrakeDisc = backLeftBrakeDiscTextField.text else { return }
        guard let frontLeftBrakeDisc = frontLeftBrakeDiscTextField.text else { return }
        
        let isValid = !backRightBrakeDisc.isEmpty && !frontRightBrakeDisc.isEmpty && !backLeftBrakeDisc.isEmpty && !frontLeftBrakeDisc.isEmpty

        nextButton.isEnabled = isValid ? true : false

        UIView.animate(withDuration: 0.3)
        {
            self.backRightBrakeDiscCheckedImageView.alpha = backRightBrakeDisc.isEmpty ? 0 : 1
            self.frontRightBrakeDiscCheckedImageView.alpha = frontRightBrakeDisc.isEmpty ? 0 : 1
            self.backLeftBrakeDiscCheckedImageView.alpha = backLeftBrakeDisc.isEmpty ? 0 : 1
            self.frontLeftBrakeDiscCheckedImageView.alpha = frontLeftBrakeDisc.isEmpty ? 0 : 1
            self.nextButton.alpha = isValid ? 1 : 0.5
        }
    }
    
    fileprivate func setupUI()
    {
        view.addSubview(frostEffect)
        view.addSubview(backButton)
        view.addSubview(brakeDiscLabel)
        view.addSubview(frontLeftBrakeDiscTextField)
        view.addSubview(frontLeftBrakeDiscLabel)
        view.addSubview(frontLeftBrakeDiscCheckedImageView)
        view.addSubview(frontLeftBrakeDiscUnderline)
        view.addSubview(frontRightBrakeDiscTextField)
        view.addSubview(frontRightBrakeDiscLabel)
        view.addSubview(frontRightBrakeDiscCheckedImageView)
        view.addSubview(frontRightBrakeDiscUnderline)
        view.addSubview(backRightBrakeDiscTextField)
        view.addSubview(backRightBrakeDiscLabel)
        view.addSubview(backRightBrakeDiscCheckedImageView)
        view.addSubview(backRightBrakeDiscUnderline)
        view.addSubview(backLeftBrakeDiscTextField)
        view.addSubview(backLeftBrakeDiscLabel)
        view.addSubview(backLeftBrakeDiscCheckedImageView)
        view.addSubview(backLeftBrakeDiscUnderline)
        view.addSubview(nextButton)
        
        let width = (view.frame.width / 2) - 73
        
        frostEffect.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 11, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        
        brakeDiscLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 90, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)

        backRightBrakeDiscTextField.anchor(top: brakeDiscLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 55, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 40)
        
        backRightBrakeDiscLabel.anchor(top: nil, left: backRightBrakeDiscTextField.leftAnchor, bottom: backRightBrakeDiscTextField.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backRightBrakeDiscCheckedImageView.anchor(top: nil, left: backRightBrakeDiscTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        backRightBrakeDiscCheckedImageView.centerYAnchor.constraint(equalTo: backRightBrakeDiscTextField.centerYAnchor).isActive = true
        
        backRightBrakeDiscUnderline.anchor(top: backRightBrakeDiscTextField.bottomAnchor, left: backRightBrakeDiscTextField.leftAnchor, bottom: nil, right: backRightBrakeDiscTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: -40, paddingBottom: 0, width: 0, height: 1)

        
        frontRightBrakeDiscTextField.anchor(top: nil, left: backRightBrakeDiscUnderline.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 40)
        frontRightBrakeDiscTextField.centerYAnchor.constraint(equalTo: backRightBrakeDiscTextField.centerYAnchor).isActive = true
        
        frontRightBrakeDiscLabel.anchor(top: nil, left: frontRightBrakeDiscTextField.leftAnchor, bottom: frontRightBrakeDiscTextField.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        frontRightBrakeDiscCheckedImageView.anchor(top: nil, left: frontRightBrakeDiscTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        frontRightBrakeDiscCheckedImageView.centerYAnchor.constraint(equalTo: frontRightBrakeDiscTextField.centerYAnchor).isActive = true
        
        frontRightBrakeDiscUnderline.anchor(top: frontRightBrakeDiscTextField.bottomAnchor, left: frontRightBrakeDiscTextField.leftAnchor, bottom: nil, right: frontRightBrakeDiscTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: -40, paddingBottom: 0, width: 0, height: 1)
        
        backLeftBrakeDiscTextField.anchor(top: backRightBrakeDiscTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 40)
        
        backLeftBrakeDiscLabel.anchor(top: nil, left: backLeftBrakeDiscTextField.leftAnchor, bottom: backLeftBrakeDiscTextField.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backLeftBrakeDiscCheckedImageView.anchor(top: nil, left: backLeftBrakeDiscTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        backLeftBrakeDiscCheckedImageView.centerYAnchor.constraint(equalTo: backLeftBrakeDiscTextField.centerYAnchor).isActive = true
        
        backLeftBrakeDiscUnderline.anchor(top: backLeftBrakeDiscTextField.bottomAnchor, left: backLeftBrakeDiscTextField.leftAnchor, bottom: nil, right: backLeftBrakeDiscTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: -40, paddingBottom: 0, width: 0, height: 1)
        
        frontLeftBrakeDiscTextField.anchor(top: nil, left: backLeftBrakeDiscUnderline.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 18, paddingRight: 18, paddingBottom: 0, width: width, height: 40)
        frontLeftBrakeDiscTextField.centerYAnchor.constraint(equalTo: backLeftBrakeDiscTextField.centerYAnchor).isActive = true
        
        frontLeftBrakeDiscLabel.anchor(top: nil, left: frontLeftBrakeDiscTextField.leftAnchor, bottom: frontLeftBrakeDiscTextField.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        frontLeftBrakeDiscCheckedImageView.anchor(top: nil, left: frontLeftBrakeDiscTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        frontLeftBrakeDiscCheckedImageView.centerYAnchor.constraint(equalTo: frontLeftBrakeDiscTextField.centerYAnchor).isActive = true
        
        frontLeftBrakeDiscUnderline.anchor(top: frontLeftBrakeDiscTextField.bottomAnchor, left: frontLeftBrakeDiscTextField.leftAnchor, bottom: nil, right: frontLeftBrakeDiscTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: -40, paddingBottom: 0, width: 0, height: 1)
        
        nextButton.anchor(top: backLeftBrakeDiscTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 50)
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}

