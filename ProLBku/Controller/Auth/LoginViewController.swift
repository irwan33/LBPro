//
//  LoginViewController.swift
//  ProLBku
//
//  Created by mac on 05/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: TLFloatLabelTextField!
    @IBOutlet weak var passwordText: TLFloatLabelTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    @IBAction func forgotPasswordVC(_ sender: Any) {
        
        self.view.endEditing(true)
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPassword") as! ForgotPasswordViewController
        self.present(signUp, animated: true, completion: nil)
    }

    @IBAction func registerVC(_ sender: Any) {
        
        self.view.endEditing(true)
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "SignUp1ViewController") as! SignUp1ViewController
        self.present(signUp, animated: true, completion: nil)
    }
    
    @IBAction func lgoToLogin(_ sender: Any) {
        getLogin()
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
    
    
    func getLogin() {
        UserEngine.login(emailText.text!, password: passwordText.text!, completionHandler: { (result, error) in
            DispatchQueue.main.async(execute: { () -> Void in
               
                
                var message = ""
                
                if error == nil{
                    
                    if let base = result as? BaseResponse{
                        print(base.lautan_berlian!)
                       
                        if base.access_token != nil {
                             print(base.access_token!)
                        }
                        if base.lautan_berlian! == "logged_in" {
                            let signUp = self.storyboard?.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
                            self.present(signUp, animated: true, completion: nil)
                        } else {
                          print(base.lautan_berlian!)
                            self.showToast(message: base.lautan_berlian!)
                            let alertController = UIAlertController(title: " ", message:
                                base.lautan_berlian!, preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }

                    }
                    
                }else{
                    message = error!.localizedDescription
                }
                

            })
        })
    }

    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 190, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
