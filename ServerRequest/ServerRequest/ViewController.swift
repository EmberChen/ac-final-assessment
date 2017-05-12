//
//  ViewController.swift
//  ServerRequest
//
//  Created by Ember on 2017/5/12.
//  Copyright © 2017年 Ember. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let getAddress = "https://httpbin.org/get"
    let postAddress = "https://httpbin.org/post"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getButton(_ sender: UIButton) {
        
        requestHandler(address: getAddress, requestMethod: "GET")
        
    }
    
    @IBAction func postButton(_ sender: UIButton) {
    }
    
    func requestHandler(address:String,requestMethod:String){
        
        let url = URL(string: address.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        
        var urlRequest = URLRequest(url:url!)

        urlRequest.httpMethod = requestMethod
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
            data, response, error in
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString!)")
            
            // Check for error
            if error != nil {
                print("error=\(error!)")
            } else {
                print("Get data successfully.")
            }
        }
        task.resume()

    }
   
    
}

