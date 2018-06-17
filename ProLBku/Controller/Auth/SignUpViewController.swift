//
//  SignUpViewController.swift
//  ProLBku
//
//  Created by mac on 05/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var kota: TLFloatLabelTextField!
    @IBOutlet weak var provinsi: TLFloatLabelTextField!
    @IBOutlet weak var kodepos: TLFloatLabelTextField!
    
    var NAMADEPAN: String?
    var NAMABELAKANG: String?
    var EMAIL: String?
    var GENDER: String?
    var PASSWORD: String?
    var ULANGIPASSWORD: String?
    var NOMORTELEPON: String?
    var ALAMAT: String?
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadregister()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadregister() {
       self.GENDER = UserDefaults.standard.string(forKey: "GENDER")
       self.NAMADEPAN = UserDefaults.standard.string(forKey: "NAMADEPAN")
       self.NAMABELAKANG = UserDefaults.standard.string(forKey: "NAMABELAKANG")
       self.EMAIL = UserDefaults.standard.string(forKey: "EMAIL")
       self.PASSWORD = UserDefaults.standard.string(forKey: "PASSWORD")
       self.ULANGIPASSWORD = UserDefaults.standard.string(forKey: "ULANGIPASSWORD")
       self.NOMORTELEPON = UserDefaults.standard.string(forKey: "NOMORTELEPON")
       self.ALAMAT = UserDefaults.standard.string(forKey: "ALAMAT")
    }
    @IBAction func daftarButtonClicked(_ sender: Any) {
       signupSubmit()
        
    }

    @IBAction func backButtonClicked(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
        
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
    
    func signupSubmit() {
        UserEngine.signupUser( self.EMAIL!, first_name: self.NAMADEPAN!, last_name: self.NAMABELAKANG!, gender: self.GENDER!, pass1: self.PASSWORD!, pass2: self.ULANGIPASSWORD!, phone: self.NOMORTELEPON!, address: self.ALAMAT!, city: kota.text!, province: provinsi.text!, postal_code: kodepos.text!, completionHandler: { (result, error) in
            DispatchQueue.main.async(execute: { () -> Void in
                
                
                
                
                if error == nil{
                    
                    if let base = result as? BaseResponse{
                        print(base.lautan_berlian!)
                        

                        print(base.lautan_berlian!)
                        if base.lautan_berlian! == "empty_param" {
                            let alertController = UIAlertController(title: base.lautan_berlian!, message:
                                base.message!, preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        } else if base.lautan_berlian! == "registered_email" {
                            let alertController = UIAlertController(title: base.lautan_berlian!, message:
                                base.message!, preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                            
                        } else {
                            let alertController = UIAlertController(title: base.lautan_berlian!, message:
                                base.message!, preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.view.endEditing(true)
                            let signUp = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            self.present(signUp, animated: true, completion: nil)
                            
                            self.present(alertController, animated: true, completion: nil)
                            
                            
                        }
                    }
                    
                }
                
                
            })
        })
    }
}
