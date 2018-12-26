//
//  MyTableViewCell.swift
//  RepoGit
//
//  Created by Aleksandr Skorotkin on 20/12/2018.
//  Copyright © 2018 Aleksandr Skorotkin. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var nameOfRepo: UILabel!
    @IBOutlet weak var starsOfRepo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
