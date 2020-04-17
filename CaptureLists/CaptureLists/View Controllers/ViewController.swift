//
//  ViewController.swift
//  CaptureLists
//
//  Created by Scott Gardner on 4/15/20.
//  Copyright © 2020 Scott Gardner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
            
    @IBAction func presentAlert() {
        let alert = AlertViewController(title: "Test", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
