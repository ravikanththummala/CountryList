//
//  CountryListTests.swift
//  CountryListTests
//
//  Created by Ravikanth  on 3/18/24.
//

import XCTest
@testable import CountryList

final class CountryListTests: XCTestCase {
    
    var viewModel: CountriesViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CountriesViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSearchTermFiltering() {
        let expectation = XCTestExpectation(description: "Fetch and filter countries")
        
        viewModel.$countries
            .dropFirst() // Drop the initial empty array
            .sink { countries in
                if !countries.isEmpty {
                    XCTAssertNotEqual(countries.count, 1)
                    XCTAssertEqual(countries.first?.name, "Afghanistan")
                    expectation.fulfill()
                }
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.fetchCountries()
        viewModel.searchTerm = "Afghanistan"
        
        wait(for: [expectation], timeout: 5.0)
    }
    
}
