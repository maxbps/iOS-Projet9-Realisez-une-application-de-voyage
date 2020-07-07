import Foundation
class FakeFixerResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http//uneadresse2")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http//uneadresse2")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    class FixerError: Error{}
    static let error = FixerError()
    
    static var fixerCorrectData: Data {
        let bundle = Bundle(for: FakeTranslateResponseData.self)
        let url = bundle.url(forResource: "Fixer", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let fixerIncorrectData = "kjhibcdkljsnv".data(using: .utf8)!
}
