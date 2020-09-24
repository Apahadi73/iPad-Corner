//
//  Order.swift
//  iPadCorner
//
//  Created by Amir Pahadi on 9/23/20.
//

import Foundation

class Order: ObservableObject,Codable {
    
    enum CodingKeys:CodingKey {
        case type,quantity,finish,storage,connectivity,name,streetAddress,city,zip
    }
//    ipad information and configuration
    static let types = ["iPad","iPad Mini","iPad Air","iPad Pro 11\"","iPad Pro 12.9\""]
    static let finishColor = ["Space Gray","Silver"]
    static let storages=["64GB","128GB","256GB","512GB"]
    static let connectivityTypes=["Wi-Fi","Wi-Fi+Cellular"]
    @Published var configureRequestEnabled = false {
        didSet{
            if configureRequestEnabled == false{
                  finish=0
                  storage=0
                  connectivity=0
            }
            
        }
    }
    var iPadImage:String{
        let iPadTypes = ["iPad","iPad Mini","iPad Air","iPad Pro 11\"","iPad Pro 12.9\""]
        return iPadTypes[type]
    }
    
//    order details
    @Published var type = 0
    @Published var quantity = 1
    @Published var finish=0
    @Published var storage=0
    @Published var connectivity=0


    
//    address information
    @Published var name=""
    @Published var streetAddress=""
    @Published var city=""
    @Published var zip=""
    
    var hasValidAddress:Bool{
        if name.trimmingCharacters(in: .whitespaces).isEmpty||streetAddress.trimmingCharacters(in: .whitespaces).isEmpty||city.trimmingCharacters(in: .whitespaces).isEmpty||zip.trimmingCharacters(in: .whitespaces).isEmpty{
            return false
        }
        
        return true
    }
    
    var total:Int{
        var cost = Int(type)*150+300
        cost=Int(quantity)*cost
        cost+=Int(storage)*100
        cost+=Int(connectivity)*100
        return cost 
    }
//  encode the order
     func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(finish, forKey: .finish)
        try container.encode(storage, forKey: .storage)
        try container.encode(connectivity, forKey: .connectivity)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
//    decode the container
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type=try container.decode(Int.self, forKey: .type)
        quantity=try container.decode(Int.self, forKey: .quantity)
        finish=try container.decode(Int.self, forKey: .finish)
        storage=try container.decode(Int.self, forKey: .storage)
        connectivity=try container.decode(Int.self, forKey: .connectivity)
        
        name=try container.decode(String.self, forKey: .name)
        streetAddress=try container.decode(String.self, forKey: .streetAddress)
        city=try container.decode(String.self, forKey: .city)
        zip=try container.decode(String.self, forKey: .zip)
        
    }
    
    init(){}
    
    
}
