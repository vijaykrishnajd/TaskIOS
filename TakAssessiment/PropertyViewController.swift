//
//  PropertyViewController.swift
//  TakAssessiment
//
//  Created by Ali Almorshed on 11/10/21.
//

import UIKit

class PropertyViewController: UIViewController {
    var userdataList = [String:Any]()
    @IBOutlet weak var posteTableView : UITableView!{
        didSet{
            self.posteTableView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var backButton : UIButton!{
        didSet{
            backButton.setImage(UIImage(named: "leftArrow.pdf"), for: .normal)
        }
    }
    @IBOutlet weak var likedButton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.posteTableView.register(UINib(nibName: "DashBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashBoardTableViewCell")
        self.posteTableView.dataSource = self
        self.navigationController?.navigationBar.isHidden = true
        if userdataList["favourite"] as? String == "0" {
            self.likedButton.setImage(UIImage(named: "notsaved.pdf"), for: .normal)
        }
        if userdataList["favourite"] as? String == "1" {
            self.likedButton.setImage(UIImage(named:"saved.pdf"), for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonClicked(_sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func likedButtonClicked(_sender:UIButton){
        var  userdata  = UserDefaults.standard.object(forKey: "userData") as? [[String:Any]] ?? []
        if let index = userdata.firstIndex(where: {($0["id"] as? Int) == (self.userdataList["id"] as? Int)}){
            if userdataList["favourite"] as? String == "0" {
                userdata[index]["favourite"] = "1"
                likedButton.setImage(UIImage(named: "saved.pdf"), for: .normal)
            }
            if userdataList["favourite"] as? String == "1" {
                userdata[index]["favourite"] = "0"
                likedButton.setImage(UIImage(named: "notsaved.pdf"), for: .normal)
            }
            UserDefaults.standard.set(userdata, forKey: "userData")
            UserDefaults.standard.synchronize()
            self.posteTableView.reloadData()
        }
    }
}
extension PropertyViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardTableViewCell", for: indexPath) as! DashBoardTableViewCell
        cell.userdataList = self.userdataList["images"] as?  [String] ?? []
        cell.postNameLabel.text = self.userdataList["name"] as? String
        cell.postLocationLabel.text = self.userdataList["place"] as? String
        cell.aboutLabel.text = self.userdataList["about"] as? String
        let price = self.userdataList["price"] as? String
        let currency = self.userdataList["currency"] as? String
        cell.priceLabel.text = "\(price ?? "") \(currency ?? "")"
        cell.selectionStyle = .none
        cell.relodeCollectionView()
        return cell
    }
}







