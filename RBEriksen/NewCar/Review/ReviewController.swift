//
//  CarLightsController.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 10/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import Firebase
import PDFGenerator

class ReviewController: ReviewBaseController, MailControllerDelegate
{
    var values = [:] as [String: Any]
    var carDamagesDictionary = [String: String]()
    var carPhotos = [String: String]()
    var carWheelPhotos = [String: String]()
    var carBrakeDiscPhotos = [String: String]()
    var carMiscPhotos = [String: String]()
    var uploadCounter = 0
    var numberOfImages = 0
    
    //MARK: - Open Report from database
    
    var report: Report?
    {
        didSet
        {
            guard let report = report else { return }
            setReportValues(report: report)
            changeFinishButton()
        }
    }
    
    private func setReportValues(report: Report)
    {
        carBrandAndSeriesLabel.text = "\(report.carBrand ?? ""), \(report.carSeries ?? "")"
        wheelContainerView.setNewValues(value1: report.frontWheelPatternMeasurement ?? "", value2: report.backWheelPatternMeasurement ?? "")
        brakeDiscContainerView.setNewValues(value1: report.frontDiscBrakeMeasurement ?? "", value2: report.backDiscBrakeMeasurement ?? "")
        serviceContainerView.setNewValues(value1: report.serviceKilometers ?? "", value2: report.serviceDays ?? "")
        
        if let carWheelPhotos = report.carWheelPhotos
        {
            sortAndAppendImages(carWheelPhotos, carWheelImagesCollectionView, false)
        }
        
        if let carPhotos = report.carPhotos
        {
            sortAndAppendImages(carPhotos, carImagesCollectionView, false)
        }
        
        if let carBrakeDiscPhotos = report.carBrakeDiscPhotos
        {
            sortAndAppendImages(carBrakeDiscPhotos, carBrakeDiscImagesCollectionView, false)
        }
        
        if let carMiscPhotos = report.carMiscPhotos
        {
            sortAndAppendImages(carMiscPhotos, carMiscImagesCollectionView, false)
        }
        
        if let carDamagePhotos = report.carDamagePhotos
        {
            sortAndAppendImages(carDamagePhotos, carDamageImagesCollectionView, true)
        }
    }
    
    private func sortAndAppendImages(_ dictionary: [String: String],_ collectionView: ReviewCollectionView, _ isCarDamageImages: Bool)
    {
        let sortedTuple = dictionary.sorted { $0.key < $1.key }
        let valuesTupleSorted = Array(sortedTuple.map({ $0.value }))
        collectionView.photoUrlArray = valuesTupleSorted
        
        if isCarDamageImages
        {
            for (index, _) in valuesTupleSorted.enumerated()
            {
                collectionView.titleStringArray?.append("Kosmetisk bemærkning \(index + 1)")
            }
        }
    }
    
    //MARK: - UI Properties
    
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
    
    //MARK: - Upload Report
    
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
        let frontWheelPatternMeasurement = DataContainer.shared.frontWheelPatternMeasurement ?? ""
        let backWheelPatternMeasurement = DataContainer.shared.backWheelPatternMeasurement ?? ""
        let frontDiscBrakeMeasurement = DataContainer.shared.frontBrakeDiscMeasurement ?? ""
        let backDiscBrakeMeasurement = DataContainer.shared.backBrakeDiscMeasurement ?? ""
        let serviceKilometers = DataContainer.shared.serviceKilometers ?? ""
        let serviceDays = DataContainer.shared.serviceDays ?? ""
        let timestamp = Int(Date().timeIntervalSince1970)
        
        values["timestamp"] = timestamp
        values["carBrand"] = carBrand
        values["carSeries"] = carSeries
        values["frontWheelPatternMeasurement"] = frontWheelPatternMeasurement
        values["backWheelPatternMeasurement"] = backWheelPatternMeasurement
        values["frontDiscBrakeMeasurement"] = frontDiscBrakeMeasurement
        values["backDiscBrakeMeasurement"] = backDiscBrakeMeasurement
        values["serviceKilometers"] = serviceKilometers
        values["serviceDays"] = serviceDays
        
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
    
    //MARK: - Mail/PDF
    
