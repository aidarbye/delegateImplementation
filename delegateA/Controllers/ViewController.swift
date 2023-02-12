//
//  ViewController.swift
//  delegateA
//
//  Created by Айдар Нуркин on 11.02.2023.
//

import UIKit

class ViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ChangeColorVC = segue.destination as! ChangeColorViewController
        ChangeColorVC.delegate = self
        ChangeColorVC.mainViewColor = view.backgroundColor
    }
}

extension ViewController: ChangeColorViewControllerDelegate {
    func updateUI(red: Float, green: Float, blue: Float) {
        view.backgroundColor = .init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
}
