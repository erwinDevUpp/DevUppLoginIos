//
//  SignUpViewController.swift
//  DevUppLogin
//
//  Created by erwin on 2/5/17.
//  Copyright © 2017 DevUpp. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire
import SwiftyJSON
import Navajo_Swift

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirmation: UITextField!
    @IBOutlet weak var passwordValidation: UILabel!
    @IBOutlet weak var emailValidation: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        // enable keyboard hiding
        self.hideKeyboardWhenTappedAround()
        password.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        email.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func confirmSignUp(_ sender: AnyObject) {
        signup()
    }
    
    @IBAction func btnRegisterClicked(_ sender: UIButton) {
        // call API, and on success, return to login screen.
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "from_04_to_03_login", sender: self)
        }
    }
    
    @IBAction func hideNameKbd(_ sender: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction func hideZipKbd(_ sender: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction func hideBirthdayKbd(_ sender: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction func hideEmailKbd(_ sender: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction func hidePasswordKbd(_ sender: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction func hideConfirmKbd(_ sender: UITextField) {
        self.dismissKeyboard()
    }
    
    @IBAction func pickDate(_ sender: AnyObject) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
//        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        birthday.text = strDate
        dateView.isHidden = true
    }
    
    @IBAction func showDate(_ sender: AnyObject) {
        dateView.isHidden = false
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        validatePassword(password: password.text!)
        if (password.text?.isEmpty)!{
            passwordValidation.text = ""
        }
    }
    
    func emailTextFieldDidChange(_ textField: UITextField) {
        if !isValidEmail(testStr: email.text!){
            
            emailValidation.textColor = UIColor.red
            emailValidation.text = "Invalid"
        } else {
            emailValidation.textColor = UIColor.green
            emailValidation.text = "Valid"
            
        }
        if (email.text?.isEmpty)!{
            emailValidation.text = ""
        }
    }
    
    func validatePassword(password: String){
        let lengthRule = NJOLengthRule(min: 6, max: 24)
        let uppercaseRule = NJORequiredCharacterRule(preset: .lowercaseCharacter)
        
        let validator = NJOPasswordValidator(rules: [lengthRule, uppercaseRule])
        
        if let failingRules = validator.validate(password) {
            var errorMessages: [String] = []
            
            failingRules.forEach { rule in
                errorMessages.append(rule.localizedErrorDescription)
            }
            
            passwordValidation.textColor = UIColor.red
            passwordValidation.text = errorMessages.joined(separator: "\n")
        } else {
            passwordValidation.textColor = UIColor.green
            passwordValidation.text = "Valid"
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func signup(){
        let nameTrimmed = name.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let zipCodeTrimmed = zipCode.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let birthdayTrimmed = birthday.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let emailTrimmed = email.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let passwordTrimmed = password.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let passwordConfirmationTrimmed = passwordConfirmation.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if hasEmptyFields(name: nameTrimmed!, zipCode: zipCodeTrimmed!, birthday: birthdayTrimmed!, email: emailTrimmed!, password: passwordTrimmed!, passwordConfirmation: passwordConfirmationTrimmed!){
            self.showWarningMassage(message: "There must be no empty fields!")
            return
        }
        if passwordTrimmed != passwordConfirmationTrimmed{
            self.showWarningMassage(message: "Password did not match!")
            return
        }
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        let params = ["name": nameTrimmed! as String, "zipCode": zipCodeTrimmed! as String, "birthday": birthdayTrimmed! as String, "email": emailTrimmed! as String, "password": passwordTrimmed! as String]
        Alamofire.request("http://hark.azurewebsites.net/Profile/CreateProfile",
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
                    PKHUD.sharedHUD.contentView = PKHUDSuccessView()
                    self.showLoginViewController()
//                    self.performSegue(withIdentifier: "loginViewController", sender: self)
                    //                    if(json["data"].stringValue.isEmpty){
                    ////                        self.show06SelectCategory()
                    //                    }else{
                    //                        self.showWarningMassage(message: json["data"].stringValue)
                    //                    }
                    break
                } // end switch
                PKHUD.sharedHUD.hide()
            }) // end alamofire call
    }
    
    func hasEmptyFields(name: String, zipCode: String, birthday: String, email: String, password: String, passwordConfirmation: String) -> Bool{
        if (name.isEmpty || zipCode.isEmpty || birthday.isEmpty || email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty){
            return true
        }else{
            return false
        }
    }
    
    func showLoginViewController(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeViewController : LoginViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
}

