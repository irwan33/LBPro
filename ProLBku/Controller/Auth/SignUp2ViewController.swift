//
//  SignUp2ViewController.swift
//  ProLBku
//
//  Created by mac on 12/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import UIKit

class SignUp2ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var password: TLFloatLabelTextField!
    @IBOutlet weak var ulangiPassword: TLFloatLabelTextField!
    @IBOutlet weak var nomorTelepon: TLFloatLabelTextField!
    @IBOutlet weak var alamat: TLFloatLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func next2(_ sender: Any) {
        UserDefaults.standard.set(password.text, forKey: "PASSWORD")
        UserDefaults.standard.set(ulangiPassword.text, forKey: "ULANGIPASSWORD")
        UserDefaults.standard.set(nomorTelepon.text, forKey: "NOMORTELEPON")
        UserDefaults.standard.set(alamat.text, forKey: "ALAMAT")
        
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.present(signUp, animated: true, completion: nil)
    }
    

    @objc func keyboardWillAppear(_ notification: Foundation.Notification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            //            self.bottomConstraint.constant = keyboardFrame.size.height + 20
            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardFrame.size.height), 0.0);
            self.scrollView.contentInset = contentInsets
        })
    }
    
    @objc func keyboardWillHide() {
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        self.scrollView.contentInset = contentInsets
    }
}