    private func changeFinishButton()
    {
        finishButton.removeTarget(nil, action: #selector(prepareToUploadReport), for: .touchUpInside)
        finishButton.setImage(nil, for: .normal)
        finishButton.setTitle("Send Email", for: .normal)
        finishButton.addTarget(self, action: #selector(sendReportWithEmail), for: .touchUpInside)
    }
    
    @objc private func sendReportWithEmail()
    {
        var data: Data?
        
        let frontPage = PDFFrontPage(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        let title = "\(report?.carBrand ?? "Car Brand") \(report?.carSeries ?? "Car Series")"
        
        frontPage.setValues(title: title, frontWheel: report?.frontWheelPatternMeasurement ?? "", backWheel: report?.backWheelPatternMeasurement ?? "", frontBrake: report?.frontDiscBrakeMeasurement ?? "", backBrake: report?.backDiscBrakeMeasurement ?? "", kilometers: report?.serviceKilometers ?? "", days: report?.serviceDays ?? "")
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        frontPage.frontCarImageView.loadImageUsingCacheWithUrlString(carImagesCollectionView.photoUrlArray[0]) {
            dispatchGroup.leave()
        }
        
        let carPhotosPage = createPDFPage(dispatchGroup: dispatchGroup, collectionView: carImagesCollectionView)
        let carWheelPhotosPage = createPDFPage(dispatchGroup: dispatchGroup, collectionView: carWheelImagesCollectionView)
        let carBrakeDiscPhotosPage = createPDFPage(dispatchGroup: dispatchGroup, collectionView: carBrakeDiscImagesCollectionView)
        let carMiscPhotosPage = createPDFPage(dispatchGroup: dispatchGroup, collectionView: carMiscImagesCollectionView)
        let carDamagesPhotosPage = PDFPageTemplate(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        for (index, url) in carDamageImagesCollectionView.photoUrlArray.suffix(4).enumerated()
        {
            dispatchGroup.enter()
            carDamagesPhotosPage.labelArray[index].text = carDamageImagesCollectionView.titleStringArray?[index]
            
            carDamagesPhotosPage.imageViewArray[index].loadImageUsingCacheWithUrlString(url) {
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            
            do
            {
                data = try PDFGenerator.generated(by: [frontPage, carPhotosPage, carMiscPhotosPage, carWheelPhotosPage, carBrakeDiscPhotosPage, carDamagesPhotosPage])
                
                if let data = data
                {
                    self.showAlertForEmail(data: data, title: title)
                }
                else
                {
                    self.showAlert(with: "An error occured while generating PDF, please try again.")
                }
                
            }catch (let error)
            {
                print("Error when generating PDF: \(error)")
            }
        }
    }
    
    private func showAlertForEmail(data: Data, title: String)
    {
        let alert = UIAlertController(title: "Indtast kundens navn og email", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (nameTextField: UITextField) in
            nameTextField.placeholder = "Name"
        })
        alert.addTextField(configurationHandler: { (emailTextField: UITextField) in
            emailTextField.placeholder = "Email"
            emailTextField.keyboardType = .emailAddress
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (okayButton: UIAlertAction) in
            
            guard let name = alert.textFields?[0].text, let email = alert.textFields?[1].text else { return }
            
            let isValid = name.count > 0 && email.count > 0
            okayButton.isEnabled = isValid ? true : false
            
            do
            {
                self.showMailController(data: data, title: title, name: name, email: email)
            }
        }))
        present(alert, animated: true, completion: nil)
    }

    private func showMailController(data: Data, title: String, name: String, email: String)
    {
        let mailController = MailController()
        mailController.didSendDelegate = self
        mailController.setEmailValues(title: title, data: data, name: name, email: email)
        mailController.mailComposeDelegate = mailController
        self.present(mailController, animated: true, completion: nil)
    }
    
    func didSendEmail()
    {
        if let keyWindow = UIApplication.shared.keyWindow
        {
            keyWindow.addSubview(uploadingView)
            uploadingView.anchor(top: keyWindow.topAnchor, left: keyWindow.leftAnchor, bottom: keyWindow.bottomAnchor, right: keyWindow.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
            uploadingView.statusLabel.text = "Sending..."
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.uploadingView.alpha = 1
                
            }, completion: { (completed) in
                
                self.uploadingView.carImage.image = #imageLiteral(resourceName: "postcar").withRenderingMode(.alwaysTemplate)
                self.uploadingView.carImage.handleCarAnimation(self.uploadingView.frame.minX - 40, self.uploadingView.frame.midY - 29, self.uploadingView.frame.maxX + 40, self.uploadingView.frame.midY - 29)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.45)
                {
                    self.uploadingView.statusLabel.text = "Sent!"
                    self.uploadingView.carImage.cancelCarAnimation()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                    {
                        self.uploadingView.removeFromSuperview()
                    }
                }
            })
        }
    }
    
    private func createPDFPage(dispatchGroup: DispatchGroup, collectionView: ReviewCollectionView) -> PDFPageTemplate
    {
        let pdfPage = PDFPageTemplate(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        for (index, url) in collectionView.photoUrlArray.enumerated()
        {
            dispatchGroup.enter()
            
            pdfPage.labelArray[index].text = collectionView.titleStringArray?[index]
            
            pdfPage.imageViewArray[index].loadImageUsingCacheWithUrlString(url) {
                dispatchGroup.leave()
            }
        }
        
        return pdfPage
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
        scrollView.addSubview(wheelContainerView)
        scrollView.addSubview(brakeDiscContainerView)
        scrollView.addSubview(serviceContainerView)
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
        
        wheelContainerView.anchor(top: carDamageImagesCollectionView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 135)
        
        brakeDiscContainerView.anchor(top: wheelContainerView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 170)
        
        serviceContainerView.anchor(top: brakeDiscContainerView.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingRight: 0, paddingBottom: 0, width: width, height: 135)
        
        finishButton.anchor(top: serviceContainerView.bottomAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 50, paddingLeft: 18, paddingRight: 0, paddingBottom: -30, width: 120, height: 50)
        finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}






















