//
//  CarPhotoController.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 09/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import AVFoundation

protocol CarDamageControllerDelegate
{
    func insertNewCarDamagePhoto()
}

class CarPhotosController: UIViewController, AVCapturePhotoCaptureDelegate, CarPhotoControllerDelegate
{
    var delegate: CarDamageControllerDelegate?
    
    func handleNext(_ carPhotoStage: CarPhotoStage, _ previewImage: UIImage)
    {
        switch carPhotoStage {
        case .frontPhotoOfCar:
            DataContainer.shared.carPhotos.append(previewImage)
            self.carPhotoStage = .leftPhotoOfCar
            bounceAnimation(0.06, "Bilens venstre side")
        case .leftPhotoOfCar:
            DataContainer.shared.carPhotos.append(previewImage)
            self.carPhotoStage = .backPhotoOfCar
            bounceAnimation(0.12, "Bilen bagfra")
        case .backPhotoOfCar:
            DataContainer.shared.carPhotos.append(previewImage)
            self.carPhotoStage = .rightPhotoOfCar
            bounceAnimation(0.18, "Bilens højre side")
        case .rightPhotoOfCar:
            DataContainer.shared.carPhotos.append(previewImage)
            self.carPhotoStage = .rightFrontWheelPhoto
            bounceAnimation(0.25, "Højre fordæk")
        case .rightFrontWheelPhoto:
            DataContainer.shared.carWheelPhotos.append(previewImage)
            self.carPhotoStage = .rightFrontBrakeDiscPhoto
            bounceAnimation(0.31, "Højre forhjuls bremseskive")
        case .rightFrontBrakeDiscPhoto:
            DataContainer.shared.carBrakeDiscPhotos.append(previewImage)
            self.carPhotoStage = .leftFrontWheelPhoto
            bounceAnimation(0.37, "Venstre fordæk")
        case .leftFrontWheelPhoto:
            DataContainer.shared.carWheelPhotos.append(previewImage)
            self.carPhotoStage = .leftFrontBrakeDiscPhoto
            bounceAnimation(0.43, "Venstre forhjuls bremseskive")
        case .leftFrontBrakeDiscPhoto:
            DataContainer.shared.carBrakeDiscPhotos.append(previewImage)
            self.carPhotoStage = .leftBackWheelPhoto
            bounceAnimation(0.50, "Venstre bagdæk")
        case .leftBackWheelPhoto:
            DataContainer.shared.carWheelPhotos.append(previewImage)
            self.carPhotoStage = .leftBackBrakeDiscPhoto
            bounceAnimation(0.56, "Venstre baghjuls bremseskive")
        case .leftBackBrakeDiscPhoto:
            DataContainer.shared.carBrakeDiscPhotos.append(previewImage)
            self.carPhotoStage = .rightBackWheelPhoto
            bounceAnimation(0.62, "Højre bagdæk")
        case .rightBackWheelPhoto:
            DataContainer.shared.carWheelPhotos.append(previewImage)
            self.carPhotoStage = .rightBacktBrakeDiscPhoto
            bounceAnimation(0.68, "Højre baghjuls bremseskive")
        case .rightBacktBrakeDiscPhoto:
            DataContainer.shared.carBrakeDiscPhotos.append(previewImage)
            self.carPhotoStage = .frontInteriorPhoto
            bounceAnimation(0.75, "Interiøret foran")
        case .frontInteriorPhoto:
            DataContainer.shared.carMiscPhotos.append(previewImage)
            self.carPhotoStage = .backInteriorPhoto
            bounceAnimation(0.81, "Interiøret bagved")
        case .backInteriorPhoto:
            DataContainer.shared.carMiscPhotos.append(previewImage)
            self.carPhotoStage = .kilometerCounterPhoto
            bounceAnimation(0.87, "Kilometer måleren")
        case .kilometerCounterPhoto:
            DataContainer.shared.carMiscPhotos.append(previewImage)
            self.carPhotoStage = .serviceBookPhoto
            bounceAnimation(0.93, "Servicebog")
        case .serviceBookPhoto:
            DataContainer.shared.carMiscPhotos.append(previewImage)
            let carDamageController = CarDamageController()
            navigationController?.pushViewController(carDamageController, animated: true)
        case .carDamagePhoto:
            DataContainer.shared.carDamagePhotos.append(previewImage)
            dismiss(animated: true) {
                self.delegate?.insertNewCarDamagePhoto()
            }
        }
    }
    
