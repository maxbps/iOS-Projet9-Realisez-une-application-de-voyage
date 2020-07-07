import Foundation

// this is the structure of the response of openweathermap.api
struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
}

struct Weather: Decodable {
    let main: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
}
