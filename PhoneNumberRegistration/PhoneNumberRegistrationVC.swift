//
//  PhoneNumberRegistrationVC.swift
//  PhoneNumberRegistration
//
//  Created by Surya Khattri on 2/27/18.
//  Copyright © 2018 Surya Khattri. All rights reserved.
//

import UIKit
import  SinchVerification
class PhoneNumberRegistrationVC: UIViewController {

    var verification:Verification!;
    var applicationKey = "b9bbdab3-8bfb-47be-ab84-c993966fcfde";
    
    @IBOutlet var lblPhoneNumberRegistration: UILabel!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var lblconfirmationSMS: UILabel!
    @IBOutlet var lblMerchantrade: UILabel!

    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet var btnSendConfirmationCode: UIButton!
    
    @IBOutlet var lblcallOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblconfirmationSMS.text = "         By tapping next above,eRemit will send \n        you a SMS message to confirm your \n                                phone number "
        
        lblMerchantrade.text = "        © 2018 Merchantrade Asia Sdb. Bsd. "
        // Do any additional setup after loading the view.
        
        btnSendConfirmationCode.backgroundColor = .clear
        btnSendConfirmationCode.layer.cornerRadius = 20
        btnSendConfirmationCode.layer.borderWidth = 1
        btnSendConfirmationCode.layer.borderColor = UIColor.red.cgColor
        
        
        lblcallOutButton.backgroundColor = .clear
        lblcallOutButton.layer.cornerRadius = 20
        lblcallOutButton.layer.borderWidth = 1
        lblcallOutButton.layer.borderColor = UIColor.red.cgColor

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        phoneNumberTextField.becomeFirstResponder();
        disableUI(false);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func disableUI(_ disable: Bool){
        var alpha:CGFloat = 1.0;
        if (disable) {
            alpha = 0.5;
            phoneNumberTextField.resignFirstResponder();
            spinner.startAnimating();
            self.lblPhoneNumberRegistration.text="";
            let delayTime =
                DispatchTime.now() +
                    Double(Int64(30 * Double(NSEC_PER_SEC)))
                    / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(
                deadline: delayTime, execute:
                { () -> Void in
                    self.disableUI(false);
            });
        }
        else{
            self.phoneNumberTextField.becomeFirstResponder();
            self.spinner.stopAnimating();
            
        }
        self.phoneNumberTextField.isEnabled = !disable;
        self.lblconfirmationSMS.isEnabled = !disable;
//        self.calloutButton.isEnabled = !disable;
//        self.calloutButton.alpha = alpha;
        self.lblconfirmationSMS.alpha = alpha;
    }
    
    
    @IBAction func btnSendConfirmationCode(_ sender: AnyObject) {
        
        self.disableUI(true);
        verification = SMSVerification(applicationKey, phoneNumber: phoneNumberTextField.text!)
        
        verification.initiate { (result: InitiationResult, error:Error?) -> Void in
            self.disableUI(false);
         //   if (success.success){
                self.performSegue(withIdentifier: "enterPin", sender: sender)

          //  } else {
             //   self.lblPhoneNumberRegistration.text = error?.localizedDescription
            }
     //   }

        
    }
    

    @IBAction func phoneNumberRegistrationActionButton(_ sender:
        Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func calloutVerification(_ sender: AnyObject) {
        
        disableUI(true);
        verification = CalloutVerification(applicationKey,
                                           phoneNumber: phoneNumberTextField.text!);
        verification.initiate { (result: InitiationResult, error: Error?) -> Void in
            self.disableUI(false);
        //    self.status.text = (success.success ? "Verified" : error?.localizedDescription);
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "enterPin") {
            let enterCodeVC = segue.destination as! PhoneNumberVerificationVC;
            enterCodeVC.verification = self.verification;
        }

    }
}


