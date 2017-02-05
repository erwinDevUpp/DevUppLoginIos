//
//  LoginViewController.swift
//  DevUppLogin
//
//  Created by erwin on 2/5/17.
//  Copyright © 2017 DevUpp. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var forgotPassword: UILabel!
    
    @IBOutlet weak var btn_view04_SignUp: UIButton!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var check: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if loggedIn(){
            showHomeViewController()
            return
        }
        
        // enable keyboard hiding
        self.hideKeyboardWhenTappedAround()
        setValidUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func check(_ sender: AnyObject) {
        check.isHidden = !check.isHidden
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        //        show06SelectCategory()
        login()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func login(){
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        let emailTrimmed = email.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let passwordTrimmed = password.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let params = ["email": emailTrimmed! as String, "password": passwordTrimmed! as String]
        print("params")
        print(params)
        Alamofire.request("http://hark.azurewebsites.net/Profile/Authenticate",
                          method: .post,
                          parameters: params,
                          //encoding: JSONEncoding.default)
            encoding: URLEncoding.default,
            headers:["Content-Type" : "application/x-www-form-urlencoded"])
            .responseJSON(completionHandler: { response in
                // do whatever you want here
                switch response.result {
                case .failure( _):
                    PKHUD.sharedHUD.contentView = PKHUDErrorView()
                    break
                case .success(let data):
                    let encodedString : NSData = (data as! NSString).data(using: String.Encoding.utf8.rawValue)! as NSData
                    var json = JSON(data: encodedString as Data)
                    if(json["data"].stringValue.isEmpty){
                        if !self.check.isHidden{
                            UserDefaults.standard.set(1, forKey: "loggedCode")
                        }
                        self.showHomeViewController()
                    }else{
                        self.showWarningMassage(message: json["data"].stringValue)
                    }
                    break
                } // end switch
                PKHUD.sharedHUD.hide()
            }) // end alamofire call
    }
    
    func setValidUser(){
        if Constants.testMode{
            email.text = "bkennedy@devupp.com"
            password.text = "Bubba1!"
        }
    }
    
    func loggedIn() -> Bool{
        if let loggedCode = (UserDefaults.standard.object(forKey: "loggedCode") as? Int){
            if loggedCode == 1{
                return true
            }
        }
        
        return false
    }
    
    func showHomeViewController(){
        let mainStoryboard = UIStoryboard(name: "main2", bundle: Bundle.main)
        let homeViewController : ViewController = mainStoryboard.instantiateViewController(withIdentifier: "homeViewController") as! ViewController
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
}

