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
    @IBOutlet weak var likedButton : UIButton!{
        didSet{
            if userdataList["favourite"] as? String  == "0" {
                likedButton.setImage(UIImage(named: "notsaved.pdf"), for: .normal)
            }
            if userdataList["favourite"] as? String  == "1" {
                likedButton.setImage(UIImage(named: "saved.pdf"), for: .normal)
            }
            likedButton.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        }
    }
    @objc func connected(sender: UIButton){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.posteTableView.register(UINib(nibName: "DashBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashBoardTableViewCell")
        self.posteTableView.dataSource = self
        self.navigationController?.navigationBar.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonClicked(_sender:UIButton){
        self.navigationController?.popViewController(animated: true)
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







