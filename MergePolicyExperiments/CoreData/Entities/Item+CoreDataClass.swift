//
//  Item+CoreDataClass.swift
//  MergePolicyExperiments
//
//  Created by Andrey Chuprina on 1/24/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case info
    }
    
    
    public required convenience init(from decoder: Decoder) throws {
        let context = decoder.userInfo[CodingUserInfoKey.context!] as! NSManagedObjectContext
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
//        let description = Item.entity()
//        self.init(entity: description, insertInto: context)
        self.init(context: context)
        
        if let intID = try container.decodeIfPresent(Int32.self, forKey: .id) {
            self.id = "\(intID)"
        }
        
        if let name = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        }
        
        if let info = try container.decodeIfPresent(String.self, forKey: .info) {
            self.info = info
        }
        
    }
    
}

extension CodingUserInfoKey {
    
    static let context = CodingUserInfoKey(rawValue: "context")
    
}
