//
//  SignInMainViewController.swift
//  DevUppLogin
//
//  Created by erwin on 2/5/17.
//  Copyright © 2017 DevUpp. All rights reserved.
//

import UIKit

class SignInMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if loggedIn(){
            showHomeViewController()
            return
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loggedIn() -> Bool{
        if let loggedCode = (UserDefaults.standard.object(forKey: "loggedCode") as? Int){
            if loggedCode == 1{
                return true
            }
        }
        
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func showHomeViewController(){
        let mainStoryboard = UIStoryboard(name: "main2", bundle: Bundle.main)
        let homeViewController : ViewController = mainStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! ViewController
        self.navigationController?.pushViewController(homeViewController, animated: false)
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
