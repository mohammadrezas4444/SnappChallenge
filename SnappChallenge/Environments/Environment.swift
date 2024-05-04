//
//  Environment.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-04.
//

import Foundation

enum Environment: String {
    case BASE_URL

    var value: String {
        return (self.infoDict[self.rawValue] as! String).replacingOccurrences(of: "\\", with: "")
    }

    private var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict["XCCONFIGS"] as! [String: Any]
        } else {
            fatalError("Plist file not found")
        }
    }
}
