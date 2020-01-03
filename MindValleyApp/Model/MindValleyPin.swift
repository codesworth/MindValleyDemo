//
//  MindValleyPin.swift
//  MindValleyApp
//
//  Created by Shadrach Mensah on 02/01/2020.
//  Copyright © 2020 Shadrach Mensah. All rights reserved.
//

import Foundation

typealias MindValleyPins = [MindValleyPin]
struct MindValleyPin:Codable {
    
    
    
    let id:String
    let created_at:String
    let width:Int
    let height:Int
    let color:String
    let likes:Int
    let liked_by_user:Bool
    let user:User
    let urls:PinURLS
    
    let categories: [PinCategory]
    
    var dateCreated:Date{
        return Date()
    }
    
    
}


extension MindValleyPin{
    struct PinURLS:Codable {
        
        let raw:String
        let full:String
        let regular:String
        let small:String
        let thumb:String
        
        var rawURL:URL?{
           return URL(string: raw)
        }
        
        var smallUrl:URL?{
            return URL(string: small)
        }
        
        var regularUrl:URL?{
            return URL(string: regular)
        }
        
        
    }


    struct PinCategory:Codable {
        let id:String
        let title:String
        let photo_count:Int
        
    }
}



extension MindValleyPin:Comparable{
    
    static func < (lhs: MindValleyPin, rhs: MindValleyPin) -> Bool {
        return lhs.dateCreated < rhs.dateCreated
    }
    
    static func == (lhs: MindValleyPin, rhs: MindValleyPin) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
}
