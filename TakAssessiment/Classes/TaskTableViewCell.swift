//
//  TaskTableViewCell.swift
//  TakAssessiment
//
//  Created by Ali Almorshed on 11/10/21.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    var userdataList = [String]()
    @IBOutlet weak var propertyNameLabel: UILabel!
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
    @IBOutlet weak var propertyLocationLabel: UILabel!
   
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
}

