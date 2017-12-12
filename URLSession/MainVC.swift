//
//  ViewController.swift
//  URLSession
//
//  Created by Bhavneet Singh on 12/12/17.
//  Copyright © 2017 Bhavneet Singh. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    let httpMethods = [HTTPMethod.get, HTTPMethod.put,
                       HTTPMethod.delete, HTTPMethod.post]
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initialSetup() {
        
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
    }
    
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return httpMethods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionCell", for: indexPath) as? ButtonCollectionCell else {
            fatalError("Cell Not Found")
        }
        cell.button.setTitle(self.httpMethods[indexPath.item].rawValue, for: .normal)
        
        switch self.httpMethods[indexPath.item] {
        case .get: cell.button.addTarget(self, action: #selector(MainVC.get(_:)), for: .touchUpInside)
        case .put: cell.button.addTarget(self, action: #selector(MainVC.put(_:)), for: .touchUpInside)
        case .delete: cell.button.addTarget(self, action: #selector(MainVC.deleteMethod(_:)), for: .touchUpInside)
        case .post: cell.button.addTarget(self, action: #selector(MainVC.post(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        return CGSize(width: (screenSize.width/2)-30, height: 50)
    }
}

// FUNCTIONS
extension MainVC {
    
    @objc private func get(_ btn: UIButton) {
        print(#function)
        
        
        WebServices.getPosts(parameter: JSONDictionary(), success: { (json) in
            
        }) { (error) in
            
        }
    }
    
    @objc private func put(_ btn: UIButton) {
        print(#function)
        
        
        WebServices.putPost(parameter: JSONDictionary(), success: { (json) in
            
        }) { (error) in
            
        }
    }

    @objc private func deleteMethod(_ btn: UIButton) {
        print(#function)
        
        
        WebServices.deletePost(parameter: JSONDictionary(), success: { (json) in
            
        }) { (error) in
            
        }
    }

    @objc private func post(_ btn: UIButton) {
        print(#function)
        
        let params: JSONDictionary = ["name": "Bhavneet Singh", "number": "987654321"]
        
        WebServices.postPosts(parameter: params, success: { (json) in
            print(json)
        }) { (error) in
            
        }
    }
}

class ButtonCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var mainBackView: UIView!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initialSetup()
    }
    
    private func initialSetup() {
        
        self.mainBackView.layer.cornerRadius = 5
        
    }
}

