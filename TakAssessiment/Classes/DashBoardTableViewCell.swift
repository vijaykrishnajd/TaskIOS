//
//  DashBoardTableViewCell.swift
//  TakAssessiment
//
//  Created by Ali Almorshed on 11/10/21.
//

import UIKit

class DashBoardTableViewCell: UITableViewCell {
    var userdataList = [String]()

    @IBOutlet weak var proertyCollectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!{
        didSet{
            self.priceLabel.backgroundColor = .white
        }
    }
    @IBOutlet weak var locationImageButton: UIButton!{
        didSet{
            locationImageButton .setImage(UIImage(named: "location.pdf"), for: .normal)

        }
    }
    @IBOutlet weak var postLocationLabel: UILabel!
   
    @IBOutlet weak var aboutLabel : UILabel!
    @IBOutlet weak var postNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.proertyCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.proertyCollectionView.dataSource = self
        self.proertyCollectionView.delegate = self
        // Initialization code
    }
    func relodeCollectionView(){
        self.proertyCollectionView.reloadData()
        print(userdataList)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension DashBoardTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userdataList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
      
        if   let url = URL(string: userdataList[indexPath.row]){
        cell.propertyImageView.load(url: url )
        }
       return cell
}
}
extension DashBoardTableViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = systemLayoutSizeFitting(
            .init(width: self.frame.size.width, height: self.frame.height),
               withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)

           return size
    }
}


