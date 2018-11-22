//
//  NSURLSessionViewController.swift
//  MultithreadingDemo
//
//  Created by Lubos Ilcik on 25/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class NSURLSessionViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")

        if let url = URL(string: imageURLString) {
            print("loading image...")
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data, error == nil else {
                    print("error loading data")
                    return
                }
                print("image loaded")
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }).resume()
        }
    }

    deinit {
        print("deinit")
    }
}
