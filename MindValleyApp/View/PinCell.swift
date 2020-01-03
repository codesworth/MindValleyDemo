//
//  PinCell.swift
//  MindValleyApp
//
//  Created by Shadrach Mensah on 03/01/2020.
//  Copyright © 2020 Shadrach Mensah. All rights reserved.
//

import UIKit

class PinCell: UICollectionViewCell,Identity {
    
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ pin:MindValleyPin){
        titleLable.text = pin.user.username
        
    }

}
