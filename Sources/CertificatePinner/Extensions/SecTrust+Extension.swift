//
//  SecTrust.swift
//  
//
//  Created by Mirsad Arslanovic on 30. 9. 2022..
//

import Foundation

public extension SecTrust {
    var certificateChain: [SecCertificate] {
        if #available(iOS 15.0, macOS 12.0, *) {
            return (SecTrustCopyCertificateChain(self) as? [SecCertificate]) ?? []
        } else {
            return (0..<SecTrustGetCertificateCount(self)).compactMap { index in
                SecTrustGetCertificateAtIndex(self, index)
            }
        }
    }
    
    private var publicKeys: [SecKey] {
        return certificateChain.getPublicKeys()
    }
    
    func getPublicKeyHashes() -> [KeyPin] {
        return publicKeys.getPublicKeyHashes()
    }
    
    func setSSLPolicy(for host: String) {
        let policy = SecPolicyCreateSSL(true, host as CFString)
        SecTrustSetPolicies(self, policy)
    }
    
    func canEvaluate() -> Bool {
        if #available(iOS 12.0, *) {
            let result = SecTrustEvaluateWithError(self, nil)
            return result
        } else {
            var secresult = SecTrustResultType.invalid
            let status = SecTrustEvaluate(self, &secresult)
            return status == errSecSuccess
        }
    }
}
