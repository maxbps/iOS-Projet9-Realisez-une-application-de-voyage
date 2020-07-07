import UIKit

class FixerViewController: UIViewController {
    @IBOutlet var FixerView: UIView!
    
    @IBOutlet weak var fixerLabelFix: UILabel!
    @IBOutlet weak var fixerLabel: UILabel!
    @IBOutlet weak var fixerTextField: UITextField!
    
    var fixerService = FixerService()
    
    @IBAction func fixerButton(_ sender: Any) {
        fixerService.getFixer { (success, rate) in
            
            if success == true {
                var countFixer = -1
                for i in self.fixerService.currencies {
                    countFixer += 1
                    var value: Double = 0
                    if i == "USD" {
                        
                        if self.fixerTextField.text != "" {
                            value = Double((self.fixerTextField.text)!)!}
                        else {
                            value = 0
                        }
                        self.fixerLabelFix.text = "1 euro vaut \(self.fixerService.rate[countFixer]) \(self.fixerService.currencies[countFixer])"
                        
                        self.fixerLabel.text = "\(value) euros vaut \(self.fixerService.rate[countFixer] * value) \(self.fixerService.currencies[countFixer])"
                    }
                }
            } else {
                self.presentAlert(message: "Error with the response, please try later")
            }
        }
    }
}

