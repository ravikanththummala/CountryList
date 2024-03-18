//
//  CountryModel.swift
//  CountryList
//
//  Created by Ravikanth  on 3/18/24.
//

import Foundation



struct CountryModel: Codable, Identifiable {
    let id = UUID()
    var capital: String
    var code: String
    var name: String
    var region: String
    
    enum CodingKeys: String, CodingKey {
        case capital
        case code
        case name
        case region
    }
}

