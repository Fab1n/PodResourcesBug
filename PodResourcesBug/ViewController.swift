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

        let blubbImageView = UIImageView()
        blubbImageView.backgroundColor = .green
        blubbImageView.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        blubbImageView.image = UIImage(named: "blubb")
        self.view.addSubview(blubbImageView)

        let pkhudImageView = UIImageView()
        pkhudImageView.backgroundColor = .blue
        pkhudImageView.frame = CGRect(origin: CGPoint(x: 0, y: 200), size: CGSize(width: 200, height: 200))
        pkhudImageView.image = UIImage(named: "progress_circular")
        self.view.addSubview(pkhudImageView)
    }
}

