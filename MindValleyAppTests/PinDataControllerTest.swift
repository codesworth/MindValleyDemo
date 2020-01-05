//
//  PinDataControllerTest.swift
//  MindValleyAppTests
//
//  Created by Shadrach Mensah on 03/01/2020.
//  Copyright © 2020 Shadrach Mensah. All rights reserved.
//

import XCTest
@testable import MindValleyApp

class PinDataControllerTest: XCTestCase {

    var sut:PinDataController<MockServiceObject>!
    var collectionView:UICollectionView!
    override func setUp() {
        let service = MockServiceObject()
        collectionView = UICollectionView()
        sut = PinDataController(service: service, collectionView: collectionView)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_collectionViewLoadsZeroItemsWhenNoDataIsGiven(){
        let numberofItems = sut.numberOfSections(in: collectionView)
        XCTAssertEqual(numberofItems, 10)
    }
    
    func test_DummyDataCorrespondsToDataInPins(){
        sut.fetchData()
        XCTAssertEqual(sut.pins[0].id, "0")
    }
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}




