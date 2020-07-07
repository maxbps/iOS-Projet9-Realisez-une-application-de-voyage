import Foundation
class FakeWeatherResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http//uneadresse2")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http//uneadresse2")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    class WeatherError: Error{}
    static let error = WeatherError()
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let weatherIncorrectData = "kjhibcdkljsnv".data(using: .utf8)!
}
