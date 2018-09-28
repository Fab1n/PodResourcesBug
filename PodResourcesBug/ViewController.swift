//
//  ViewController.swift
//  PodResourcesBug
//
//  Created by Fabian Renner on 28.09.18.
//  Copyright © 2018 Fabian Renner. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        imageView.image = UIImage(named: "checkmark")
        self.view.addSubview(imageView)
    }


}

