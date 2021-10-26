//
//  TaskViewController.swift
//  TakAssessiment
//
//  Created by Ali Almorshed on 11/10/21.
//

import UIKit

class TaskViewController: UIViewController {
    var userdataList = [[String:Any]]()
    var delegate : TaskCollectionViewCellDelegate?
    @IBOutlet weak var taskTableView : UITableView!{
        didSet{
            self.taskTableView.backgroundColor = .clear
        }
    }
    func relodeCollectionView(){
        self.taskTableView.reloadData()
        print(userdataList)
    }
     func getUsersData() {
        // Do any additional setup after loading the view.
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["properties"] as? [[String:Any]] {
                    // do stuff
                    let dataget =  UserDefaults.standard.object(forKey: "userData") as? [[String : Any]] ?? []
                    if dataget.count != 0 {
                        userdataList = dataget
                    }
                    else{
                        userdataList = person
                        UserDefaults.standard.set(userdataList, forKey: "userData")
                        UserDefaults.standard.synchronize()
                    }
                    print(userdataList)
                }
            } catch {
                // handle error
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskTableView.dataSource = self
        self.taskTableView.delegate = self
        self.taskTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getUsersData()
        self.taskTableView.reloadData()
    }
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        if userdataList[sender.tag]["favourite"] as? String == "0" {
            userdataList[sender.tag]["favourite"] = "1"
        }
        else{
            userdataList[sender.tag]["favourite"] = "0"
        }
        UserDefaults.standard.set(userdataList, forKey: "userData")
        UserDefaults.standard.synchronize()
        self.taskTableView.reloadRows(at: [[0,buttonTag]], with: .none)
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
        cell.selectionStyle = .none
        cell.relodeCollectionView()
        cell.delegate = self
        cell.indexPath = indexPath
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
extension TaskViewController: TaskCollectionViewCellDelegate{
    func navigateToPropertyViewController(indexPath: IndexPath){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PropertyViewController") as! PropertyViewController
        vc.userdataList = userdataList[indexPath.row]
       self.navigationController?.pushViewController(vc, animated: true)
    }
}







