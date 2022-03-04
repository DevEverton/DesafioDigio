//
//  DesafioDigioTests.swift
//  DesafioDigioTests
//
//  Created by Everton Carneiro on 03/03/22.
//

import XCTest
@testable import DesafioDigio


class DesafioDigioTests: XCTestCase {
    let timeout: TimeInterval = 5
    var viewModel: ProductsListViewModel!
    var mockProductsService: MockProductsService!
    var expectation: XCTestExpectation!

    
    override func setUp() {
        mockProductsService = MockProductsService()
        viewModel = ProductsListViewModel(service: mockProductsService)
        expectation = self.expectation(description: "Server response and fetch products")
    }

    override func tearDown() {
        viewModel = nil
        mockProductsService = nil
    }
    
    func test_403() {
        let url = ApiURL.urlBuilder(endPoint: .mock404)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }
            
            XCTAssertNil(error)
            do {
                let response = try XCTUnwrap(response as? HTTPURLResponse)
                XCTAssertEqual(response.statusCode, 403)
                
                let data = try XCTUnwrap(data)
                XCTAssertThrowsError(
                    try JSONDecoder().decode(AllProducts.self, from: data)
                ) { error in
                    guard case DecodingError.dataCorrupted = error else {
                        return
                    }
                    XCTFail("\(error)")

                }
            } catch { }
        }
        .resume()
        
        waitForExpectations(timeout: timeout)
    }
    
    
    
    func test_viewmodel_load_products() throws {
        var loaded = false
        
        viewModel.loadProducts { _ in
            loaded = true
            self.expectation.fulfill()
        }
        
        XCTAssert(mockProductsService.fetchProductsCalled)
        waitForExpectations(timeout: timeout)
        XCTAssertTrue(loaded)
    }
}
