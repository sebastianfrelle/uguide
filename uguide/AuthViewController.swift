import UIKit
import os.log

import FirebaseAuth


class AuthViewController: UIViewController {
    
    //MARK: Views
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        passwordField.delegate = self
        loginButton.layer.cornerRadius = 6
        updateLoginButtonState()
        setUpUserInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Additionally adds text to the textfield for testing and enables button.
    //Method only used for testing.
    func setUpUserInterface() {
        usernameField.text = "hanshansen@mockmail.com"
        passwordField.text = "hanshansen"
        loginButton.isEnabled = true
    }
    //Checks wether the login field or password are empty
    private func updateLoginButtonState() {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        loginButton.isEnabled = !username.isEmpty && !password.isEmpty
    }
    //Prepare segue
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
    //Adds the login function to the button and checks if the credentials of the user is correct.
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
//MARK: UITextField Delegate

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
