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
    
    var isBlue = true
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
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if indexPath.row == 1{
            print(indexPath)
            
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
        }
    }
    
    
    func colorSwitch(color:UIColor) -> UIColor{
        if color == UIColor.blue{
            return UIColor.red
        }else{
            return UIColor.blue
        }
    }
    
}

