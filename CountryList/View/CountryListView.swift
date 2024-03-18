//
//  CountryListView.swift
//  CountryList
//
//  Created by Ravikanth  on 3/18/24.
//

import SwiftUI

struct CountryListView: View {
    
    var country: CountryModel
    
    var body: some View {
        VStack {
            HStack {
                Text("\(country.name), \(country.region)")
                Spacer()
                Text(country.code)
            }
            HStack {
                Text(country.capital)
                Spacer()
            }
        }
        .padding()
    }
    
}

#Preview {
    CountryListView(country: sampleCountryModel)
}


let sampleCountryModel = CountryModel(capital: "Kabul", code: "AF", name: "Afghanistan", region: "AS")
