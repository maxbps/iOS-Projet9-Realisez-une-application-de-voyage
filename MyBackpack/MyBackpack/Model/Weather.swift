import Foundation

// This is the struct i use to stock the url
struct WeatherURL {
    static var city = "" // the textfield.text on the weather View will change this value
    static let baseURL = "http://api.openweathermap.org/data/2.5/weather?q="
    static let parameters =  "&APPID=9f66541d6727b29761689f5926f4b546&units=metric"
}

class WeatherService {
    
    var task: URLSessionDataTask?
    private var weatherSession: URLSession
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    func getWeather(callback: @escaping (Bool, WeatherData?) -> Void) {
        let weatherUrlInString = WeatherURL.baseURL + WeatherURL.city + WeatherURL.parameters
        guard let url = URL(string: weatherUrlInString) else { return }
        
        task?.cancel() // to cancel a task before a new request
        task = weatherSession.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            guard let weatherResponseJSON = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            DispatchQueue.main.async {
                callback(true, weatherResponseJSON)
            }
        }
        task?.resume()
    }
}


