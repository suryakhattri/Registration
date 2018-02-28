//
//  PhoneNumberVerificationVC.swift
//  PhoneNumberVerification
//
//  Created by Surya on 2/27/18.
//  Copyright © 2018 Surya. All rights reserved.
//

import UIKit
import SinchVerification

class PhoneNumberVerificationVC: UIViewController {
    
 var verification:Verification!;
    
    //MARK: -Outlet Connection
    
    @IBOutlet var lblOTP: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var lblPhoneNumber: UILabel!
    @IBOutlet var lblnotFindingCode: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet var enterPinNumberTextField: UITextField!
    @IBOutlet var verifyActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblMessage.text = "Please wait while we verify you number"
//        lblPhoneNumber.text = "+6016123456"
        lblnotFindingCode.text = "Didn't got the code?"
        
       // MARK: - Creating Circle
        
       
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: - Action
   
    
    @IBAction func resendButtonAction(_ sender: UIButton) {
        
    }
    
    
    @IBAction func verifyActionButton(_ sender: UIButton) {
        
        spinner.startAnimating();
        verifyActionButton.isEnabled = false;
        lblPhoneNumber.text  = "";
        enterPinNumberTextField.isEnabled = false;
        verification.verify(enterPinNumberTextField.text!, completion: { (success:Bool, error:Error?) -> Void in
            
            
            self.spinner.stopAnimating();
            self.verifyActionButton.isEnabled = true;
            self.enterPinNumberTextField.isEnabled = true;
            if (success) {
                self.lblPhoneNumber.text = "Verified";
            } else {
                self.lblPhoneNumber.text = error?.localizedDescription;
            }
        });
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
