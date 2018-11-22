//
//  LoadingOnBackgroundThreadViewController.swift
//  MultithreadingDemo
//
//  Created by Lubos Ilcik on 25/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class LoadingOnBackgroundThreadViewController: UIViewController {

    static var instanceCount = 0
    var instanceNum = 0
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loading image...")
        DispatchQueue.global(qos: .userInteractive).async {
            if let imageURL = URL(string: imageURLString) {
                if let imageData = try? Data(contentsOf: imageURL) {
                    
                    DispatchQueue.main.async {
                        self.image.image = UIImage(data: imageData)
                        print("image loaded")
                    }
                    
                } else {
                    print("failed to load image - data nil")
                }
            } else {
                print("failed to load image - url nil")
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear \(instanceNum)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewDidDisappear \(instanceNum)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        LoadingOnBackgroundThreadViewController.instanceCount += 1
        instanceNum = LoadingOnBackgroundThreadViewController.instanceCount
        super.init(coder: aDecoder)
        print("init \(instanceNum)")
    }
    
    deinit {
        print("deinit \(instanceNum)")
    }

}
