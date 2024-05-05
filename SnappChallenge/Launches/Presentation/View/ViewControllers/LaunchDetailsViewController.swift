//
//  LaunchDetailsViewController.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-04.
//

import UIKit
import Factory
import SafariServices

class LaunchDetailsViewController: UIViewController {

    // MARK: - Injected
    @Injected(\LaunchesDI.launchDetailViewModel) private var viewModel

    // MARK: - IBOutlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var BookmarkImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var wikipediaLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

    // MARK: - Peroperties
    private lazy var cancelBag = CancelBag()
    private var wikipediaLink: String?
    private var isBookmarked: Bool = false

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        observe()
    }

    // MARK: - Observe
    private func observe() {
        viewModel
            .$launchDetail
            .filter { $0 != nil }
            .sink { [weak self] launchDetail in
                guard let self else { return }
                setupViews(launchDetail!)
            }.store(in: cancelBag)
    }

    // MARK: - Setup views
    private func setupViews(_ launch: LaunchesModel) {
        let imageURL = URL(string: launch.links?.patch?.large ?? "")
        coverImageView.sd_setImage(with: imageURL)
        nameLabel.text = launch.name ?? "NO_NAME".localize
        isBookmarked = launch.isBookmarked
        dateLabel.text = launch.dateUTC
        detailsLabel.text = launch.details
        setupBookmarkButton()
        setupWikipedia(launch)
    }

    private func setupBookmarkButton() {
        setBookmarkImageView()
        BookmarkImageView.isUserInteractionEnabled = true
        BookmarkImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnBookmarkButton)))
    }

    private func setBookmarkImageView() {
        BookmarkImageView.image = isBookmarked ? UIImage(resource: .filledBookmark) : UIImage(resource: .bookmark)
    }

    private func setupWikipedia(_ launch: LaunchesModel) {
        wikipediaLink = launch.links?.wikipedia
        wikipediaLabel.isHidden = launch.links?.wikipedia == nil
        wikipediaLabel.isUserInteractionEnabled = true
        wikipediaLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnWikipedia)))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "WIKIPEDIA_LINK".localize, attributes: underlineAttribute)
        wikipediaLabel.attributedText = underlineAttributedString
    }

    @objc func didTapOnWikipedia() {
        guard let url = URL(string: wikipediaLink ?? "") else { return }
        let safariViewController = SFSafariViewController(url: url)
        self.view.window?.rootViewController?.present(safariViewController, animated: true)
    }

    @objc func didTapOnBookmarkButton() {
        isBookmarked = !isBookmarked
        setBookmarkImageView()
        isBookmarked ? viewModel.attemptToBookmark() : viewModel.attemptToRemoveBookmark()
    }
}
