@testable import MyBackpack
import XCTest


class TranslateTestCase: XCTestCase {
    
    func testGetTranslationShouldFailedCallbackIfError() {
        let translateService = TranslateService(
            translateSession: URLSesionFake(data: nil, response: nil, error: FakeTranslateResponseData.error))
        let expectation = XCTestExpectation(description: "wait for queue change")
        translateService.getTranslation { (succes, translate) in
            XCTAssertFalse(succes)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldFailedCallbackIfNoData() {
        let translateService = TranslateService(
            translateSession: URLSesionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        translateService.getTranslation { (succes, translate) in
            XCTAssertFalse(succes)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldFailedCallbackIfIncorrectResponse() {
        let translateService = TranslateService(
            translateSession: URLSesionFake(data: nil, response: FakeTranslateResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        translateService.getTranslation { (succes, translate) in
            XCTAssertFalse(succes)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldFailedCallbackIfIncorrectData() {
        let translateService = TranslateService(
            translateSession: URLSesionFake(data: FakeTranslateResponseData.translateIncorrectData, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        translateService.getTranslation { (succes, translate) in
            XCTAssertFalse(succes)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldFailedCallbackIfIncorrectDataAndResponseOk() {
        let translateService = TranslateService(
            translateSession: URLSesionFake(data: FakeTranslateResponseData.translateIncorrectData, response: FakeTranslateResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        translateService.getTranslation { (succes, translate) in
            XCTAssertFalse(succes)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldSuccessCallbackIfNoErrorAndCorrectData() {
        let translateService = TranslateService(
            translateSession: URLSesionFake(data: FakeTranslateResponseData.translateCorrectData, response: FakeTranslateResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        translateService.getTranslation { (succes, translate) in
            let text = "Hi"
            XCTAssertTrue(succes)
            XCTAssertEqual(text, translate!.data.translations[0].translatedText)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }

}
