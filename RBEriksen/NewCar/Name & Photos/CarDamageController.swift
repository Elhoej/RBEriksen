//
//  CarDamageController.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 16/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class CarDamageController: UIViewController, CarDamageControllerDelegate
{
    func insertNewCarDamagePhoto()
    {
        if DataContainer.shared.carDamagePhotos.count == 1
        {
            carDamageCollectionView.reloadData()
        }
        else
        {
            DispatchQueue.main.async {
                let indexPath = IndexPath(item: DataContainer.shared.carDamagePhotos.count - 1, section: 0)
                self.carDamageCollectionView.insertItems(at: [indexPath])
                self.carDamageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    let backButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "left-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        
        return button
    }()
    
    let carDamagesLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Er der nogle\nskader?"
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.sizeToFit()
        label.numberOfLines = 2
        
        return label
    }()
    
    let carDamageCollectionView: CarDamageCollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = CarDamageCollectionView(frame: .zero, collectionViewLayout: layout)
        
        return cv
    }()
    
    let plusButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus-without-background").withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleNewCarDamage), for: .touchUpInside)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightBlue.cgColor
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 18)
        button.tintColor = .white
        
        return button
    }()
    
    let nextButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "right-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 25
        button.backgroundColor = .lightBlue
        button.addTarget(self, action: #selector(handleNextView), for: .touchUpInside)
        
        return button
    }()
    
    let frostEffect: UIVisualEffectView =
    {
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        frost.autoresizingMask = .flexibleWidth
        
        return frost
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        view.setGradientBackground(colorOne: UIColor.dark.cgColor, colorTwo: UIColor.darkBlue.cgColor)
        hideKeyboardWhenTappedAround()
        
        setupUI()
    }
    
    @objc private func handleNextView()
    {
        let wheelPatternController = WheelPatternController()
        navigationController?.pushViewController(wheelPatternController, animated: true)
    }
    
    @objc private func handleNewCarDamage()
    {
        let carPhotosController = CarPhotosController()
        carPhotosController.carPhotoLabel.text = "Skader"
        carPhotosController.delegate = self
        carPhotosController.carPhotoStage = .carDamagePhoto
        present(carPhotosController, animated: true) {
            carPhotosController.progressView.isHidden = true
        }
    }
    
    @objc private func handleGoBack()
    {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupUI()
    {
        view.addSubview(frostEffect)
        view.addSubview(backButton)
        view.addSubview(carDamagesLabel)
        view.addSubview(carDamageCollectionView)
        view.addSubview(plusButton)
        view.addSubview(nextButton)
        
        frostEffect.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 11, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        
        carDamagesLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 90, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        carDamageCollectionView.anchor(top: carDamagesLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 8, paddingRight: 8, paddingBottom: 0, width: 0, height: 200)
        
        plusButton.anchor(top: carDamageCollectionView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 50)
        plusButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -8).isActive = true
        
        nextButton.anchor(top: carDamageCollectionView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 120, height: 50)
        nextButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
    }
    
}










































