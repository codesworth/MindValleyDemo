//
//  PinDataController.swift
//  MindValleyApp
//
//  Created by Shadrach Mensah on 03/01/2020.
//  Copyright © 2020 Shadrach Mensah. All rights reserved.
//

import UIKit
import AssetLoader

class PinDataController<ServiceObject:DataServiceProtocol>: NSObject, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    typealias MindValleyPins = [MindValleyPin]
    weak var collectionView:UICollectionView?
    weak var owner:UIViewController?
    var pins:MindValleyPins = []
    private var service:ServiceObject
    let refreshControl = UIRefreshControl()
    private var cursor = Cursor(limit: 2) {
        guard let lhs = $0 as? MindValleyPin, let rhs = $1 as? MindValleyPin else {return false}
        return lhs < rhs
    }
    
    
    init(service:ServiceObject, collectionView:UICollectionView?, cursor:Cursor? = nil) {
        self.collectionView = collectionView
        self.service = service
        if let cursor = cursor {self.cursor = cursor}
        super.init()
        setup()
    }
    
    func setup(){
        collectionView?.delegate = self
        collectionView?.dataSource = self
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
    
    @objc func fetchData(){
        service.fetchData(url: Constants.dataUrl) {[weak self] (result) in
            guard let self = self else {return}
            self.resolveResult(result: result, changeCursor: false)
            
        }
    }
    
    func resolveResult(result:Result<ServiceObject.DataType, NetworkError>, changeCursor:Bool){
        if refreshControl.isRefreshing{refreshControl.endRefreshing()}
        switch result{
        case .failure(let err):
            let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.owner?.present(alert, animated: true, completion: nil)
            break
        case .success(let pins):
            if let mindvalleyPins = pins as? MindValleyPins{
                if changeCursor{
                    self.pins.append(contentsOf: mindvalleyPins)
                    cursor.next()
                }else{
                    self.pins = mindvalleyPins
                }
                self.collectionView?.reloadData()
            }
        }
    }
    
    func fetchMoreData(){
        service.fetchData(url: Constants.dataUrl, with: cursor) {[weak self] (result) in
            guard let self = self else {return}
            self.resolveResult(result: result, changeCursor: true)
        }
    }
    
   func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinCell.Identifier, for: indexPath) as? PinCell{
            let pin = pins[indexPath.row]
            cell.configure(pin, manager: service.assetManager, for: indexPath.row )
            return cell
        }
        return PinCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        service.assetManager.cancel(for: indexPath.row)
    }
    
}
