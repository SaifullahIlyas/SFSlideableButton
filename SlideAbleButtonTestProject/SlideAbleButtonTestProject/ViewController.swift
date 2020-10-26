//
//  ViewController.swift
//  SlideAbleButtonTestProject
//
//  Created by Saifullah on 26/10/2020.
//  Copyright © 2020 CodeRecipe. All rights reserved.
//

import UIKit
import SFSlideableButton

class ViewController: UIViewController {
    @IBOutlet weak var button: SFSlidesableButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        button.didButtonSlides = {
            // Implemetation goes here
        }
        // Do any additional setup after loading the view.
    }


}

