//
//  PhotoFullScreenVC.swift
//  MindValleyApp
//
//  Created by Shadrach Mensah on 04/01/2020.
//  Copyright © 2020 Shadrach Mensah. All rights reserved.
//

import UIKit


class PhotoFullScreenVC:UIViewController{
    
    
    @IBOutlet weak var blurview: UIVisualEffectView!
    @IBOutlet weak var blurImageView: UIImageView!
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var fullScreenImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var pin:MindValleyPin?
    var placeHolderImage:UIImage?
    var canHideContainer = true
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        blurview.effect = blurEffect
    }
    
    @objc func tapped(_ recognizer:UITapGestureRecognizer){
        if canHideContainer{
            canHideContainer = false
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {[unowned self] in
                self.containerView.alpha = 0
            })
            
        }else{
            canHideContainer = true
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {[unowned self] in
                self.containerView.alpha = 1
            })
        }
    }
    
    func updateView(){
        guard let pin = pin else {return}
        blurImageView.image = placeHolderImage
        usernameLable.text = pin.user.username
        fullNameLabel.text = pin.user.name.capitalized
        likesLabel.text = "\(pin.likes)"
        categoryLabel.text = pin.categories.first?.title
        if let profileUrl = pin.user.profileThumbNailUrl{
            userProfileImageView.setImage(for: profileUrl)
        }
        if let fullUrl = pin.urls.fullUrl{
            fullScreenImageView.setImage(for: fullUrl, placeHolder: placeHolderImage)
        }
        
        
        
    }
    
}


extension PhotoFullScreenVC:Identity{}
