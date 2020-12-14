//
//  KFImage+fromCustomUrl.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.12.2020.
//

import UIKit
import Kingfisher

/// URL of format either `https://somedomain/image` or `assets://assets-image-name`
typealias UniverseUrl = String

extension KFImage {
    /// Loads KFImage from universe url
    static func fromUniverseUrl(_ url: String) -> KFImage {
        if url.starts(with: "assets://") {
            let name = url.replacingOccurrences(of: "assets://", with: "")
            let image = UIImage(named: name)
            guard let data = image?.pngData() else {
                return KFImage(nil)
            }
            return KFImage(source: .provider(RawImageDataProvider(data: data, cacheKey: name)))
        } else {
            return KFImage(URL(string: url))
        }
    }
}
