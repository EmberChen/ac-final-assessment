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
        
        getRequest(address: getAddress)
        
    }
    
    @IBAction func postButton(_ sender: UIButton) {
    }
    
    func getRequest(address:String){
        
        let url = URL(string: address.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        
        var urlRequest = URLRequest(url:url!)

        urlRequest.httpMethod = "GET"
        
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
    
    func postRequest(address:String){
        
        let url = URL(string: address.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        
        var urlRequest = URLRequest(url:url!)
        
        urlRequest.httpMethod = "POST"
        
        //date handle
        let postTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeString = dateFormatter.string(from: postTime)
        
        //data to be post
        let params = ["time": timeString]
        
        do {
            // pass dictionary to nsdata object and set it as request body
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print(error!)
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }

   
    
}

