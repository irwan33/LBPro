//
//  SplashScreenViewController.swift
//  ProLBku
//
//  Created by mac on 05/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Timer.scheduledTimer(timeInterval: 2.1, target: self, selector: #selector(SplashScreenViewController.someSelector), userInfo: nil, repeats: false)
    }
    
    @objc func someSelector() {
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        self.present(signUp, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
