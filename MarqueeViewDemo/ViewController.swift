//
//  ViewController.swift
//  MarqueeViewDemo
//
//  Created by Zhihui Sun on 9/4/19.
//  Copyright © 2019 Sylvia Shen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var marqueueView: MarqueueView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMarueueView()
    }
    
    private func configureMarueueView() {
        let models = [MyMarqueueCellModel(message: "The 1st message."),
                      MyMarqueueCellModel(message: "The 2nd message."),
                      MyMarqueueCellModel(message: "The 3rd message."),
                      MyMarqueueCellModel(message: "The 4th message."),
                      MyMarqueueCellModel(message: "The 5th message.")]
        
        marqueueView.configure(models: models,
                               customCellNib: UINib(nibName: "MyMarqueueCell", bundle: .main),
                               orientation: .vertical,
                               interval: 2)
    }
}

