//
//  KonfirmasiEmailViewController.swift
//  ProLBku
//
//  Created by mac on 05/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import UIKit

class KonfirmasiEmailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(signUp, animated: true, completion: nil)
        
    }

}
