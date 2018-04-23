import UIKit

class AuthViewController: UIViewController {
        
    @IBOutlet var Labels: [UILabel]!
    @IBOutlet var TextFields: [UITextField]!
    @IBOutlet weak var LoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserInterface()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpUserInterface() {
        UILabel.appearance().font = UIFont(name: "Lato-Regular", size: 16)
        UITextView.appearance().font = UIFont(name: "Lato-Regular", size: 14)
        LoginBtn.layer.cornerRadius = 6
    }
    
}

