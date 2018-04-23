import UIKit
import os.log

import FirebaseAuth


class AuthViewController: UIViewController {

    @IBOutlet var Labels: [UILabel]!

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameField.delegate = self
        passwordField.delegate = self

        updateLoginButtonState()
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
        loginButton.layer.cornerRadius = 6
    }

    private func updateLoginButtonState() {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""

        loginButton.isEnabled = !username.isEmpty && !password.isEmpty
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case "ShowOnSuccessfulLogin":
            guard let button = sender as? UIButton, button === loginButton else {
                fatalError("Segue sender not recognized")
            }

            os_log("User logged in", log: .default, type: .debug)
        default:
            fatalError("Unrecognized transition: \(segue.identifier ?? "")")
        }
    }

    @IBAction func didTapLoginButton(_ sender: UIButton) {
        let username = usernameField.text ?? ""
        if username.isEmpty {
            fatalError("Called login with no username")
        }

        let password = passwordField.text ?? ""
        if password.isEmpty {
            fatalError("Called login with no password")
        }

        Auth.auth().signIn(withEmail: username, password: password) { [weak self] (user, error) in
            if let error = error {
                print("Error on auth: \(error)")
                return
            }

            print(user?.email)
            self?.performSegue(withIdentifier: "ShowOnSuccessfulLogin", sender: sender)
        }
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginButton.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLoginButtonState()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
