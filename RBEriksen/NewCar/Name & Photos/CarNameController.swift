//
//  CreateCarController.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 08/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class CarNameController: UIViewController, UITextFieldDelegate
{
    let backButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "left-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        
        return button
    }()
    
    let carNameLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Hvilken bil er det?"
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let carBrandTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Mærke"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .default
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        tf.becomeFirstResponder()
        
        return tf
    }()
    
    let carBrandUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let carBrandCheckedImageView: UIImageView =
    {
        let image = UIImageView(image: #imageLiteral(resourceName: "checked-icon").withRenderingMode(.alwaysTemplate))
        image.tintColor = .lightBlue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 0
        
        return image
    }()
    
    let carSeriesTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Serie"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.keyboardType = .default
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let carSeriesUnderline: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let carSeriesCheckedImageView: UIImageView =
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
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.setGradientBackground(colorOne: UIColor.dark.cgColor, colorTwo: UIColor.darkBlue.cgColor)
        
        setupUI()
    }
    
    @objc private func handleGoBack()
    {
        DataContainer.shared.resetAllVariables()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleNextView()
    {
        guard let carBrand = carBrandTextField.text else { return }
        guard let carSeries = carSeriesTextField.text else { return }
        
        let carPhotoController = CarPhotosController()
        DataContainer.shared.carBrand = carBrand
        DataContainer.shared.carSeries = carSeries
        carPhotoController.carPhotoStage = .frontPhotoOfCar
        navigationController?.pushViewController(carPhotoController, animated: true)
    }
    
    @objc private func handleEditingChanged()
    {
        guard let carBrand = carBrandTextField.text else { return }
        guard let carSeries = carSeriesTextField.text else { return }
        let isValid = !carBrand.isEmpty && !carSeries.isEmpty
        
        nextButton.isEnabled = isValid ? true : false
        
        UIView.animate(withDuration: 0.3)
        {
            self.carBrandCheckedImageView.alpha = carBrand.isEmpty ? 0 : 1
            self.carSeriesCheckedImageView.alpha = carSeries.isEmpty ? 0 : 1
            self.nextButton.alpha = isValid ? 1 : 0.5
        }
    }
    
    private func setupUI()
    {
        view.addSubview(frostEffect)
        view.addSubview(backButton)
        view.addSubview(carNameLabel)
        view.addSubview(carBrandTextField)
        view.addSubview(carBrandCheckedImageView)
        view.addSubview(carBrandUnderline)
        view.addSubview(carSeriesTextField)
        view.addSubview(carSeriesCheckedImageView)
        view.addSubview(carSeriesUnderline)
        view.addSubview(nextButton)
        
        frostEffect.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 11, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        
        carNameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 90, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        carBrandTextField.anchor(top: carNameLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 55, paddingLeft: 18, paddingRight: 55, paddingBottom: 0, width: 0, height: 40)
        
        carBrandCheckedImageView.anchor(top: nil, left: carBrandTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        carBrandCheckedImageView.centerYAnchor.constraint(equalTo: carBrandTextField.centerYAnchor, constant: 4).isActive = true
        
        carBrandUnderline.anchor(top: carBrandTextField.bottomAnchor, left: carBrandTextField.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 18, paddingBottom: 0, width: 0, height: 1)
        
        carSeriesTextField.anchor(top: carBrandUnderline.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 30, paddingLeft: 18, paddingRight: 55, paddingBottom: 0, width: 0, height: 40)
        
        carSeriesUnderline.anchor(top: carSeriesTextField.bottomAnchor, left: carSeriesTextField.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 18, paddingBottom: 0, width: 0, height: 1)
        
        carSeriesCheckedImageView.anchor(top: nil, left: carSeriesTextField.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        carSeriesCheckedImageView.centerYAnchor.constraint(equalTo: carSeriesTextField.centerYAnchor, constant: 4).isActive = true
        
        nextButton.anchor(top: carSeriesUnderline.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 50)
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
}
    
    
























