//
//  AlertViewController.swift
//  CaptureLists
//
//  Created by Scott Gardner on 4/15/20.
//  Copyright © 2020 Scott Gardner. All rights reserved.
//

import UIKit

// MARK: - No strong reference cycle, closure is executed
class AlertViewController: UIAlertController {
    var value = "Hello, world!"

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print(self.value)
        }
    }

    deinit {
        print(#function)
    }
}
