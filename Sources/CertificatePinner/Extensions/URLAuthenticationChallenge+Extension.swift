//
//  URLAuthenticationChallenge+Extension.swift
//  
//
//  Created by Mirsad Arslanovic on 6. 10. 2022..
//

import Foundation

public extension URLAuthenticationChallenge {
    func getTrust() -> SecTrust? {
        return protectionSpace.serverTrust
    }
}
