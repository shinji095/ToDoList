//
//  ViewController.swift
//  ToDoList
//
//  Created by Nguyễn Thịnh Tiến on 2/23/17.
//  Copyright © 2017 TienNguyen. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class ViewController: UIViewController {
    var lists: [ListEntity] = []
    var listData: [NSDictionary] = [NSDictionary]()
    
    var userId = ""
    
    @IBOutlet weak var tableView: UITableView!
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        self.fetchData()
        self.tableView.contentInset = UIEdgeInsets(top: -64.0, left: 0.0, bottom: 0.0, right: 0.0)
         self.tableView.reloadData()
        print(userId)
        
//        Save user data
//        let firstStart: Bool? = UserDefaults.standard.object(forKey: "firstStart") as? Bool
//        if firstStart == nil {
//            self.createData()
//            UserDefaults.standard.set(false, forKey: "firstStart")
//        }
        
    }
    
    //Sign Out
    @IBAction func signOut(_ sender: Any) {
        self.performSegue(withIdentifier: "signOut", sender: self)
        if self.lists.count > 0{
            for i in 0..<lists.count {
                let note: ListEntity = self.lists[i]
                self.lists.remove(at: i)
                self.tableView.deleteRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
                self.appDelegate.coreDataStack.managedObjectContext.delete(note)
                self.appDelegate.coreDataStack.saveContext()
            }
        }
    }
    
     // MARK: - Manage CoreData
    
    func getContext()-> NSManagedObjectContext{
        return self.appDelegate.coreDataStack.managedObjectContext
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


// MARK: - Extension ViewController
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
    
    func revertStringtoDate(str: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return (dateFormatter.date(from: str))!

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



