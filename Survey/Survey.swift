//
//  Survey.swift
//  Survey
//
//  Created by Collin Cannavo on 6/15/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation


struct Survey {

    init(name: String, response: String, identifier: String = UUID().uuidString) {
        self.name = name
        self.response = response
        self.identifier = identifier
        
    }
    
    
    // MARK: Properties
    
    let name: String
    let response: String
    let identifier: String
    
    
}

// MARK: - JSON Conversion

extension Survey {
    
    private static var nameKey: String { return "name"}
    private static var responseKey: String { return "response" }
    
    init?(dictionary: [String: Any], identifier: String) {
        
        guard let name = dictionary[Survey.nameKey] as? String,
            let response = dictionary[Survey.responseKey] as? String else
        { return nil }
        
        self.init(name:name, response: response, identifier: identifier)
    }
    
    
// var dictionaryRepresentation
    
    var jsonValue: [String: Any] {
        
        return [Survey.nameKey: name, Survey.responseKey: response]
    }
    
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: jsonValue, options: .prettyPrinted)
        
    }
    
}















