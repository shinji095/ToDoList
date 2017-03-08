//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Nguyễn Thịnh Tiến on 2/23/17.
//  Copyright © 2017 TienNguyen. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class DetailViewController: UIViewController {
    
    var contentText: String?
    var titleText: String?
    var dateCreated: NSDate?
    var userId: String?
    var noteId: String?
    
    @IBOutlet weak var contentTextFeild: UITextField!
    
    @IBOutlet weak var createdAtText: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    
    var putUrl = "http://124.158.7.238:3010/api/notes"
    
    @IBAction func editData(_ sender: Any) {
        
        let VC: ViewController = ViewController()
        VC.tableView.reloadData()
        let putString = [
            "title": titleText!,
            "content": contentText!,
            "id": noteId!,
            "user_id": userId!,
            "createdAt":(convertDatetoString(date: dateCreated!))
        ]
        
        Alamofire.request(putUrl, method: .put, parameters: putString).responseJSON {
            response in
            print(response.response!.statusCode)
        }
        
    }
    @IBAction func focusText(_ sender: Any) {
        editBtn.isEnabled = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        editBtn.isEnabled = false
        if contentText != nil && dateCreated != nil && titleText != nil {
            let stringDate = convertDatetoString(date: dateCreated!)
            self.titleLabel.text = titleText
            self.contentTextFeild.text = contentText
            self.createdAtText.text = "Created At: \(stringDate)"
        }
        else {
            self.createdAtText.text = "None"
        }
        
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
    
    // MARK: - Convert Date and String
    
    func convertDatetoString(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDate = dateFormatter.string(from: date as Date)
        return stringDate
    }

}
