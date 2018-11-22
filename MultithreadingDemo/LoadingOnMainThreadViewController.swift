//
//  LoadingOnMainThreadViewController.swift
//  MultithreadingDemo
//
//  Created by Lubos Ilcik on 25/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class LoadingOnMainThreadViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loading image...")
        if let imageURL = URL(string: imageURLString) {
            if let imageData = try? Data(contentsOf: imageURL) {
                image.image = UIImage(data: imageData)
                print("image loaded")
            } else {
                print("failed to load image - data nil")
            }
        } else {
            print("failed to load image - url nil")
        }
    }

}
