//
//  ImageModel.swift
//  TakAssessiment
//
//  Created by Ali Almorshed on 11/10/21.
//

import Foundation
import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
    func loadImageFromUrl(urlString: String)  {
        self.image = nil
        if let url = URL(string: urlString){
            if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
                self.image = imageFromCache
                print("Images Load From Catch")
                return
            } else {
                print("if is not working Images Loading from else")
                DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url){
                        if let imageToCache = UIImage(data: data){
                            imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                            DispatchQueue.main.async {
                            self?.image = imageToCache
                            }
                        }
    //                    if let image = UIImage(data: data) {
    //                        DispatchQueue.main.async {
    //                            self?.image = image
    //                        }
    //                    }
                    }
                }
              
            }
        }
    }
    
}


