//
//  ViewController.swift
//  DevUppLogin
//
//  Created by erwin on 2/1/17.
//  Copyright © 2017 DevUpp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentViewContrllersCount: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(currentViewContrllersCount > (self.navigationController?.viewControllers.count)!){
            UserDefaults.standard.set(0, forKey: "loggedCode")
        }
    }


}

