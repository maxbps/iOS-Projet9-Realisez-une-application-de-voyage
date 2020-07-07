//
//  FixerTestCase.swift
//  MyBackpackTests
//
//  Created by Maxime Bontemps on 24/06/2019.
//  Copyright © 2019 Maxime Bontemps. All rights reserved.
//


@testable import MyBackpack
import XCTest


class FixerTestCase: XCTestCase {
    
    func testGetFixerShouldFailedCallbackIfError() {
        let fixerService = FixerService(
            fixerSession: URLSesionFake(data: nil, response: nil, error: FakeFixerResponseData.error))
        let expectation = XCTestExpectation(description: "wait for queue change")
        fixerService.getFixer { (succes, fixer) in
            XCTAssertFalse(succes)
            XCTAssertNil(fixer)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }



    func testGetFixerShouldFailedCallbackIfNoData() {
        let fixerService = FixerService(
            fixerSession: URLSesionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        fixerService.getFixer { (succes, fixer) in
            XCTAssertFalse(succes)
            XCTAssertNil(fixer)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    
    func testGetFixerShouldFailedCallbackIfIncorrectResponse() {
        let fixerService = FixerService(
            fixerSession: URLSesionFake(data: nil, response: FakeFixerResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        fixerService.getFixer{ (succes, fixer) in
            XCTAssertFalse(succes)
            XCTAssertNil(fixer)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetFixerShouldFailedCallbackIfIncorrectData() {
        let fixerService = FixerService(
            fixerSession: URLSesionFake(data: FakeFixerResponseData.fixerIncorrectData, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        fixerService.getFixer { (succes, fixer) in
            XCTAssertFalse(succes)
            XCTAssertNil(fixer)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetFixerShouldFailedCallbackIfIncorrectDataAndResponseOK() {
        let fixerService = FixerService(
            fixerSession: URLSesionFake(data: FakeFixerResponseData.fixerIncorrectData, response: FakeFixerResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        fixerService.getFixer { (succes, fixer) in
            XCTAssertFalse(succes)
            XCTAssertNil(fixer)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetFixerShouldSuccessCallbackIfNoErrorAndCorrectData() {
        let fixerService = FixerService(
            fixerSession: URLSesionFake(data: FakeFixerResponseData.fixerCorrectData, response: FakeFixerResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        fixerService.getFixer { (succes, fixer) in
            let text: Double = 1535091851
            XCTAssertTrue(succes)
            XCTAssertEqual(text, fixer!.timestamp)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
   } 
}

