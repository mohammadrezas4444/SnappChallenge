//
//  LatestLaunchesTableViewCell.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import UIKit
import SDWebImage

class LatestLaunchesTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillCell(model: LaunchesModel) {
        iconView.sd_setImage(with: URL(string: model.links?.patch?.small ?? ""))
        nameLabel.text = model.name
        flightNumberLabel.text = "\(model.flightNumber)"
        dateLabel.text = "\(model.dateUTC ?? "")"
        resultLabel.text = "\(model.success ?? false)"
        descriptionLabel.text = model.details
    }
}
