//
//  SignUp1ViewController.swift
//  ProLBku
//
//  Created by mac on 12/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import UIKit

class SignUp1ViewController: UIViewController, SSRadioButtonControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var namadepan: TLFloatLabelTextField!
    @IBOutlet weak var namabelakang: TLFloatLabelTextField!
    @IBOutlet weak var emailTxt: TLFloatLabelTextField!
    @IBOutlet weak var male: UIButton!
    @IBOutlet weak var female: UIButton!
    var rButton : String!
    var radioButtonController: SSRadioButtonsController?
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleradioBtn()
        getRadioButton()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getRadioButton() {
        radioButtonController = SSRadioButtonsController(buttons: male, female)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
    }
    
    func toggleradioBtn() {
        if rButton == "Laki-laki" {
            male.isSelected = true
        } else if rButton == "Perempuan" {
            female.isSelected = true
        }
     
    }
    
    func didSelectButton(selectedButton: UIButton?) {
        if male.isSelected{
            self.rButton = "Laki-laki"
        } else if female.isSelected {
            self.rButton = "Perempuan"
        }
    }

    @IBAction func next1(_ sender: Any) {
        print(rButton!)
        UserDefaults.standard.set(rButton!, forKey: "GENDER")
        UserDefaults.standard.set(namadepan.text, forKey: "NAMADEPAN")
        UserDefaults.standard.set(namabelakang.text, forKey: "NAMABELAKANG")
        UserDefaults.standard.set(emailTxt.text, forKey: "EMAIL")
        
        
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "SignUp2ViewController") as! SignUp2ViewController
        self.present(signUp, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
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
}
