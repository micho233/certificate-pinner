//
//  Data+Extension.swift
//  
//
//  Created by Mirsad Arslanovic on 1. 10. 2022..
//

import Foundation
#if canImport(CryptoKit)
  import CryptoKit
#endif
import CommonCrypto

extension Data {
    func sha256Base64() -> String {
        if #available(iOS 13.0, macOS 10.15, *) {
            return Data(SHA256.hash(data: self)).base64EncodedString()
        } else {
            var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
            _ = self.withUnsafeBytes {
                CC_SHA256($0.baseAddress!, CC_LONG(self.count), &hash)
            }
            return Data(hash).base64EncodedString()
        }
    }
}
