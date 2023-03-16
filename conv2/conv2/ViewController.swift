//
//  ViewController.swift
//  conv2
//
//  Created by Miloshevich on 12.12.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var addNumberTextField: UITextField!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNumberTextField.delegate = self
        scrollView.delegate = self
        customizeButton()
        
        registerForKeyboardNotification()
    }
    
    @IBAction func fromDecimalToBinary(_ sender: UIButton) {
        fromDecimalToBinary()
    }
    
    @IBAction func fromDecimalToOctal(_ sender: Any) {
        fromDecimalToOctal()
    }
    
    @IBAction func fromDecimalToHex(_ sender: UIButton) {
        fromDecimalToHex()
    }
    
    @IBAction func fromBinaryToDecimal(_ sender: UIButton) {
        fromBinaryToDecimal()
    }
    @IBAction func fromOctalToDecimal(_ sender: UIButton) {
        fromOctalToDecimal()
    }
    
    @IBAction func fromHexToDecimal(_ sender: UIButton) {
        fromHexToDecimal()
    }
    @IBAction func clearButton(_ sender: UIButton) {
        addNumberTextField.text = nil
    }
    
    //    func fromDecimalToAny(number: String) {
    //     if let number = Int(addNumberTextField.text, radix: 10) {
    //            addNumberTextField.text = String(number, radix: 2)
    //        }
    //    }
    
    func fromDecimalToBinary() {
        if let numberInDecimal = Int(addNumberTextField.text ?? "") {
            addNumberTextField.text = String(numberInDecimal, radix: 2)
        } else {
            addNumberTextField.text = "Error"
        }
    }
    
    func fromDecimalToOctal() {
        if let number = Int(addNumberTextField.text ?? "") {
            addNumberTextField.text = String(number, radix: 8)
        } else {
            addNumberTextField.text = "Error"
        }
    }
    
    func fromDecimalToHex() {
        if let number = Int(addNumberTextField.text ?? "") {
            addNumberTextField.text = String(number, radix: 16)
        } else {
            addNumberTextField.text = "Error"
        }
    }
    
    func fromBinaryToDecimal() {
        if let number = UInt(addNumberTextField.text ?? "", radix: 2) {
            addNumberTextField.text = String(number, radix: 10)
        } else {
            addNumberTextField.text = "Error"
        }
    }
    
    func fromOctalToDecimal() {
        if let number = UInt(addNumberTextField.text ?? "", radix: 8) {
            addNumberTextField.text = String(number, radix: 10)
        } else {
            addNumberTextField.text = "Error"
        }
    }
    
    func fromHexToDecimal() {
        if let number = UInt(addNumberTextField.text ?? "", radix: 16) {
            addNumberTextField.text = String(number, radix: 10)
        } else {
            addNumberTextField.text = "Error"
        }
    }
    
    //    func fromHexToDecimal() {
    //        guard (UInt(addNumberTextField.text ?? "", radix: 10) != nil)  else { return }
    //         let number = UInt(addNumberTextField.text ?? "", radix: 16)
    //        addNumberTextField.text = String(number ?? 0, radix: 10)
    //    }
    
    func customizeButton() {
        for button in buttonCollection {
            button.layer.cornerRadius = button.frame.height / 2
            //            button.layer.borderWidth = 2
            //            button.layer.borderColor = UIColor.systemGray2.cgColor
            button.layer.shadowOpacity = 0.4
            button.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
}

//MARK: UITextViewDelegate
extension ViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addNumberTextField.resignFirstResponder()
        return true
    }
}

//MARK: UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
