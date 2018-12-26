//
//  ViewController.swift
//  RepoGit
//
//  Created by Aleksandr Skorotkin on 20/12/2018.
//  Copyright © 2018 Aleksandr Skorotkin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class TableViewController: UITableViewController {
    
    //SearchButton Action:
    @IBAction func searchBarButton(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Искать в GitHub", message: "Напишите то, что хотите найти", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Search", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            
            SVProgressHUD.show()
            
            self.resetTable()
            
            self.searchName = textField.text ?? ""
            self.getDataFromGit()
            self.navigationItem.title = self.searchName
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Search"
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Var + Const
    
    let originalURL: String = "https://api.github.com/search/repositories?q="
    var searchName: String = "Virtual"
    
    let informationModel = Information()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        tableView.dataSource = self
        tableView.delegate = self
        getDataFromGit()
        navigationItem.title = searchName
    }
    
    
    //MARK: - Networking
    func getDataFromGit() {
        
        let firstURL = originalURL + searchName + "&sort=stars"
        
        Alamofire.request(firstURL, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                
//                print("Success! We got Data!")
                let dataJSON : JSON = JSON(response.result.value!)
                self.updateTableData(json: dataJSON)
                
            } else {
                
                print("We have some problem with data: \(String(describing: response.result.error))")
                
            }
        }
    }
    
    
    //MARK: - JSON
    func updateTableData(json: JSON) {

        let tableCountArray = json["items"]
        var i = 0
        for num in 0...tableCountArray.count {
            if i < tableCountArray.count {
                
                informationModel.arrayOfNames.append(tableCountArray[num]["name"].stringValue)
                informationModel.arrayOfStars.append(String(tableCountArray[num]["stargazers_count"].intValue))
                informationModel.arrayOfLanguages.append(tableCountArray[num]["language"].stringValue)
                informationModel.arrayOfDescriptions.append(tableCountArray[num]["description"].stringValue)
                informationModel.arrayOfLastUpdates.append(tableCountArray[num]["updated_at"].stringValue)
                informationModel.arrayOfNicknames.append(tableCountArray[num]["owner"]["login"].stringValue)
                informationModel.arrayOfLinks.append(tableCountArray[num]["owner"]["html_url"].stringValue)
                informationModel.arrayOfImages.append(tableCountArray[num]["owner"]["avatar_url"].stringValue)
                
//                print("\(i+1)")

                i += 1
                
            }
        }
        
        //Reload TableView Cells
        tableView.reloadData()

    }

    //MARK: - TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOfTabbleView", for: indexPath) as! MyTableViewCell
        cell.nameOfRepo.text = informationModel.arrayOfNames[indexPath.row]
        cell.starsOfRepo.text = "Stars: " + "\(informationModel.arrayOfStars[indexPath.row])"
        SVProgressHUD.dismiss()
        return cell
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationModel.arrayOfNames.count
    }
    
    //MARK: - Cell Selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToMoreInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMoreInfo" {

            let destinationVC = segue.destination as! FileViewController

            var indexPath = self.tableView.indexPathForSelectedRow
            
            destinationVC.nameOfRepo = informationModel.arrayOfNames[(indexPath?.row)!]
            destinationVC.descriptionOfRepo = informationModel.arrayOfDescriptions[(indexPath?.row)!]
            destinationVC.languageOfRepo = informationModel.arrayOfLanguages[(indexPath?.row)!]
            destinationVC.dateOfRepo = "Last Update: " + informationModel.arrayOfLastUpdates[(indexPath?.row)!]
            destinationVC.nickNameOfRepo = "Nick: " + informationModel.arrayOfNicknames[(indexPath?.row)!]
            destinationVC.starOfRepo = "Stars: " + informationModel.arrayOfStars[(indexPath?.row)!]
            destinationVC.linkOfRepo = "Link: " + informationModel.arrayOfLinks[(indexPath?.row)!]
            destinationVC.imageOfRepoLink = informationModel.arrayOfImages[(indexPath?.row)!]

        }
    }
    
    //TableView Reset(Сброс перед поиском)
    func resetTable() {
        informationModel.arrayOfDescriptions.removeAll()
        informationModel.arrayOfStars.removeAll()
        informationModel.arrayOfNicknames.removeAll()
        informationModel.arrayOfLanguages.removeAll()
        informationModel.arrayOfLastUpdates.removeAll()
        informationModel.arrayOfNames.removeAll()
        informationModel.arrayOfLinks.removeAll()
        informationModel.arrayOfImages.removeAll()
    }
    
}

