//
//  ViewController.swift
//  DispatchGroupExample
//
//  Created by Work on 10/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let group = DispatchGroup()
    let globalQueue = DispatchQueue.global()

    override func viewDidLoad() {
        super.viewDidLoad()
        firstGroup()
    }
    
    func firstGroup() {
        group.enter()
        globalQueue.asyncAfter(deadline: .now() + 1) {
            print("Task 1 --- Thread = \(Thread.current)")
            self.group.leave()
        }
        
        group.enter()
        globalQueue.asyncAfter(deadline: .now() + 2) {
            print("Task 2 --- Thread = \(Thread.current)")
            self.group.leave()
        }
        groupNotify()
    }
    
    func groupNotify() {
        let startDate = Date()
        let workItem = DispatchWorkItem {
            let endDate = Date().timeIntervalSince(startDate)
            print("All task done ----- Count time = ", endDate)
        }
        
        group.notify(queue: .main, work: workItem)
    }
    
    @IBAction func runSecondGroup(_ sender: Any) {
        group.enter()
        globalQueue.asyncAfter(deadline: .now() + 3) {
            print("Task 3 --- Thread = \(Thread.current)")
            self.group.leave()
        }
        groupNotify()
    }
}
