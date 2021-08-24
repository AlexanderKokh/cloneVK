// URLSessionConfiguration+Alamofire.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

extension URLSessionConfiguration: AlamofireExtended {}
public extension AlamofireExtension where ExtendedType: URLSessionConfiguration {
    /// Alamofire's default configuration. Same as `URLSessionConfiguration.default` but adds Alamofire default
    /// `Accept-Language`, `Accept-Encoding`, and `User-Agent` headers.
    static var `default`: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default

        return configuration
    }
}
