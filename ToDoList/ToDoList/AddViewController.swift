//
//  AddViewController.swift
//  ToDoList
//
//  Created by Nguyễn Thịnh Tiến on 2/24/17.
//  Copyright © 2017 TienNguyen. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var titleTextFeild: UITextField!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBAction func addData(_ sender: Any) {
        let VC: ViewController? = ViewController()
        if VC != nil {
            VC?.contentAddView = contentTextField.text
            VC?.titleAddView = titleTextFeild.text
            VC?.addData()
            print("Added")
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
