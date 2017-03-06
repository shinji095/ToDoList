//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Nguyễn Thịnh Tiến on 2/23/17.
//  Copyright © 2017 TienNguyen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contentText: String?
    var titleText: String?
    var dateCreated: NSDate?
    
    @IBOutlet weak var contentTextFeild: UITextField!
    
    @IBOutlet weak var createdAtText: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if contentText != nil && dateCreated != nil && titleText != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let stringDate = dateFormatter.string(from: dateCreated as! Date)
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

}
