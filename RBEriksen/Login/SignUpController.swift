//
//  SignUpController.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 07/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import Firebase

protocol CarListControllerDelegate
{
    func observeReports()
}

class SignUpController: UIViewController
{
    var timer: Timer?
    var delegate: CarListControllerDelegate?
    
    lazy var backgroundImageView: UIImageView =
        {
            let iv = UIImageView(image: #imageLiteral(resourceName: "bg-mobile-menu"))
            iv.contentMode = .scaleAspectFill
            iv.isUserInteractionEnabled = true
            
            return iv
    }()
    
    let emailTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.textAlignment = .center
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let passwordTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.textAlignment = .center
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let repeatPasswordTextField: UITextField =
    {
        let tf = UITextField()
        tf.placeholder = "Repeat Password"
        tf.font = UIFont(name: "Montserrat-Regular", size: 24)
        tf.textColor = .white
        tf.tintColor = .lightBlue
        tf.placeHolderTextColor = UIColor.init(white: 1.0, alpha: 0.5)
        tf.textAlignment = .center
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        
        return tf
    }()
    
    let signUpButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitle("Opret Bruger", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .lightBlue
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleCreateUser), for: .touchUpInside)
        button.alpha = 0.7
        
        return button
    }()
    
    let backToLoginButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitle("Tilbage til Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        button.setTitleColor(UIColor.lightBlue, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.lightBlue.cgColor
        button.addTarget(self, action: #selector(handleGoBackToLogin), for: .touchUpInside)
        
        return button
    }()
    
    let emailUnderLine: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let passwordUnderLine: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let repeatPasswordUnderLine: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let leftSeperatorLine: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let rightSeperatorLine: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let ellerLabel: UILabel =
    {
        let label = UILabel()
        label.text = "ELLER"
        label.font = UIFont(name: "Montserrat-Thin", size: 22)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }()
    
    let carImage: CarAnimationImageView =
    {
        let carImage = CarAnimationImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        return carImage
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupUI()
        applyMotionEffect(view: backgroundImageView, magnitude: 40)
        hideKeyboardWhenTappedAround()
    
    }
    
    @objc private func handleCreateUser()
    {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let repeatPassword = repeatPasswordTextField.text else { return }
        
        if password != repeatPassword
        {
            self.showAlert(with: "The passwords you have entered does not match.")
            return
        }
        
        prepareForCarAnimation()
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let err = error
            {
                print(err)
                self.carImage.cancelCarAnimation()
                self.resetEllerLabel()
                self.showAlert(with: "Something unexpected happened... Please try again!")
                return
            }
            
            guard let uid = user?.uid else { return }
            let token = InstanceID.instanceID().token()
            
            let dictionaryValues = ["email": email, "fcmToken": token ?? "0"] as [String : Any]
            let values = [uid: dictionaryValues]
            
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, ref) in
                
                if error != nil
                {
                    self.carImage.cancelCarAnimation()
                    self.resetEllerLabel()
                    self.showAlert(with: "Something unexpected happened... Please try again!")
                    return
                }
                
                Messaging.messaging().subscribe(toTopic: "RBEriksen")
                
                self.dismiss(animated: true, completion: {
                    self.delegate?.observeReports()
                })
            })
        }
    }
    
    private func resetEllerLabel()
    {
        self.ellerLabel.alpha = 1
        self.leftLineLeftAnchor?.constant = 10
        self.leftLineRightAnchor?.constant = -8
        self.rightLineRightAnchor?.constant = -10
        self.rightLineLeftAnchor?.constant = 8
        self.view.layoutIfNeeded()
    }
    
    private func prepareForCarAnimation()
    {
        leftLineLeftAnchor?.constant = -10
        leftLineRightAnchor?.constant = 40
        rightLineRightAnchor?.constant = 10
        rightLineLeftAnchor?.constant = -40
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
            self.ellerLabel.alpha = 0
            self.view.layoutIfNeeded()
            
        }) { (completed) in
            
            self.carImage.handleCarAnimation(self.view.frame.minX - 40, self.ellerLabel.frame.midY - 5, self.view.frame.maxX + 40, self.ellerLabel.frame.midY - 5)
        }
    }
    
    @objc private func handleGoBackToLogin()
    {
        navigationController?.popViewController(animated: false)
    }

    @objc private func handleEditingChanged()
    {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let repeatPassword = repeatPasswordTextField.text else { return }
        let isValid = email.count > 5 && password.count > 5 && repeatPassword.count > 2

        signUpButton.isEnabled = isValid ? true : false
        
        UIView.animate(withDuration: 0.3) {
            
            self.signUpButton.alpha = isValid ? 1 : 0.7
        }
    }
    
    var leftLineLeftAnchor: NSLayoutConstraint?
    var leftLineRightAnchor: NSLayoutConstraint?
    var rightLineLeftAnchor: NSLayoutConstraint?
    var rightLineRightAnchor: NSLayoutConstraint?
    
    private func setupUI()
    {
        view.addSubview(backgroundImageView)
        view.addSubview(emailTextField)
        view.addSubview(emailUnderLine)
        view.addSubview(passwordTextField)
        view.addSubview(passwordUnderLine)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(repeatPasswordUnderLine)
        view.addSubview(signUpButton)
        view.addSubview(backToLoginButton)
        view.addSubview(ellerLabel)
        view.addSubview(leftSeperatorLine)
        view.addSubview(rightSeperatorLine)
        view.addSubview(carImage)
        
        backgroundImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: -50, paddingLeft: -50, paddingRight: -50, paddingBottom: 50, width: 0, height: 0)
        
        emailTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 110, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 40)
        
        emailUnderLine.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor, bottom: nil, right: emailTextField.rightAnchor, paddingTop: -3, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 1)
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 40)
        
        passwordUnderLine.anchor(top: passwordTextField.bottomAnchor, left: passwordTextField.leftAnchor, bottom: nil, right: passwordTextField.rightAnchor, paddingTop: -3, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 1)
        
        repeatPasswordTextField.anchor(top: passwordTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 40)
        
        repeatPasswordUnderLine.anchor(top: repeatPasswordTextField.bottomAnchor, left: passwordTextField.leftAnchor, bottom: nil, right: passwordTextField.rightAnchor, paddingTop: -3, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 1)
        
        signUpButton.anchor(top: repeatPasswordTextField.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 50)
        
        ellerLabel.anchor(top: signUpButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        ellerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        leftSeperatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        leftLineLeftAnchor = leftSeperatorLine.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10)
        leftLineLeftAnchor?.isActive = true
        leftLineRightAnchor = leftSeperatorLine.rightAnchor.constraint(equalTo: ellerLabel.leftAnchor, constant: -8)
        leftLineRightAnchor?.isActive = true
        leftSeperatorLine.centerYAnchor.constraint(equalTo: ellerLabel.centerYAnchor).isActive = true
        
        rightSeperatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        rightLineLeftAnchor = rightSeperatorLine.leftAnchor.constraint(equalTo: ellerLabel.rightAnchor, constant: 8)
        rightLineLeftAnchor?.isActive = true
        rightLineRightAnchor = rightSeperatorLine.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)
        rightLineRightAnchor?.isActive = true
        
        rightSeperatorLine.centerYAnchor.constraint(equalTo: ellerLabel.centerYAnchor).isActive = true
        
        backToLoginButton.anchor(top: ellerLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 60, paddingLeft: 40, paddingRight: 40, paddingBottom: 0, width: 0, height: 50)
    }
    
    func applyMotionEffect(view: UIView, magnitude: CGFloat)
    {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
    }
    
}





























