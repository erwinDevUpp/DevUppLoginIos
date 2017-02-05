//
//  ForgotPasswordViewController.swift
//  DevUppLogin
//
//  Created by erwin on 2/5/17.
//  Copyright © 2017 DevUpp. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem?.title = "Forgot Password"
        email.layer.cornerRadius = 6.0
        email.layer.masksToBounds = true
        email.layer.borderColor = UIColor( red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0 ).cgColor
        email.layer.borderWidth = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
