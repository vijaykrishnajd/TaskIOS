//
//  TaskTableViewCell.swift
//  TakAssessiment
//
//  Created by Ali Almorshed on 11/10/21.
//

import UIKit

protocol TaskCollectionViewCellDelegate {
    func navigateToPropertyViewController(indexPath: IndexPath)
}
class TaskTableViewCell: UITableViewCell {
    var userdataList = [String]()
    var delegate : TaskCollectionViewCellDelegate?
    
    
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
    var indexPath = IndexPath()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userCollectionView.register(UINib(nibName: "TaskCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TaskCollectionViewCell")
        self.userCollectionView.isPagingEnabled = true
        self.userCollectionView.dataSource = self
        self.userCollectionView.delegate = self
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    var reload = false
    func relodeCollectionView(){
        if !self.reload{
            self.reload = true
            self.userCollectionView.reloadData()
        }
//        self.userCollectionView.scrollToItem(at: [0,0], at: .left, animated: false)
        print(userdataList)
    }
    func navigateToPropertyViewController(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PropertyViewController") as! PropertyViewController
        vc.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension TaskTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userdataList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCollectionViewCell", for: indexPath) as! TaskCollectionViewCell
        cell.propertyImageView.loadImageFromUrl(urlString: self.userdataList[indexPath.row])
        cell.propertyImageView.contentMode = .scaleAspectFill
        return cell
    }
}
extension TaskTableViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        self.delegate?.navigateToPropertyViewController(indexPath: self.indexPath)
    }
    
}


