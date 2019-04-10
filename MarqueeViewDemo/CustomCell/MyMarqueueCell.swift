//
//  MyMarqueueCell.swift
//  MarqueeViewDemo
//
//  Created by Zhihui Sun on 10/4/19.
//  Copyright © 2019 Sylvia Shen. All rights reserved.
//

import UIKit

class MyMarqueueCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension MyMarqueueCell: MarqueueViewCellProtocol {
    func configure(with model: MarqueueViewCellModelProtocol) {
        if let model = model as? MyMarqueueCellModel {
            label.text = model.message
        }
    }
}
