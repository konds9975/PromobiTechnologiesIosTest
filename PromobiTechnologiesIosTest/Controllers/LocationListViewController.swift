//
//  LocationListViewController.swift
//  PromobiTechnologiesIosTest
//
//  Created by Kondya on 02/07/19.
//  Copyright © 2019 Fortune4. All rights reserved.
//

import UIKit

class LocationListViewController: UIViewController {

    
    @IBOutlet weak var locationListTable: UITableView!
    var locationListArray : [LocationInfo] = []
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Confirm Protocol
        self.locationListTable.delegate = self
        self.locationListTable.dataSource = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.setData),
            name: locationUpdateNotificationIdentifier,
            object: nil)
        self.setData()
        
        
    }
    @objc func setData() {
        
        DBManager.shared.getAllLocationFromDataBase { (locationArray) in
            self.locationListArray = locationArray
            self.locationListTable.reloadData()
            if self.locationListArray.count != 0 {
                self.locationListTable.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .left)
                self.navigationItem.title = "Location List (\(self.locationListArray.count))"
            }else{
                self.navigationItem.title = "Location List"
            }
            
        }
    }
    
    @IBAction func clearBtnAction(_ sender: Any) {
        if self.locationListArray.count != 0 {
            let optionMenu = UIAlertController(title: nil, message: deleteconfirmationMessage, preferredStyle: UIAlertController.Style.alert)
            
            let action = UIAlertAction(title: "Clear", style: .destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                DBManager.shared.deleteAllLocationFromDataBase()
                self.setData()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                
            })
            
            optionMenu.addAction(cancelAction)
            optionMenu.addAction(action)
            self.present(optionMenu, animated: true, completion: nil)
        }
        
    }
}

//Location List TableView Delegate DataSource
extension LocationListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationListArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.locationListTable.dequeueReusableCell(withIdentifier: "LocationListTableViewCell") as? LocationListTableViewCell {
            
            cell.setModel(model: self.locationListArray[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DisplayLocationViewController") as? DisplayLocationViewController{
            vc.locationInfo = self.locationListArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
