//
//  LoginViewController.swift
//  ToDoList
//
//  Created by Nguyễn Thịnh Tiến on 2/28/17.
//  Copyright © 2017 TienNguyen. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTxf: UITextField!
    
    @IBOutlet weak var passWordTxf: UITextField!
    
    let urlString = "http://124.158.7.238:3010/api/users/login"
    
    var getUrl = "http://124.158.7.238:3010/api/notes"
    
   // let VC: ViewController = ViewController()
    
    var idUser = ""
    
     @IBAction func loginBtn(_ sender: Any) {
        let textUser = userNameTxf.text
        let textPassword = passWordTxf.text
        
        let postString = [
            "email":textUser!,
            "password":textPassword!
        ]
        
        Alamofire.request(urlString, method: .post, parameters: postString).responseJSON {
            response in
            if response.response?.statusCode == 200 {
                if let data: AnyObject = response.result.value as AnyObject? {
                    let id = data["userId"] as? String
                    self.idUser = id!
                    self.callAlamofire(url: self.getUrl)
                    self.performSegue(withIdentifier: "gotoTableView", sender: self)
                }
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Email or password not correct", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoTableView" {
            let VC: ViewController? = segue.destination as? ViewController
            if VC != nil{
                VC?.userId = idUser
            }
        }
    }
    
    // MARK: - Networking
    func callAlamofire(url: String) {
        Alamofire.request(url, method: .get).responseJSON{
            response in
            self.parseData(JSONData: response.data!)
        }
    }
    
    func parseData(JSONData: Data) {
        let VC: ViewController = ViewController()
        do{
            VC.listData = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [NSDictionary]
        }
        catch {
            print(error)
        }
        for i in 0..<VC.listData.count {
            let item = VC.listData[i]
            let title = item["title"]
            let content = item["content"]
            let createdAt = item["createdAt"]
            let id = item["id"] as! String
            let userId = item["user_id"] as! String
            
            if userId == idUser {
            let listEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "ListEntity", in: VC.appDelegate.coreDataStack.managedObjectContext)
            
            if listEntity != nil {
                let note1: ListEntity = ListEntity(entity: listEntity!, insertInto: VC.appDelegate.coreDataStack.managedObjectContext)
                note1.title = title as! String?
                note1.content = content as! String?
                note1.createdAt = VC.convertStringtoDate(str: (createdAt as! String)) as NSDate?
                note1.id = id as String?
                note1.userId = userId as String?
                VC.appDelegate.coreDataStack.saveContext()
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
