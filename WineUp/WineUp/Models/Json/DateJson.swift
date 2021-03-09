//
//  DateJson.swift
//  WineUp
//
//  Created by Александр Пахомов on 09.03.2021.
//

import Foundation

// MARK: - DateProtocol

private enum DateCodingKeys: String, CodingKey {
    case date
}

protocol DateProtocol: Codable {
    var date: Date { get set }
    static var formatter: DateFormatter { get }

    init()
    init(_ date: Date)
    init(string: String) throws
    init(from decoder: Decoder) throws
}

extension DateProtocol {
    init(_ date: Date) {
        self.init()
        self.date = date
    }

    init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.singleValueContainer()
        guard let date = (try container.decode(String.self)).toDate(format: Self.formatter) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [DateCodingKeys.date],
                                                    debugDescription: "Wrong format of date for"))
        }
        self.date = date
    }

    init(string: String) throws {
        self.init()
        guard let date = string.toDate(format: Self.formatter) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [DateCodingKeys.date],
                                                    debugDescription: "Wrong format of date for: \(string)"))
        }
        self.date = date
    }

    func encode(to encoder: Encoder) throws {
        var encoder = encoder.singleValueContainer()
        try encoder.encode(date.toString(format: Self.formatter))
    }
}

// MARK: - Implementations

struct LocalDate: DateProtocol {
    var date: Date = Date()
    static let formatter: DateFormatter = .dateOnly

    init() { }
}

// MARK: - Helpers

extension String {
    func toDate(format: DateFormatter) -> Date? {
        format.date(from: self)
    }
}

extension Date {
    func toString(format: DateFormatter) -> String? {
        format.string(from: self)
    }

    var localDate: LocalDate {
        LocalDate(self)
    }
}

// MARK: - DateFormatter

extension DateFormatter {
    convenience init(scheme: String, timeZone: TimeZone? = nil, locale: Locale? = nil) {
        self.init()
        self.dateFormat = scheme
        self.timeZone = timeZone
        self.locale = locale
    }

    static let dateOnly = DateFormatter(scheme: "dd.MM.YYY", timeZone: .utc)
}

extension TimeZone {
    //swiftlint:disable force_unwrapping
    static let utc = TimeZone(secondsFromGMT: 0)!
}
