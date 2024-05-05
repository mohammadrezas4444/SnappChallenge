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
        nameLabel.text = "\("NAME".localize): \(model.name ?? "")"
        flightNumberLabel.text = "\("FLIGHT_NUMBER".localize): \(model.flightNumber)"
        dateLabel.text = "\("DATE".localize): \(model.dateUTC ?? "")"
        resultLabel.text = "\("RESULT".localize): \(model.success ?? false)"
        descriptionLabel.text = "\("DESCRIPTION".localize): \(model.details ?? "")"
    }
}
