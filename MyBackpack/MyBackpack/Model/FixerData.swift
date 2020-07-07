import Foundation

// this is the structure of the response of fixer.io.api
struct CurrencyData: Decodable {
    let rates: [String: Double]
    let timestamp: Double
}
