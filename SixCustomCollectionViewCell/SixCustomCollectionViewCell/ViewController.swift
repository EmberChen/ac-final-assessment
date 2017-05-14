//
//  ViewController.swift
//  SixCustomCollectionViewCell
//
//  Created by Ember on 2017/5/13.
//  Copyright © 2017年 Ember. All rights reserved.
//

import UIKit
import MessageUI
import CoreMotion

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var label: UILabel!
    
    var pedometer:CMPedometer!
    var isBlue = false
    var isWalk = false
    var contentText = ["Alert view","Color switch","Core motion","Setting","Navigator","Mail"]
    
    
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
            
            guard CMPedometer.isStepCountingAvailable() else {
                
                let machineAlert = UIAlertController(title: "Machine Alert", message: "\nYour device isn't support coreMotion!", preferredStyle: .alert)
                let dismissAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                machineAlert.addAction(dismissAlert)
                self.present(machineAlert, animated: true, completion: nil)
                
                return
            }

        case [0,3]:
           
            let url = URL(string: UIApplicationOpenSettingsURLString)
            UIApplication.shared.open(url!)
            
        case [0,4]:
            
            //before this, need to add plist about LSApplication.......
            if  UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!){
                //latitude,longitude can't be blank, will fail
                UIApplication.shared.open(URL(string:"comgooglemaps://?daddr=Alpha+camp&zoom=16&views=driving")!)
            } else {
                let noGMapAlert = UIAlertController(title: "Warning!", message: "\nYou don't have google map app, please install it.", preferredStyle: .alert)
                let dismissAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                noGMapAlert.addAction(dismissAlert)
                self.present(noGMapAlert, animated: true, completion: nil)
            }
            
        case [0,5]:
           
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            if MFMailComposeViewController.canSendMail() {
                
                composeVC.setSubject("測試信件")
                self.present(composeVC, animated: true, completion: nil)
            } else {
                return
            }
            
            
        default:
            return
        }
    }
    
    //dismiss composeVC
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
}

