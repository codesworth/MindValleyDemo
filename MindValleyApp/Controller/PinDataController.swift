//
//  PinDataController.swift
//  MindValleyApp
//
//  Created by Shadrach Mensah on 03/01/2020.
//  Copyright © 2020 Shadrach Mensah. All rights reserved.
//

import UIKit


class PinDataController: NSObject {
    
    typealias MindValleyPins = [MindValleyPin]
    weak var collectionView:UICollectionView?
    weak var owner:UIViewController?
    var pins:MindValleyPins = []
    private var service:DataService<MindValleyPins>
    
    private override init() {
        service = DataService()
        super.init()
    
    }
    
    init(collectionView:UICollectionView?) {
        self.collectionView = collectionView
        service = DataService()
        super.init()
        setup()
    }
    
    func setup(){
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    func fetchData(){
        service.fetchData(url: Constants.dataUrl) {[weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .failure(let err):
                break
            case .success(let pins):
                self.pins = pins
                self.collectionView?.reloadData()
            }
        }
    }
}


extension PinDataController:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinCell.Identifier, for: indexPath) as? PinCell{
            let pin = pins[indexPath.row]
            cell.configure(pin)
            return cell
        }
        return PinCell()
    }
    
}


extension PinDataController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
}
