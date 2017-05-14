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
    
        postRequest(address: postAddress)
    }
    
    //***********************************************
    
    func getRequest(address:String){
        
        let url = URL(string: address)
        var urlRequest = URLRequest(url:url!)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, AnyObject>
                    let origin = json["origin"]! as! String
                    NSLog("%@", origin)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()

    }
    
    func postRequest(address:String){
        
        let url = URL(string: address)
        var urlRequest = URLRequest(url:url!)
        urlRequest.httpMethod = "POST"
        
        //date handle
        let postTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeString = dateFormatter.string(from: postTime)
        
        do {
            let timeInfo = try JSONSerialization.data(withJSONObject: ["time" : timeString], options: .prettyPrinted)
            urlRequest.httpBody = timeInfo
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            print(error.localizedDescription)
        }

        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            //reference from Jay
            let costTime = Calendar(identifier: .gregorian).dateComponents([.nanosecond], from: postTime, to: Date())
            NSLog("%@", "花了\(costTime.nanosecond! / 1000000)秒")
        })
        
        task.resume()
       
    }

   
    
}

