//
//  CarListController.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 07/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit
import Firebase

class CarListController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CarListControllerDelegate
{
    let cellId = "cellId"
    
    var reports = [Report]()
    var reportsDictionary = [String: Report]()
    var timer: Timer?
    
    let loadingIndicator: UIActivityIndicatorView =
    {
        let iv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        iv.hidesWhenStopped = true
        iv.color = .dark
        iv.tintColor = .dark
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        
        view.addSubview(loadingIndicator)
        loadingIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        checkIfUserIsSignedIn()
        setupCollectionView()
        setupNavigationBar()
    }
    
    internal func observeReports()
    {
        self.attemptReloadOfTable()
        
        Database.database().reference().child("reports").observe(.childAdded, with: { (snapshot) in
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let report = Report(dictionary: dictionary)
            
            self.reportsDictionary[snapshot.key] = report
            
            self.attemptReloadOfTable()
            
        }, withCancel: nil)
    }
    
    private func attemptReloadOfTable()
    {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }
    
    @objc func handleReloadTable()
    {
        self.reports = Array(self.reportsDictionary.values)
        
        self.reports.sort { (report1, report2) -> Bool in
            
            return (report1.timestamp?.int32Value)! > (report2.timestamp?.int32Value)!
        }
        
        DispatchQueue.main.async(execute:
            {
                self.collectionView?.reloadData()
                self.loadingIndicator.stopAnimating()
        })
    }
    
    private func setupCollectionView()
    {
        collectionView?.backgroundColor = .white
        collectionView?.register(CarCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsetsMake(10, 0, 0, 0)
    }
    
    private func setupNavigationBar()
    {
        navigationItem.title = "RBEriksen"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleNewCar))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "shutdown").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    @objc private func handleNewCar()
    {
        let carNameController = CarNameController()
        navigationController?.pushViewController(carNameController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let report = reports[indexPath.row]
        
        let reviewController = ReviewController()
        reviewController.report = report
        navigationController?.pushViewController(reviewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CarCell
        let report = reports[indexPath.row]
        
        if let frontPhotoOfCar = report.carPhotos!["carPhoto0"]
        {
            cell.carImageView.loadImageUsingCacheWithUrlString(frontPhotoOfCar)
        }
        
        cell.carNameLabel.text = "\(report.carBrand ?? "Car Brand"), \(report.carSeries ?? "Car Series")"
        
        if let seconds = report.timestamp?.doubleValue
        {
            let timestampDate = Date(timeIntervalSince1970: seconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM"
            cell.dateLabel.text = "at " + dateFormatter.string(from: timestampDate)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return reports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = view.frame.width - 24
        return CGSize(width: width, height: 200)
    }
    
    private func checkIfUserIsSignedIn()
    {
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if user != nil
            {
                self.loadingIndicator.startAnimating()
                DispatchQueue.global(qos: .background).async {
                    self.observeReports()
                }
                return
            }
            else
            {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.isNavigationBarHidden = true
                self.present(navController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleLogOut()
    {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (_) in
            
            do
            {
                try Auth.auth().signOut()
                
                let loginController = LoginController()
                let navController = CustomNavigationController(rootViewController: loginController)
                navController.isNavigationBarHidden = true
                self.present(navController, animated: true, completion: nil)
            }
            catch let error
            {
                print("Failed to signout", error)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
