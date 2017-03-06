//
//  AddViewController.swift
//  ToDoList
//
//  Created by Nguyễn Thịnh Tiến on 2/24/17.
//  Copyright © 2017 TienNguyen. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class AddViewController: UIViewController {

    @IBOutlet weak var titleTextFeild: UITextField!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    let VC: ViewController? = ViewController()
    
    var postUrl = "http://124.158.7.238:3010/api/notes"
    
    @IBAction func addData(_ sender: Any) {
            if VC != nil {
            addData()
            print("Added")
        }
    }
    
    func addData() {
        let listEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "ListEntity", in: (VC?.getContext())!)
        if listEntity != nil {
            let note1 : ListEntity = ListEntity(entity: listEntity!, insertInto: VC!.getContext())
            note1.content = contentTextField.text
            note1.title = titleTextFeild.text
            note1.createdAt = NSDate()
            VC?.lists.append(note1)
            VC?.appDelegate.coreDataStack.saveContext()
        }
        postNote(url: postUrl)
    }
    
    func postNote(url: String) {
            let title = titleTextFeild.text
            let content = contentTextField.text
        
        let paramsNote = [
            "title":title!,
            "content":content!,
            "user_id": VC?.userId,
            "createdAt": VC?.revertDatetoString(date: NSDate())
        ]
        print(paramsNote)
        Alamofire.request(postUrl, method: .post, parameters: paramsNote).responseJSON {
            response in
            print(response.description)
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
