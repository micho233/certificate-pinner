//
//  SecCertificate+Extension.swift
//  
//
//  Created by Mirsad Arslanovic on 30. 9. 2022..
//

import Foundation

extension SecCertificate {
    func getPublicKey() -> SecKey? {
        let policy = SecPolicyCreateBasicX509()
        var trust: SecTrust?
        let trustCreationStatus = SecTrustCreateWithCertificates(self, policy, &trust)
        
        guard let createdTrust = trust, trustCreationStatus == errSecSuccess else { return nil }
        
        if #available(iOS 14, macOS 11, tvOS 14, watchOS 7, *) {
            return SecTrustCopyKey(createdTrust)
        } else {
            return SecTrustCopyPublicKey(createdTrust)
        }
    }
}

extension Array where Element == SecCertificate {
    func getPublicKeys() -> [SecKey] {
        return compactMap { $0.getPublicKey() }
    }
}
