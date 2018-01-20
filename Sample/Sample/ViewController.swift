//
//  ViewController.swift
//  Sample
//
//  Created by Meniny on 2018-01-21.
//  Copyright © 2018年 Meniny. All rights reserved.
//

import UIKit
import SuperAlertController
import SuperAlertControllerPickers

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func alert(_ sender: UIButton) {
        let azure = #colorLiteral(red: 0.05, green:0.49, blue:0.98, alpha:1.00)
        let alertController = SuperAlertController.init(style: .alert, source: self.view, title: "Picker", message: "This is a Image picker", tintColor: azure)
        let images: [UIImage] = [
            #imageLiteral(resourceName: "sample-1"),
            #imageLiteral(resourceName: "sample-2"),
            #imageLiteral(resourceName: "sample-3"),
            #imageLiteral(resourceName: "sample-4"),
            #imageLiteral(resourceName: "sample-5")
        ]
        alertController.addImagePicker(.vertical, paging: true, height: 320, images: images, selection: .single({ img in
            print(String.init(describing: img))
        }))
        alertController.addAction(image: nil, title: "Done", color: azure, style: .default, isEnabled: true) { (_) in
            alertController.hide(completion: nil)
        }
        alertController.show(animated: true, vibrate: true, serial: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

