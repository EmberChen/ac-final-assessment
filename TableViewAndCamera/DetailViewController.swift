//
//  DetailViewController.swift
//  TableViewAndCamera
//
//  Created by Ember on 2017/5/14.
//  Copyright © 2017年 Ember. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet weak var photoImgeView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var photo:PhotoMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoScrollView.delegate = self
        photoScrollView.minimumZoomScale = 1.0
        photoScrollView.maximumZoomScale = 4.0
        photoScrollView.zoomScale = 1.0
        
        photoImgeView.image = UIImage(data: photo.photo! as Data)
        nameLabel.text = photo.name
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImgeView
    }
 
    //share function
    @IBAction func shareButton(_ sender: UIBarButtonItem) {
        let defaultText = photo.name!
        if let imageToShare = UIImage(data: photo.photo! as Data) {
            let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
    }
}
