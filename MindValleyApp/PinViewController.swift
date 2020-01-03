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
    private var dataController:PinDataController<DataService<MindValleyPins>>!
    private var service:DataService<MindValleyPins>!
    override func viewDidLoad() {
        super.viewDidLoad()
        service = DataService()
        dataController = PinDataController(service: service, collectionView: collectionView)
        dataController.owner = self
        dataController.fetchData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    


}

