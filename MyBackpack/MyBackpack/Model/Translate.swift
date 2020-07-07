
import Foundation

// This is the struct i use to stock the url, textToTranslate will take the value of translateTextField
struct TranslateURL {
    
    static let baseURL = "https://translation.googleapis.com/language/translate/v2?key="
    static let key = "AIzaSyD_wDwmFHOY-6MQ09xn2ESjiUTSTjX7g7Y&q="
    static var textToTranslate = ""
    static let parameters = "&source=fr&target=en&format=text"
}

class TranslateService {
    
    var task: URLSessionDataTask?
    private var translateSession: URLSession
    
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
    
    // the func that is call by translateButton to receive data from translation.googleapi
    func getTranslation(callback: @escaping (Bool, TranslateData?) -> Void) {
        //addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) is used to convert special character " " to "%20" in string in order to be use in an url
        let translateUrlInString = TranslateURL.baseURL + TranslateURL.key + TranslateURL.textToTranslate.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + TranslateURL.parameters
        guard let url = URL(string: translateUrlInString) else { return }
        
        task?.cancel() // to cancel a task before a new request
        task = translateSession.dataTask(with: url) { data, response, error in
            
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
            guard let translateResponseJSON = try? JSONDecoder().decode(TranslateData.self, from: data) else {
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            DispatchQueue.main.async {
                callback(true, translateResponseJSON)
            }
        }
        task?.resume()
    }
}

