//
//  Extensions.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import Foundation
import UIKit

extension String {
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }

    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}

extension UITableView {
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}

extension UITableViewCell {
    static var identifier: String { return String.className(self) }
}
