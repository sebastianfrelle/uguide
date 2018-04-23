import UIKit

class AuthViewController: UIViewController {

    @IBOutlet var UILabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func styleLabels() {
        for UILabel in UILabels {
            UILabel.font = UIFont.boldSystemFont(ofSize: UILabel.font.pointSize)
        }
    }
}

