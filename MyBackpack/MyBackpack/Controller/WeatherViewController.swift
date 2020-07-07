

import UIKit

class WeatherViewController: UIViewController {
    

    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var weatherTextField: UITextField!
    @IBOutlet weak var iconImage: UIImageView!
    var weatherService = WeatherService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func weatherButton(_ sender: Any) {
       let cityTextField = weatherTextField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        WeatherURL.city = cityTextField!
        weatherService.getWeather { (success, weatherResponseJSON) in
            guard let weather = weatherResponseJSON else {
                self.presentAlert(message: "Error with the response, please try later")
                print("error weatherResponseJSON")
                return
            }
            self.temperature.text = String(weather.main.temp) + "°C"
            self.main.text = weather.weather[0].main
            self.iconImage.image = UIImage(named: weather.weather[0].icon)
    }

}
    
}

