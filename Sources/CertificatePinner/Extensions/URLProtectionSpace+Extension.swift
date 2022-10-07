//
//  URLProtectionSpace+Extension.swift
//  
//
//  Created by Mirsad Arslanovic on 6. 10. 2022..
//

import Foundation

extension URLProtectionSpace {
    func getBaseUrl() -> String? {
        return makeBaseUrl()?.absoluteString
    }
    
    private func makeBaseUrl() -> URL? {
        var components = URLComponents()
        components.scheme = RequestScheme.https.rawValue
        components.host = host
        return components.url
    }
}
