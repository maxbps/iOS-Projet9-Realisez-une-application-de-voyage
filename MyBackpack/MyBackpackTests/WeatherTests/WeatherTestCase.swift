
@testable import MyBackpack
import XCTest


class WeatherTestCase: XCTestCase {
    
    func testGetWeatherShouldFailedCallbackIfError() {
        let weatherService = WeatherService(
            weatherSession: URLSesionFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
        let expectation = XCTestExpectation(description: "wait for queue change")
        weatherService.getWeather { (succes, weather) in
            XCTAssertFalse(succes)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    
    
    func testGetWeatherShouldFailedCallbackIfNoData() {
        let weatherService = WeatherService(
            weatherSession: URLSesionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        weatherService.getWeather { (succes, weather) in
            XCTAssertFalse(succes)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    
    func testGetWeatherShouldFailedCallbackIfIncorrectResponse() {
        let weatherService = WeatherService(
            weatherSession: URLSesionFake(data: nil, response: FakeWeatherResponseData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        weatherService.getWeather { (succes, weather) in
            XCTAssertFalse(succes)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldFailedCallbackIfIncorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSesionFake(data: FakeWeatherResponseData.weatherIncorrectData, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        weatherService.getWeather { (succes, weather) in
            XCTAssertFalse(succes)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldFailedCallbackIfIncorrectDataAndResponseOk() {
        let weatherService = WeatherService(
            weatherSession: URLSesionFake(data: FakeWeatherResponseData.weatherIncorrectData, response: FakeWeatherResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        weatherService.getWeather { (succes, weather) in
            XCTAssertFalse(succes)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldSuccessCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(
            weatherSession: URLSesionFake(data: FakeWeatherResponseData.weatherCorrectData, response: FakeWeatherResponseData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait for queue change")
        weatherService.getWeather { (succes, weather) in
            let text = "Rain"
            XCTAssertTrue(succes)
            XCTAssertEqual(text, weather!.weather[0].main)
            expectation.fulfill()
        }
        wait( for: [expectation], timeout: 0.01)
    }
}

