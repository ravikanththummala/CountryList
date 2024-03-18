//
//  CountryViewModel.swift
//  CountryList
//
//  Created by Ravikanth  on 3/18/24.
//

import Combine
import SwiftUI

let countryURL = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"

class CountriesViewModel: ObservableObject {
    @Published var countries = [CountryModel]()
    @Published var searchTerm: String = ""
    var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink { [weak self] searchTerm in
                if searchTerm.isEmpty {
                    self?.countries = self?.allCountries ?? []
                } else {
                    self?.countries = self?.allCountries.filter {
                        $0.name.lowercased().contains(searchTerm.lowercased()) ||
                        $0.capital.lowercased().contains(searchTerm.lowercased())
                    } ?? []
                }
            }
            .store(in: &cancellables)
        
        fetchCountries()
    }
    
    private var allCountries = [CountryModel]() {
        didSet {
            countries = allCountries
        }
    }

    func fetchCountries() {
        guard let url = URL(string: countryURL) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [CountryModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.allCountries, on: self)
            .store(in: &cancellables)
    }
}

    
    
