//
//  String+Extension.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/12/21.
//

import Foundation

extension String {
    var asEmail: String? {
        let email = trim().lowercased()
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailTest.evaluate(with: email) {
            return nil
        }
        return email
    }

    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    var isStringLink: Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        if
            let detector = try? NSDataDetector(types: types.rawValue),
            detector.numberOfMatches(in: self,
                                     options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                     range: NSRange(location: 0, length: self.count)) > 0 {
            return true
        }
        return false
    }

    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    /// Substring helper.
    ///
    /// - Parameters:
    ///   - start: Where to start
    ///   - offsetBy: End of string
    /// - Returns: regular substring and nil if start or offsetBy is out of bounds
    func substring(start: Int, offsetBy: Int) -> String? {
        guard
            let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex),
            let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
                return nil
        }

        return String(self[substringStartIndex ..< substringEndIndex])
    }

    /// Count non empty words separated by separator
    /// - Parameter separator: CharacterSet to split words
    func count(separatedBy separator: CharacterSet) -> Int {
        components(separatedBy: separator)
            .filter { !$0.isEmpty }
            .count
    }
}

extension StringProtocol {
    /// Check localizedCaseInsensitiveContains with nil and empty returning true
    /// - Parameter other: StringProtocol to compare.
    func localizedCaseInsensitiveContainsWithEmptyCheck<T>(_ other: T?) -> Bool where T: StringProtocol {
        guard let other = other, !other.isEmpty else { return true }
        return localizedCaseInsensitiveContains(other)
    }
}

