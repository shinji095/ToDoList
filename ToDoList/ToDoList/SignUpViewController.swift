//
//  SignUpViewController.swift
//  ToDoList
//
//  Created by Nguyễn Thịnh Tiến on 2/28/17.
//  Copyright © 2017 TienNguyen. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    @IBOutlet weak var userTxf: UITextField!

    @IBOutlet weak var passTxf: UITextField!
    
    let urlSignUp: String = "http://124.158.7.238:3010/api/users"
    
    @IBAction func signUpAccount(_ sender: Any) {
        
        let userString = userTxf.text
        let passString = passTxf.text
        
        let paramUser: [String : AnyObject] = [
            "email" : userString! as AnyObject,
            "password" : passString! as AnyObject
        ]
        
        Alamofire.request(urlSignUp, method: .post, parameters: paramUser).responseJSON {
            response in
            if response.response?.statusCode == 200 {
                let alert = UIAlertController(title: "Alert", message: "Sign up successful", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(title: "Alert", message: "Error", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
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

}
