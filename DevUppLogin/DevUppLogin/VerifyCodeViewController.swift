//
//  VerifyCodeViewController.swift
//  DevUppLogin
//
//  Created by erwin on 2/5/17.
//  Copyright © 2017 DevUpp. All rights reserved.
//

import UIKit

class VerifyCodeViewController: UIViewController {
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func verifyCode(_ sender: AnyObject) {
        showChangePassViewController()
    }
    
    func showChangePassViewController(){
        let mainStoryboard = UIStoryboard(name: "main2", bundle: Bundle.main)
        let homeViewController : ChangePassViewController = mainStoryboard.instantiateViewController(withIdentifier: "changePassViewController") as! ChangePassViewController
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
}
