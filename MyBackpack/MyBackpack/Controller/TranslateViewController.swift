
import UIKit

class TranslateViewController: UIViewController {
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var translateLabel: UILabel!
    

    var translateService = TranslateService()
    
    @IBAction func translateButton(_ sender: Any) {
    
            guard translateTextField.text != "" else {
                translateLabel.text = "nothing to translate"
                return
            }
        TranslateURL.textToTranslate = translateTextField.text!
              translateService.getTranslation { (success, translateResponseJSON) in
              guard let translation = translateResponseJSON else {
                self.presentAlert(message: "Error with the response, please try later")
                    print("error translateResponseJson")
              return
                }
                       
       self.translateLabel.text = translation.data.translations[0].translatedText!
    
                }
           }
}



