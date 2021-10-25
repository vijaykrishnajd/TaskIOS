//
//  TaskTableViewCell.swift
//  TakAssessiment
//
//  Created by Ali Almorshed on 11/10/21.
//

import UIKit

protocol taskCollectiomViewCellDelegate {
    func navigateToPropertyViewController()
}
class TaskTableViewCell: UITableViewCell {
    var userdataList = [String]()
    var delegate : taskCollectiomViewCellDelegate?
    
    
    @IBOutlet weak var propertyNameLabel: UILabel!{
        didSet{
            self.propertyNameLabel.font = .boldSystemFont(ofSize: 25)
        }
    }
    @IBOutlet weak var locationImageButton: UIButton!{
        didSet{
            locationImageButton .setImage(UIImage(named: "location.pdf"), for: .normal)
            
        }
    }
    @IBOutlet weak var properyPriceLabel : UILabel!{
        didSet{
            self.properyPriceLabel.backgroundColor = .white
        }
    }
    @IBOutlet  weak var likedButton : UIButton!{
        didSet{
            likedButton.setImage(UIImage(named: "notsaved.pdf"), for: .normal)
            
        }
    }
    @IBOutlet weak var propertyLocationLabel: UILabel!{
        didSet{
            self.propertyLocationLabel.textColor = UIColor(red: 31/225, green: 23/225, blue: 112/225, alpha: 1.0)
            
        }
    }
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userCollectionView.register(UINib(nibName: "TaskCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TaskCollectionViewCell")
        self.userCollectionView.dataSource = self
        self.userCollectionView.delegate = self
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func relodeCollectionView(){
        self.userCollectionView.reloadData()
        print(userdataList)
    }
    func navigateToPropertyViewController(){
    }
    
}
extension TaskTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userdataList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCollectionViewCell", for: indexPath) as! TaskCollectionViewCell
        if   let url = URL(string: userdataList[indexPath.row]){
            cell.propertyImageView.load(url: url )
        }
        
        return cell
    }
}
extension TaskTableViewCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = systemLayoutSizeFitting(
            .init(width: self.frame.size.width, height: self.frame.height),
            withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.delegate?.navigateToPropertyViewController()

    }
    
}


