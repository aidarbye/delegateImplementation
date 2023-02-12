//
//  ChangeColorViewController.swift
//  delegateA
//
//  Created by Айдар Нуркин on 11.02.2023.
//

import UIKit
protocol ChangeColorViewControllerDelegate:AnyObject {
    func updateUI(red: Float, green: Float, blue: Float)
}
class ChangeColorViewController: UIViewController {
    
    @IBOutlet var MainLabelColor: UIView!
    
    @IBOutlet var BlueLabel: UILabel!
    @IBOutlet var GreenLabel: UILabel!
    @IBOutlet var RedLabel: UILabel!
    
    @IBOutlet var BlueSlider: UISlider!
    @IBOutlet var GreenSlider: UISlider!
    @IBOutlet var RedSlider: UISlider!
    
    @IBOutlet var BlueTextField: UITextField!
    @IBOutlet var GreenTextField: UITextField!
    @IBOutlet var RedTextField: UITextField!
    
    var mainViewColor: UIColor!
//    let button = UIButton()
    
    weak var delegate: ChangeColorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainLabelColor.layer.cornerRadius = 20
        navigationItem.hidesBackButton = true
        
        // MARK: Set Main View Color
        MainLabelColor.backgroundColor = mainViewColor
        
        // MARK: Set Sliders
        let ciColor = CIColor(color: mainViewColor)
        RedSlider.value = Float(ciColor.red)
        BlueSlider.value = Float(ciColor.blue)
        GreenSlider.value = Float(ciColor.green)
        
        // MARK: Set Labels
        RedLabel.text = String(format: "%.2f", RedSlider.value)
        GreenLabel.text = String(format: "%.2f", GreenSlider.value)
        BlueLabel.text = String(format: "%.2f", BlueSlider.value)
        
        // MARK: Set TextFields
        RedTextField.text = String(format: "%.2f", RedSlider.value)
        GreenTextField.text = String(format: "%.2f", GreenSlider.value)
        BlueTextField.text = String(format: "%.2f", BlueSlider.value)
        
        addDoneButtons(to: RedTextField,GreenTextField,BlueTextField)
    }
    
    @IBAction func RedSliderAction(_ sender: Any) {
        RedLabel.text = String(format: "%.2f", RedSlider.value)
        RedTextField.text = String(format: "%.2f", RedSlider.value)
        updateMainLabel(red: CGFloat(RedSlider.value),
                        green: CGFloat(GreenSlider.value),
                        blue: CGFloat(BlueSlider.value)
        )
    }
    
    @IBAction func GreenSliderAction(_ sender: Any) {
        GreenLabel.text = String(format: "%.2f", GreenSlider.value)
        GreenTextField.text = String(format: "%.2f", GreenSlider.value)
        updateMainLabel(red: CGFloat(RedSlider.value),
                        green: CGFloat(GreenSlider.value),
                        blue: CGFloat(BlueSlider.value)
        )
    }
    
    @IBAction func BlueSliderAction(_ sender: Any) {
        BlueLabel.text = String(format: "%.2f", BlueSlider.value)
        BlueTextField.text = String(format: "%.2f", BlueSlider.value)
        updateMainLabel(red: CGFloat(RedSlider.value),
                        green: CGFloat(GreenSlider.value),
                        blue: CGFloat(BlueSlider.value)
        )
    }
    
    @IBAction func DoneAction(_ sender: Any) {
        mainViewColor = MainLabelColor.backgroundColor
        delegate?.updateUI(red: RedSlider.value, green: GreenSlider.value, blue: BlueSlider.value)
        dismiss(animated: true)
    }
}

extension ChangeColorViewController {
    private func updateMainLabel(red: CGFloat, green: CGFloat, blue: CGFloat) {
        MainLabelColor.backgroundColor = .init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func addDoneButtons(to textFields: UITextField...) {
        textFields.forEach { textField in
            let keyboardToolbar = UIToolbar()
            textField.inputAccessoryView = keyboardToolbar
            keyboardToolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(didTapDone)
            )
            
            let flexBarButton = UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            )
            
            keyboardToolbar.items = [flexBarButton, doneButton]
        }
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension ChangeColorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let text = textField.text!
        
        if let currentValue = Float(text), currentValue <= 1 {
            RedSlider.setValue(currentValue, animated: true)
            RedLabel.text = String(format: "%.2f", RedSlider.value)
        }
        //            switch textField {
        //            case RedTextField:
        //                RedSlider.setValue(currentValue, animated: true)
        //                RedLabel.text = String(format: "%.2f", RedSlider.value)
        //            case GreenTextField:
        //                GreenSlider.setValue(currentValue, animated: true)
        //                GreenLabel.text = String(format: "%.2f", GreenSlider.value)
        //            case BlueTextField:
        //                BlueSlider.setValue(currentValue, animated: true)
        //                BlueLabel.text = String(format: "%.2f", BlueSlider.value)
        //            default: break
        //            }
        
        updateMainLabel(
            red: CGFloat(RedSlider.value),
            green: CGFloat(GreenSlider.value),
            blue: CGFloat(BlueSlider.value)
        )
    showAlert(title: "Wrong format!", message: "Please enter correct value")
    }
}
