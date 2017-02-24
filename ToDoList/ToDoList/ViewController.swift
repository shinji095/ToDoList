//
//  ViewController.swift
//  ToDoList
//
//  Created by Nguyễn Thịnh Tiến on 2/23/17.
//  Copyright © 2017 TienNguyen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var lists: [ListEntity] = []
    @IBOutlet weak var tableView: UITableView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: -64.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        //Save user data
        let firstStart: Bool? = UserDefaults.standard.object(forKey: "firstStart") as? Bool
        if firstStart == nil {
            self.createData()
            UserDefaults.standard.set(false, forKey: "firstStart")
        }
        
        self.fetchData()
        
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createData() {
        
        let listEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "ListEntity", in: self.appDelegate.coreDataStack.managedObjectContext)
        
        if listEntity != nil {
//            let note1 = NSManagedObject(entity: listEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
//            note1.setValue("Eat", forKey: "name")
//            let note2 = NSManagedObject(entity: listEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
//            note2.setValue("Play", forKey: "name")
//            let note3 = NSManagedObject(entity: listEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
//            note3.setValue("Code", forKey: "name")
//            let note4 = NSManagedObject(entity: listEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
//            note4.setValue("Sleep", forKey: "name")
            let note1: ListEntity = ListEntity(entity: listEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            note1.name = "Eat"
            note1.createdAt = NSDate()
            
            let note2: ListEntity = ListEntity(entity: listEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            note2.name = "Code"
            note2.createdAt = NSDate()
            
            let note3: ListEntity = ListEntity(entity: listEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            note3.name = "Sleep"
            note3.createdAt = NSDate()
            
            
            self.appDelegate.coreDataStack.saveContext()
            
        }
//        let note1: List = List(name: "Code")
//        let note2: List = List(name: "Eat")
//        let note3: List = List(name: "Sleep")
//
//        lists.append(note1)
//        lists.append(note2)
//        lists.append(note3)
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ListEntity")
        do {
            if let results = try self.appDelegate.coreDataStack.managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] {
                let fetchNotes: [ListEntity]? = results as? [ListEntity]
                if fetchNotes != nil {
                    self.lists = fetchNotes!
                }
            }
        }
        catch {
            fatalError("Error")
        }
    }
    
    @IBAction func addData(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Note",message: "Add a new note",preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",style: .default,handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.saveName(name: textField!.text!)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true,completion: nil)
    }
    
    func getContext()-> NSManagedObjectContext{
       return self.appDelegate.coreDataStack.managedObjectContext
    }
    
    //Save name
    func saveName(name: String) {
        let listEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "ListEntity", in: getContext())
        if listEntity != nil {
            let note1: ListEntity = ListEntity(entity: listEntity!, insertInto: getContext())
            note1.name = name
            note1.createdAt = NSDate()
            self.lists.append(note1)
            self.tableView.insertRows(at: [IndexPath(row: self.lists.count-1 ,section: 0)], with: .automatic)
            self.appDelegate.coreDataStack.saveContext()
        }
        tableView.reloadData()
    }
    
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        if editing {
//            self.tableView.setEditing(true, animated: true)
//        }
//        else {
//            self.tableView.setEditing(false, animated: true)
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            let detailVC: DetailViewController? = segue.destination as? DetailViewController
            let cell: NoteCell? = sender as? NoteCell
            
            if cell != nil && detailVC != nil{
                detailVC!.contentText = cell!.noteLabel!.text
                detailVC?.dateCreated = cell?.dateCreated
            }
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: NoteCell? = (tableView.dequeueReusableCell(withIdentifier: "defaultCell") as? NoteCell)
        
        if cell == nil {
            cell = NoteCell(style: .default, reuseIdentifier: "defaultCell")
        }
        let currentNote: ListEntity = lists[indexPath.row]
        cell?.noteLabel.text = currentNote.name
        cell?.dateCreated = currentNote.createdAt
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if self.lists.count > 0 {
                let note: ListEntity = self.lists[indexPath.row]
                self.lists.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
                self.appDelegate.coreDataStack.managedObjectContext.delete(note)
                self.appDelegate.coreDataStack.saveContext()
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
