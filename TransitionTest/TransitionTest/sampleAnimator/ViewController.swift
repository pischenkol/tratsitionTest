//
//  ViewController.swift
//  TransitionTest
//
//  Created by Lina Pischenko on 8/29/18.
//  Copyright © 2018 PischenkoLina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var viewAnimator: ViewControllerAnimator!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         viewAnimator.initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewAnimator.didChangeOrientation(orientation: UIDevice.current.orientation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

