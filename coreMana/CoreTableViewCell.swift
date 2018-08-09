//
//  CoreTableViewCell.swift
//  coreMana
//
//  Created by popCorn on 2018/08/08.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit

class CoreTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     
    
    

}
