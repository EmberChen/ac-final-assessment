//
//  ViewController.swift
//  SixCustomCollectionViewCell
//
//  Created by Ember on 2017/5/13.
//  Copyright © 2017年 Ember. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var label: UILabel!
    
    var isBlue = false
    var contentText = ["Alert view","Color switch","Core motion","App's setting page","Navigator","Mail"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.label.text = contentText[indexPath.row]
     
        return cell
    }
    
    //to decide the cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular{
        
            return CGSize(width: (view.frame.width/2)-1, height: (view.frame.height/3)-1)
        }else{
        
            return CGSize(width: (view.frame.width/3)-1, height: (view.frame.height/2)-1)
        }
    }
    
    //reload cell when rotate screen
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        switch indexPath {
        case [0,0]:

            let alertView = UIAlertController(title: "Alert View", message: "\nYou just tap the alert-view cell!", preferredStyle: .alert)
            let dismissAlert = UIAlertAction(title: "close", style: .cancel, handler: nil)
            alertView.addAction(dismissAlert)
            self.present(alertView, animated: true, completion: nil)
            
        case [0,1]:

            let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
            
            if isBlue == true{
                cell.backgroundColor = UIColor.red
                cell.label.textColor = UIColor.white
                isBlue = false
            }else{
                cell.backgroundColor = UIColor.blue
                cell.label.textColor = UIColor.white
                isBlue = true
            }

        case [0,2]:
            print(indexPath)
        case [0,3]:
            print(indexPath)
        case [0,4]:
            print(indexPath)
        case [0,5]:
            print(indexPath)
        default:
            return
        }
    }
    
}

