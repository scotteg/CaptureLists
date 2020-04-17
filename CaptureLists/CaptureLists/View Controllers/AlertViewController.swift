//
//  AlertViewController.swift
//  CaptureLists
//
//  Created by Scott Gardner on 4/15/20.
//  Copyright © 2020 Scott Gardner. All rights reserved.
//

import UIKit

// MARK: - No strong reference cycle, closure is executed
//class AlertViewController: UIAlertController {
//    var value = "Hello, world!"
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            print(self.value)
//        }
//    }
//
//    deinit {
//        print(#function)
//    }
//}

// MARK: - No strong reference cycle, closure is not executed, exception because self is nil
//class AlertViewController: UIAlertController {
//
//    var value = "Hello, world!"
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
//            print(self.value)
//        }
//    }
//
//    deinit {
//        print(#function)
//    }
//}

// MARK: - No strong reference cycle, closure is not executed
//class AlertViewController: UIAlertController {
//    var value = "Hello, world!"
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//            guard let self = self else { return }
//            print(self.value)
//        }
//    }
//
//    deinit {
//        print(#function)
//    }
//}


// MARK: - Strong reference cycle, closure is executed
//class AlertViewController: UIAlertController {
//    var value = "Hello, world!"
//    var action: (() -> Void)?
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        action = {
//            print(self.value)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.action!()
//        }
//    }
//
//    deinit {
//        print(#function)
//    }
//}

// MARK: - No strong reference cycle, closure is executed
//class AlertViewController: UIAlertController {
//
//    var value = "Hello, world!"
//    var action: (() -> Void)?
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        action = { [weak self] in
//            guard let self = self else { return }
//            print(self.value)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.action!()
//        }
//    }
//
//    deinit {
//        print(#function)
//    }
//}

// MARK: - Strong reference cycle, closure is executed
//class AlertViewController: UIAlertController {
//    var value = "Hello, world!"
//    var action: (() -> Void)?
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        action = {
//            print(self.value)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//            guard let self = self else { return }
//            self.action!()
//        }
//    }
//
//    deinit {
//        print(#function)
//    }
//}

// MARK: - No strong reference cycle, closure is not executed
//class AlertViewController: UIAlertController {
//    var value = "Hello, world!"
//    var action: (() -> Void)?
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        action = { [weak self] in
//            guard let self = self else { return }
//            print(self.value)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//            guard let self = self else { return }
//            self.action!()
//        }
//    }
//
//    deinit {
//        print(#function)
//    }
//}

// MARK: - No strong reference cycle, closure is not executed
class AlertViewController: UIAlertController {
    // 1
    class Action {
        let execute: () -> Void
        
        init(action: @escaping () -> Void) {
            self.execute = action
        }
    }
    
    var value = "Hello, world!"
    var action1: Action?
    var action2: Action?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 2
        action1 = Action() { [weak self] in
            self?.value = "Changed"
        }
        
        action2 = Action() { [weak self] in
            guard let self = self else { return }
            print(self.value)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // 3
            [weak action1, weak action2] in
            guard let action1 = action1,
                let action2 = action2
                else { return }
            
            action1.execute()
            action2.execute()
        }
    }

    deinit {
        print(#function)
    }
}
