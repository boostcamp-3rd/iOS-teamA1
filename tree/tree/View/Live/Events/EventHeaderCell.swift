//
//  EventHeaderCell.swift
//  tree
//
//  Created by ParkSungJoon on 12/02/2019.
//  Copyright © 2019 gardener. All rights reserved.
//

import UIKit

class EventHeaderCell: UITableViewCell {

    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var shadowView: UIView {
        let shadowView = UIView(
            frame: CGRect(
                x: innerMargin,
                y: innerMargin,
                width: bounds.width - (2 * innerMargin),
                height: bounds.height - (2 * innerMargin))
        )
        insertSubview(shadowView, at: 0)
        return shadowView
    }
    private let innerMargin: CGFloat = 20.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCorners(layer: backgroundContainerView.layer, radius: 14)
        self.applyShadow(
            shadowView: shadowView,
            width: CGFloat(0.0),
            height: CGFloat(0.0)
        )
    }
}
