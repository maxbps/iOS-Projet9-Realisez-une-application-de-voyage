import Foundation
import UIKit

extension UIViewController {
    // use case example : self.presentAlert(message: .errorIngredientneeded)
    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Alerte", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}