    let output = AVCapturePhotoOutput()
    var carPhotoStage: CarPhotoStage = .frontPhotoOfCar
    
    let capturePhotoButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "capture_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        
        return button
    }()
    
    let flashButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "flash-off").withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(#imageLiteral(resourceName: "flash-on").withRenderingMode(.alwaysTemplate), for: .selected)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleFlashButton), for: .touchUpInside)
        button.isSelected = false
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowRadius = 1.5
        
        return button
    }()
    
    let progressView: UIProgressView =
    {
        let pv = UIProgressView(progressViewStyle: .bar)
        pv.backgroundColor = UIColor.init(white: 0.3, alpha: 0.3)
        pv.progressTintColor = .lightBlue
        pv.progress = 0.02
        
        return pv
    }()
    
    lazy var carPhotoLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Tag et billed af bilen forfra"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.textColor = .white
        label.sizeToFit()
        label.textAlignment = .center
        label.backgroundColor = UIColor.init(white: 0.3, alpha: 0.4)
        
        return label
    }()
    
    let dismissButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "left-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
        return button
    }()
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupUI()
    }
    
    @objc func handleFlashButton()
    {
        if flashButton.isSelected
        {
            flashButton.isSelected = false
        }
        else
        {
            flashButton.isSelected = true
        }
    }
    
    private func bounceAnimation(_ progress: Float, _ labelText: String)
    {
        self.carPhotoLabel.text = labelText
        self.view.layoutIfNeeded()
        self.progressView.setProgress(progress, animated: false)
        
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            self.carPhotoLabel.layer.transform = CATransform3DMakeScale(1.12, 1.12, 1.12)
            
        }) { (completed) in
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                self.carPhotoLabel.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
                
            }, completion:  nil)
        }
    }
    
    @objc private func handleDismiss()
    {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleCapturePhoto()
    {
        let settings = AVCapturePhotoSettings()
        
        if flashButton.isSelected
        {
            settings.flashMode = AVCaptureDevice.FlashMode.on
        }
        else
        {
            settings.flashMode = AVCaptureDevice.FlashMode.off
        }
        
        guard let previewSettings = settings.availablePreviewPhotoPixelFormatTypes.first else { return }
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey: previewSettings] as [String : Any]
        
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?)
    {
        guard let imageData = photo.fileDataRepresentation() else { return }
        let previewImage = UIImage(data: imageData)
        
        let previewPhotoView = PreviewPhotoView()
        previewPhotoView.delegate = self
        previewPhotoView.previewImageView.image = previewImage
        previewPhotoView.carPhotoStage = self.carPhotoStage
        
        view.addSubview(previewPhotoView)
        previewPhotoView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    private func setupCaptureSession()
    {
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input)
            {
                captureSession.addInput(input)
            }
        }
        catch let err
        {
            print("Could not setup camera input", err)
        }
        
        if captureSession.canAddOutput(output)
        {
            captureSession.addOutput(output)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    fileprivate func setupUI()
    {
        view.addSubview(dismissButton)
        view.addSubview(flashButton)
        view.addSubview(progressView)
        view.addSubview(carPhotoLabel)
        view.addSubview(capturePhotoButton)
        
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        
        flashButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingRight: 12, paddingBottom: 0, width: 50, height: 50)
        
        progressView.anchor(top: nil, left: dismissButton.rightAnchor, bottom: nil, right: flashButton.leftAnchor, paddingTop: 0, paddingLeft: 5, paddingRight: 5, paddingBottom: 0, width: 0, height: 3.5)
        progressView.centerYAnchor.constraint(equalTo: dismissButton.centerYAnchor).isActive = true
        
        carPhotoLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        carPhotoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        capturePhotoButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -24, width: 80, height: 80)
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
}



























