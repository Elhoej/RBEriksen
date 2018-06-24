//
//  PreviewPhotoView.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 09/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

protocol CarPhotoControllerDelegate
{
    func handleNext(_ carPhotoStage: CarPhotoStage, _ previewPhoto: UIImage)
}

class PreviewPhotoView: UIView
{
    var delegate: CarPhotoControllerDelegate?
    var carPhotoStage: CarPhotoStage?
    
    let previewImageView: UIImageView =
    {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    let cancelButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        
        return button
    }()
    
    let nextButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "right-arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.backgroundColor = .lightBlue
        button.layer.cornerRadius = 30
        
        return button
    }()
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        setupUI()
    }
    
    @objc private func handleNext()
    {
        guard let stage = carPhotoStage else { return }
        guard let image = previewImageView.image else { return }
        self.delegate?.handleNext(stage, image)
        self.removeFromSuperview()
    }
    
    @objc private func handleCancel()
    {
        self.removeFromSuperview()
    }
    
    
    fileprivate func setupUI()
    {
        addSubview(previewImageView)
        addSubview(cancelButton)
        addSubview(nextButton)
        
        previewImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        cancelButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        
        nextButton.anchor(top: nil, left: nil, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 24, paddingBottom: -12, width: 60, height: 60)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
























