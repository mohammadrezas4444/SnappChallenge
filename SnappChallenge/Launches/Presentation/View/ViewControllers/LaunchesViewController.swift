//
//  LaunchesViewController.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import UIKit
import Factory

class LaunchesViewController: UIViewController {

    // MARK: - Injected
    @Injected(\LaunchesDI.launchesViewModel) private var viewModel

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    private var spinner: UIActivityIndicatorView!
    private typealias DataSource = UITableViewDiffableDataSource<LaunchesSections.Section, LaunchesSections.Section.Item>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<LaunchesSections.Section, LaunchesSections.Section.Item>
    private lazy var dataSource = makeDataSource()
    private var cancelBag = CancelBag()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        observe()
        setupViews()
    }

    // MARK: - Observe
    private func observe() {
        viewModel
            .$launchesSections
            .filter { !$0.isEmpty }   
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sections in
                guard let self else { return }
                tableView.isHidden = false
                applySnapshot(sections: sections)
            }.store(in: cancelBag)

        viewModel
            .$isLoading
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loading in
                guard let self else { return }
                loading ? spinner.startAnimating() : spinner.stopAnimating()
            }.store(in: cancelBag)
    }

    // MARK: - Setup views
    private func setupViews() {
        setupShowMoreSpinner()
        setupTableView()
    }

    private func setupShowMoreSpinner() {
        spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        tableView.tableFooterView = spinner
    }

    private func setupTableView() {
        tableView.isHidden = true
        tableView.delegate = self
        tableView.registerCellNib(LatestLaunchesTableViewCell.self)
    }

    private func makeDataSource() -> DataSource {
        return DataSource(tableView: tableView) { tableView, indexPath, option in
            switch option {
            case .allLaunches(let docLaunchModel):
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: LatestLaunchesTableViewCell.identifier,
                    for: indexPath
                ) as? LatestLaunchesTableViewCell

                cell?.fillCell(model: docLaunchModel)
                return cell
            }
        }
    }

    private func applySnapshot(sections: [LaunchesSections.Section]) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach {
            snapshot.appendItems($0.items, toSection: $0)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UITableViewDelegate
extension LaunchesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        viewModel.attemptToNavigateToDetails(index: index)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLastRow = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        if isLastRow && !viewModel.isLoading { viewModel.attemptToGetNextPage() }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
