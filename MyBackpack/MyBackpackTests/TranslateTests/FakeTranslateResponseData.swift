

import Foundation
class FakeTranslateResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http//uneadresse")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http//uneadresse")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    class TranslateError: Error{}
    static let error = TranslateError()
    
    static var translateCorrectData: Data {
        let bundle = Bundle(for: FakeTranslateResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let translateIncorrectData = "kjhibcdkljsnv".data(using: .utf8)!
}
