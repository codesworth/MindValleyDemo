//
//  ViewController.swift
//  MindValleyApp
//
//  Created by Shadrach Mensah on 02/01/2020.
//  Copyright © 2020 Shadrach Mensah. All rights reserved.
//

import UIKit
import AssetLoader


class PinViewController: UIViewController {
    
    @IBOutlet weak var collectionView:UICollectionView!
    private var dataController:PinDataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController = PinDataController(collectionView: collectionView)
        dataController.owner = self
        dataController.fetchData()
    }


}

