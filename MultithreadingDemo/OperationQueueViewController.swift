//
//  OperationQueueViewController.swift
//  MultithreadingDemo
//
//  Created by Lubos Ilcik on 25/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class OperationQueueViewController: UIViewController {

    lazy var loadImageQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "Image Loading queue"
        // config queue
        queue.maxConcurrentOperationCount = 1 // serial queue
        return queue
    }()
    
    class ImageLoaderOperation: Operation {
        let imageURL: URL
        var image: UIImage?

        init(imageURL: URL) {
            self.imageURL = imageURL
            print("operation init")
        }
        
        override func main() {
            
            if self.isCancelled {
                print("operation cancelled")
                return
            }
            
            let imageData = try? Data(contentsOf: imageURL)
            
            
            if self.isCancelled {
                print("operation cancelled")
                return
            }
            
            
            if imageData?.count > 0 {
                image = UIImage(data:imageData!)
            }
        }

        deinit {
            print("operation deinit")
        }
    }
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")

        if let url = URL(string: imageURLString) {
            let downloadImageOperation = ImageLoaderOperation(imageURL: url)
            downloadImageOperation.completionBlock = { [weak self, weak downloadImageOperation] in
                print("loading completed \(String(describing: downloadImageOperation?.image))")
                DispatchQueue.main.sync {
                    self?.image.image = downloadImageOperation?.image
                    print("image set: \(String(describing: downloadImageOperation?.image))")
                }
            }
            print("loading image...")
            loadImageQueue.addOperation(downloadImageOperation)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loadImageQueue.cancelAllOperations()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("VC init")
    }
    
    deinit {
        print("VC deinit")
    }
}
