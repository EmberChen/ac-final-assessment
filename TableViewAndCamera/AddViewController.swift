//
//  AddViewController.swift
//  TableViewAndCamera
//
//  Created by Ember on 2017/5/14.
//  Copyright © 2017年 Ember. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UITextFieldDelegate {

    var image:UIImage!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameTextField{
            scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = image
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
    
        navigationItem.leftBarButtonItem = backButton
    }
    
    //go back and handle saving to coredata
    func back() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let photo = PhotoMO(context: appDelegate.persistentContainer.viewContext)
        if let imageData = UIImageJPEGRepresentation(image, 1) {
            photo.photo = NSData(data: imageData)
        }
        photo.name = nameTextField.text!
        appDelegate.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    //end editing
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
    
   
}
