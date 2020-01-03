//
//  PinCell.swift
//  MindValleyApp
//
//  Created by Shadrach Mensah on 03/01/2020.
//  Copyright © 2020 Shadrach Mensah. All rights reserved.
//

import UIKit
import AssetLoader

class PinCell: UICollectionViewCell,Identity {
    
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ pin:MindValleyPin,manager:AssetManager,for index:Int){
        titleLable.text = pin.user.username
        guard let url = pin.urls.smallUrl else {return}
        manager.downloadImage(for:url, identifier: index) { [weak self] image, _ in
            guard let self = self else {return}
            self.imageView.image = image
        }
    }

}
