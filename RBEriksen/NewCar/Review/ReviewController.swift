//
//  CarLightsController.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 10/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import Firebase

class ReviewController: ReviewBaseController
{
    var values = [:] as [String: Any]
    var carDamagesDictionary = [String: String]()
    var carPhotos = [String: String]()
    var carWheelPhotos = [String: String]()
    var carBrakeDiscPhotos = [String: String]()
    var carMiscPhotos = [String: String]()
    var uploadCounter = 0
    var numberOfImages = 0
    
    var report: Report?
    {
        didSet
        {
            finishButton.isHidden = true
            
            carBrandAndSeriesLabel.text = "\(report?.carBrand ?? "Car Brand"), \(report?.carSeries ?? "Car Series")"
            
            frontWheelPatternValueLabel.text = report?.frontWheelPatternMeasurement
            backWheelPatternValueLabel.text = report?.backWheelPatternMeasurement
            
            if let carWheelPhotos = report?.carWheelPhotos
            {
                print(carWheelPhotos)
                let sorted = carWheelPhotos.sorted { $0.key < $1.key }
                let valuesArraySorted = Array(sorted.map({ $0.value }))
                let urlArray = valuesArraySorted
                
                carWheelImagesCollectionView.photoUrlArray = urlArray
            }
            
            
            if let carPhotos = report?.carPhotos
            {
                let sorted = carPhotos.sorted { $0.key < $1.key }
                let valuesArraySorted = Array(sorted.map({ $0.value }))
                let urlArray = valuesArraySorted
                
                carImagesCollectionView.photoUrlArray = urlArray
            }
            
            if let brakeDiscPhotos = report?.carBrakeDiscPhotos
            {
                let sorted = brakeDiscPhotos.sorted { $0.key < $1.key }
                let valuesArraySorted = Array(sorted.map({ $0.value }))
                let urlArray = valuesArraySorted
                
                carBrakeDiscImagesCollectionView.photoUrlArray = urlArray
            }
            
            
            if let carMiscPhotos = report?.carMiscPhotos
            {
                let sorted = carMiscPhotos.sorted { $0.key < $1.key }
                let valuesArraySorted = Array(sorted.map({ $0.value }))
                let urlArray = valuesArraySorted
            
                carMiscImagesCollectionView.photoUrlArray = urlArray
            }
            
            if let carDamagePhotos = report?.carDamagePhotos
            {
                let sorted = carDamagePhotos.sorted { $0.key < $1.key }
                let valuesArraySorted = Array(sorted.map({ $0.value }))
                let urlArray = valuesArraySorted
                
                carDamageImagesCollectionView.photoUrlArray = urlArray
                
                for (index, _) in urlArray.enumerated()
                {
                    self.carDamageImagesCollectionView.titleStringArray?.append("Skade \(index + 1)")
                }
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
    
    let finishButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "small-checked-icon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.backgroundColor = .lightBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(prepareToUploadReport), for: .touchUpInside)
        
        return button
    }()
    
    let scrollView: UIScrollView =
    {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.backgroundColor = .clear
        sv.indicatorStyle = .white
        
        return sv
    }()
    
    let uploadingView: UploadingView =
    {
        let uv = UploadingView()
        uv.alpha = 0
        
        return uv
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
    
    @objc private func prepareToUploadReport()
    {
        uploadImages()
        
        if let keyWindow = UIApplication.shared.keyWindow
        {
            keyWindow.addSubview(uploadingView)
            uploadingView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.uploadingView.alpha = 1
                
            }, completion: { (completed) in
                
                self.uploadingView.carImage.handleCarAnimation(self.uploadingView.frame.minX - 40, self.uploadingView.frame.midY - 5, self.uploadingView.frame.maxX + 40, self.uploadingView.frame.midY - 5)
            })
        }
    }
    
    @objc private func uploadImages()
    {
        let dispatchGroup = DispatchGroup()
        
        for (index, image) in DataContainer.shared.carPhotos.enumerated()
        {
            dispatchGroup.enter()
            numberOfImages += 1
            handleUploadImage(image: image) { (url) in
                
                self.carPhotos["carPhoto\(index)"] = url
                
                dispatchGroup.leave()
            }
        }
        
        for (index, image) in DataContainer.shared.carWheelPhotos.enumerated()
        {
            dispatchGroup.enter()
            numberOfImages += 1
            handleUploadImage(image: image) { (url) in
                
                self.carWheelPhotos["carWheelPhoto\(index)"] = url
                
                dispatchGroup.leave()
            }
        }
        
        for (index, image) in DataContainer.shared.carBrakeDiscPhotos.enumerated()
        {
            dispatchGroup.enter()
            numberOfImages += 1
            handleUploadImage(image: image) { (url) in
                
                self.carBrakeDiscPhotos["carBrakeDiscPhoto\(index)"] = url
                
                dispatchGroup.leave()
            }
        }
        
        for (index, image) in DataContainer.shared.carMiscPhotos.enumerated()
        {
            dispatchGroup.enter()
            numberOfImages += 1
            handleUploadImage(image: image) { (url) in
                
                self.carMiscPhotos["carMiscPhoto\(index)"] = url
    
                dispatchGroup.leave()
            }
        }
        
        for (index, image) in DataContainer.shared.carDamagePhotos.enumerated()
        {
            dispatchGroup.enter()
            numberOfImages += 1
            handleUploadImage(image: image) { (url) in
                
                self.carDamagesDictionary["carDamagePhoto\(index)"] = url
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            
            self.values["carDamagePhotos"] = self.carDamagesDictionary
            self.values["carPhotos"] = self.carPhotos
            self.values["carWheelPhotos"] = self.carWheelPhotos
            self.values["carBrakeDiscPhotos"] = self.carBrakeDiscPhotos
            self.values["carMiscPhotos"] = self.carMiscPhotos
            self.uploadReportToDatabase()
        }
    }
    
    private func handleUploadImage(image: UIImage, completion: ((String) -> ())? = nil)
    {
        let filename = NSUUID().uuidString
        guard let data = UIImageJPEGRepresentation(image, 0.3) else { return }
        
        let uploadTask = Storage.storage().reference().child("reports").child(filename).putData(data, metadata: nil) { (metadata, err) in
            
            if err != nil
            {
                self.uploadingView.removeFromSuperview()
                self.showAlert(with: "Failed to upload image, please try again!")
                return
            }
            
            if let imageUrl = metadata?.downloadURL()?.absoluteString
            {
                completion?(imageUrl)
            }
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            
            guard let completedUnitCount = snapshot.progress?.completedUnitCount else { return }
            let totalUnitCount = snapshot.progress?.totalUnitCount
            let byteCountFormatter = ByteCountFormatter()
            byteCountFormatter.allowedUnits = [.useKB]
            byteCountFormatter.countStyle = .file
            
            self.uploadingView.statusLabel.text = "Uploading (\(self.uploadCounter)/\(self.numberOfImages))\n \(ByteCountFormatter.string(fromByteCount: completedUnitCount, countStyle: .file))/\(byteCountFormatter.string(fromByteCount: totalUnitCount!))"
        }
        
        uploadTask.observe(.success) { (snapshot) in
            
            self.uploadCounter += 1
        }
    }
    
    private func uploadReportToDatabase()
    {
        let carBrand = DataContainer.shared.carBrand ?? ""
        let carSeries = DataContainer.shared.carSeries ?? ""
        let frontWheelPatternMeasurement = DataContainer.shared.frontWheelPatternMeasurement?.toString() ?? ""
        let backWheelPatternMeasurement = DataContainer.shared.backWheelPatternMeasurement?.toString() ?? ""
        let timestamp = Int(Date().timeIntervalSince1970)
        
        values["timestamp"] = timestamp
        values["carBrand"] = carBrand
        values["carSeries"] = carSeries
        values["frontWheelPatternMeasurement"] = frontWheelPatternMeasurement
        values["backWheelPatternMeasurement"] = backWheelPatternMeasurement
        
        uploadingView.statusLabel.text = "Uploading report..."
        
        Database.database().reference().child("reports").childByAutoId().updateChildValues(values) { (err, ref) in
            
            if err != nil
            {
                self.uploadingView.removeFromSuperview()
                self.showAlert(with: "Failed to upload report, please try again!")
                return
            }
            
            self.uploadingView.statusLabel.text = "Success!"
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.uploadingView.alpha = 0
                
            }, completion: { (completed) in
                
                DataContainer.shared.resetAllVariables()
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    @objc func handleGoBack()
    {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupUI()
    {
        view.addSubview(frostEffect)
        view.addSubview(scrollView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(carBrandAndSeriesLabel)
        scrollView.addSubview(carImagesCollectionView)
        scrollView.addSubview(carWheelImagesCollectionView)
        scrollView.addSubview(carBrakeDiscImagesCollectionView)
        scrollView.addSubview(carMiscImagesCollectionView)
        scrollView.addSubview(carDamageImagesCollectionView)
        scrollView.addSubview(wheelPatternLabel)
        scrollView.addSubview(frontWheelPatternLabel)
        scrollView.addSubview(frontWheelPatternValueLabel)
        scrollView.addSubview(backWheelPatternLabel)
        scrollView.addSubview(backWheelPatternValueLabel)
        scrollView.addSubview(finishButton)
        
        let width = view.frame.width - 36
        
        frostEffect.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backButton.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 11, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        
        carBrandAndSeriesLabel.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 90, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        carBrandAndSeriesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        carImagesCollectionView.anchor(top: carBrandAndSeriesLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 220)
        
        carWheelImagesCollectionView.anchor(top: carImagesCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 220)
        
        carBrakeDiscImagesCollectionView.anchor(top: carWheelImagesCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 220)
        
        carMiscImagesCollectionView.anchor(top: carBrakeDiscImagesCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 220)
        
        carDamageImagesCollectionView.anchor(top: carMiscImagesCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 220)
        
        wheelPatternLabel.anchor(top: carDamageImagesCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        frontWheelPatternLabel.anchor(top: wheelPatternLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 22, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        frontWheelPatternValueLabel.anchor(top: frontWheelPatternLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 3, paddingLeft: 22, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backWheelPatternLabel.anchor(top: frontWheelPatternValueLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 22, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        backWheelPatternValueLabel.anchor(top: backWheelPatternLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 3, paddingLeft: 22, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        finishButton.anchor(top: backWheelPatternValueLabel.bottomAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 40, paddingLeft: 18, paddingRight: 0, paddingBottom: -20, width: 120, height: 50)
        finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}






















