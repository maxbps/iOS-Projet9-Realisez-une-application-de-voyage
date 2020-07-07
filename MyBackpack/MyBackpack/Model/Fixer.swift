
import Foundation


// This is the struct i use to stock the url
struct FixerURL {
    static let baseURL = "http://data.fixer.io/api/latest?access_key="
    static let key = "2e4288a2049e923be5767c9bacf7ae2a"
}

class FixerService {
    
    var currencies = [String]()
    var rate = [Double]()
    
    var task: URLSessionDataTask?
    private var fixerSession: URLSession
    
    init(fixerSession: URLSession = URLSession(configuration: .default)) {
        self.fixerSession = fixerSession
    }
    
    func getFixer(callback: @escaping (Bool, CurrencyData?) -> Void) {
        let fixerUrlInString = FixerURL.baseURL + FixerURL.key
        guard let url = URL(string: fixerUrlInString) else { return }
        
        task?.cancel() // to cancel a task before a new request
        task = fixerSession.dataTask(with: url) { data, response, error in
            
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
            guard let fixerResponseJSON = try? JSONDecoder().decode(CurrencyData.self, from: data) else {
                DispatchQueue.main.async {
                    callback(false, nil)
                }
                return
            }
            for (currencie, rate) in fixerResponseJSON.rates {
                self.currencies.append(currencie)
                self.rate.append(rate)
            }
            DispatchQueue.main.async {
                callback(true, fixerResponseJSON)
            }
        }
        task?.resume()
    }
}
