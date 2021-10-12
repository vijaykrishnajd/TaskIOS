//
//  TaskViewController.swift
//  TakAssessiment
//
//  Created by Ali Almorshed on 11/10/21.
//

import UIKit

class TaskViewController: UIViewController {
    var userdataList = [[String:Any]]()
    @IBOutlet weak var taskTableView : UITableView!
    func relodeCollectionView(){
        self.taskTableView.reloadData()
        print(userdataList)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskTableView.dataSource = self
        self.taskTableView.delegate = self
        self.taskTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        // Do any additional setup after loading the view.
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["properties"] as? [[String:Any]] {
                            // do stuff
                       userdataList = person
                      print(userdataList)
                  }
              } catch {
                   // handle error
              }
        }
}
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        if userdataList[sender.tag]["favourite"] as? String == "0" {
            userdataList[sender.tag]["favourite"] = "1"
        }
        else{
            userdataList[sender.tag]["favourite"] = "0"
           
        }
        self.taskTableView.reloadData()
       print(buttonTag)
    }
    
}
extension TaskViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userdataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.userdataList = self.userdataList[indexPath.row]["images"] as?  [String] ?? []
        cell.propertyNameLabel.text = self.userdataList[indexPath.row]["name"] as? String
        cell.propertyLocationLabel.text = self.userdataList[indexPath.row]["place"] as? String
       let price = self.userdataList[indexPath.row]["price"] as? String
        let currency = self.userdataList[indexPath.row]["currency"] as? String
        cell.properyPriceLabel.text = "\(price ?? "") \(currency ?? "")"
        if userdataList[indexPath.row]["favourite"] as? String == "0" {
            cell.likedButton.setImage(UIImage(named: "notsaved.pdf"), for: .normal)
        }
        if userdataList[indexPath.row]["favourite"] as? String == "1" {
            cell.likedButton.setImage(UIImage(named: "saved.pdf"), for: .normal)
        }
        cell.likedButton.tag = indexPath.row
        cell.likedButton.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        cell.relodeCollectionView()
        return cell
    }
}
extension TaskViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PropertyViewController") as! PropertyViewController
        vc.userdataList = userdataList[indexPath.row]
       
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
      
        
    
    

