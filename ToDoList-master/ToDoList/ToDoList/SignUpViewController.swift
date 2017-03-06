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
        
//        let userString = userTxf.text
//        let passString = passTxf.text
//        
//        let params: [String : AnyObject] = [
//            "email" : userString! as AnyObject,
//            "password" : passString! as AnyObject
//        ]
        
//        func callAlamofire(url: String) {
//            Alamofire.request(url).responseJSON(completionHandler: {
//                response in
//                self.parseData(JSONData: response.data!)
//            })
//        }
//        
//        func parseData(JSONData: Data) {
//            do{
//                let listData = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [NSDictionary]
//            }
//            catch {
//                print(error)
//            }
//        }
       
        
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
