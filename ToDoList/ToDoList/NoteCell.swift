//
//  NoteCell.swift
//  ToDoList
//
//  Created by Nguyễn Thịnh Tiến on 2/23/17.
//  Copyright © 2017 TienNguyen. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var content: String?
    
    var dateCreated: NSDate?
    
    var userId: String?
    var noteId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
