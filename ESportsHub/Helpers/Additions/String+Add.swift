//
//  String+Add.swift
//  ESportsHub
//
//  Created by Константин Чернов on 09.05.2022.
//

import Foundation

extension String {
    func getFormattedDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateformat1 = DateFormatter()
        dateformat1.locale = Locale(identifier: "en_US_POSIX")
        dateformat1.dateFormat = "MMM d, HH:mm"
        return dateformat1.string(from: dateformat.date(from: self)!)
    }
}
