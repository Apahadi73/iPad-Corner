//
//  Order.swift
//  iPadCorner
//
//  Created by Amir Pahadi on 9/23/20.
//

import Foundation

class iPad: ObservableObject,Codable {
    
    struct iPad {
         let types = ["iPad","iPad Mini","iPad Air","iPad Pro 11\"","iPad Pro 12.9\""]
         let finishColor = ["Space Gray","Silver"]
         let storages=["64GB","128GB","256GB","512GB"]
         let connectivityTypes=["Wi-Fi","Wi-Fi+Cellular"]
         var configureRequestEnabled = false {
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
        var type = 0
         var quantity = 1
         var finish=0
       var storage=0
         var connectivity=0


        
    //    address information
       var name=""
         var streetAddress=""
         var city=""
        var zip=""
        
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
    }
    @Published var ipad = iPad()
    enum CodingKeys:CodingKey {
        case ipad
    }


//  encode the order
     func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(iPad, forKey: .ipad)
        
    }
    
//    decode the container
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        iPad = try container.decode(iPad.self, forKey: .ipad)
        
    }
    
    init(){}
    
    
}
