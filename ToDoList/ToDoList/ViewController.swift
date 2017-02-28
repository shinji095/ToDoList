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
    var titleAddView: String?
    var contentAddView: String?
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContext()-> NSManagedObjectContext{
        return self.appDelegate.coreDataStack.managedObjectContext
    }
    
    func createData() {
        
        let listEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "ListEntity", in: self.appDelegate.coreDataStack.managedObjectContext)
        
        if listEntity != nil {
            let note1: ListEntity = ListEntity(entity: listEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            note1.title = "Eat"
            note1.content = "Lunch"
            note1.createdAt = NSDate()
            
            let note2: ListEntity = ListEntity(entity: listEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            note2.title = "Code"
            note2.content = "Code swift 3 ios"
            note2.createdAt = NSDate()
            
            let note3: ListEntity = ListEntity(entity: listEntity!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            note3.title = "Sleep"
            note3.content = "Sleppp..........."
            note3.createdAt = NSDate()
            
            self.appDelegate.coreDataStack.saveContext()
        }
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
    
    func addData() {
        let listEntity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "ListEntity", in: getContext())
        if listEntity != nil {
            let note1 : ListEntity = ListEntity(entity: listEntity!, insertInto: getContext())
            note1.content = contentAddView
            note1.title = titleAddView
            note1.createdAt = NSDate()
            self.lists.append(note1)
            print(lists.count)
            self.appDelegate.coreDataStack.saveContext()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            let detailVC: DetailViewController? = segue.destination as? DetailViewController
            let cell: NoteCell? = sender as? NoteCell
            if cell != nil && detailVC != nil{
                detailVC?.contentText = cell?.content
                detailVC!.titleText = cell!.noteLabel!.text
                detailVC?.dateCreated = cell?.dateCreated
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(lists.count)
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: NoteCell? = (tableView.dequeueReusableCell(withIdentifier: "defaultCell") as? NoteCell)
        
        if cell == nil {
            cell = NoteCell(style: .default, reuseIdentifier: "defaultCell")
        }
        let currentNote: ListEntity = lists[indexPath.row]
        cell?.content = currentNote.content
        cell?.noteLabel.text = currentNote.title
        cell?.dateCreated = currentNote.createdAt
        cell?.dateLabel.text = revertDatetoString(date: currentNote.createdAt!)
        return cell!
    }
    
    func revertDatetoString(date: NSDate) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDate = dateFormatter.string(from: date as Date)
        return stringDate
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
