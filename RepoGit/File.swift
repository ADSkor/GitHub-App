//
//  File.swift
//  RepoGit
//
//  Created by Aleksandr Skorotkin on 20/12/2018.
//  Copyright © 2018 Aleksandr Skorotkin. All rights reserved.
//

import UIKit

class FileViewController: UIViewController {
    
    @IBOutlet weak var nameOfRepoLabel: UILabel!
    @IBOutlet weak var starsOfRepoLabel: UILabel!
    @IBOutlet weak var languageOfRepoLabel: UILabel!
    @IBOutlet weak var descriptionOfRepoLabel: UILabel!
    @IBOutlet weak var dateOfLastUpdateLabel: UILabel!
    @IBOutlet weak var nickNameOfRepoLabel: UILabel!
    @IBOutlet weak var linkOfRepoLabel: UILabel!
    @IBOutlet weak var imageOfRepo: UIImageView!
    
    
    var nameOfRepo : String?
    var starOfRepo : String?
    var languageOfRepo : String?
    var descriptionOfRepo : String?
    var dateOfRepo : String?
    var nickNameOfRepo : String?
    var linkOfRepo : String?
    var imageOfRepoLink : String?
    
    override func viewDidLoad() {
        
        nameOfRepoLabel.text = nameOfRepo
        starsOfRepoLabel.text = starOfRepo
        languageOfRepoLabel.text = languageOfRepo
        descriptionOfRepoLabel.text = descriptionOfRepo
        dateOfLastUpdateLabel.text = dateOfRepo
        nickNameOfRepoLabel.text = nickNameOfRepo
        linkOfRepoLabel.text = linkOfRepo
        
        changeImage(imageFromArray: imageOfRepoLink!)
        
    }
    
    //UpdateImage from URL
    func changeImage(imageFromArray: String) {
        let imageURL = imageFromArray
        if let url = URL(string: imageURL) {
            do {
                let data = try Data(contentsOf: url)
                self.imageOfRepo.image = UIImage(data: data)
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
    
}
