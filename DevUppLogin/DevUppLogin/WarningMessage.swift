//
//  WarningMessage.swift
//  DevUppLogin
//
//  Created by erwin on 2/5/17.
//  Copyright © 2017 DevUpp. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showWarningMassage(_ title: String = "Warning", message: String) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
}
