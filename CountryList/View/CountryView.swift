//
//  ContentView.swift
//  CountryList
//
//  Created by Ravikanth  on 3/18/24.
//

import SwiftUI

struct CountryView: View {
    @ObservedObject var viewModel = CountriesViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.countries) { country in
                CountryListView(country: country)
            }
        }
        .navigationTitle("Countries")
        .searchable(text: $viewModel.searchTerm)
        
    }
}


#Preview {
    NavigationView {
        CountryView()
    }
}
