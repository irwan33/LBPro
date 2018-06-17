//
//  ForgotPasswordViewController.swift
//  ProLBku
//
//  Created by mac on 04/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTxt: TLFloatLabelTextField!
    @IBOutlet weak var scrollView: UIScrollView!
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

    @IBAction func sendEmailVC(_ sender: Any) {
        
        self.view.endEditing(true)
        getforgotpassword()

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
    
    
    func getforgotpassword() {
        UserEngine.forgotPassword(emailTxt.text!, completionHandler: { (result, error) in
            DispatchQueue.main.async(execute: { () -> Void in
                
                
                
                
                if error == nil{
                    
                    if let base = result as? BaseResponse{
                        print(base.lautan_berlian!)
                        
                        
                        print(base.lautan_berlian!)
                        if base.lautan_berlian! == "unregistered_email" {
                        let alertController = UIAlertController(title: base.lautan_berlian!, message:
                            base.message!, preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                        } else {
                        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "KonfirmasiEmailViewController") as! KonfirmasiEmailViewController
                        self.present(signUp, animated: true, completion: nil)
                        }
                    }
                    
                }
                
                
            })
        })
    }
  
}


