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
        collectionView.register(UINib(nibName: PinCell.Identifier, bundle: nil), forCellWithReuseIdentifier: PinCell.Identifier)
        dataController = PinDataController(service: service, collectionView: collectionView)
        dataController.owner = self
        dataController.delegate = self
        dataController.fetchData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    


}


extension PinViewController:PinDataControllerDelegate{
    
    func didSelectPin(_ pin: MindValleyPin, with Image: UIImage?) {
        if let fullVc = storyboard?.instantiateViewController(withIdentifier: PhotoFullScreenVC.Identifier) as? PhotoFullScreenVC{
            fullVc.pin = pin
            fullVc.placeHolderImage = Image
            present(fullVc, animated: true, completion: nil)
        }
    }
    
}
