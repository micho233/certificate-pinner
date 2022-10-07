//
//  File.swift
//  
//
//  Created by Mirsad Arslanovic on 30. 9. 2022..
//

import Foundation
import Security
import CryptoKit
import CommonCrypto

typealias SecKeyTypeAndSize = (type: String, size: Int)

extension SecKey {
    private func getTypeAndSize() -> SecKeyTypeAndSize? {
        guard let attributes = SecKeyCopyAttributes(self) as? [CFString: Any],
              let type = attributes[kSecAttrKeyType] as? String,
              let size = attributes[kSecAttrKeySizeInBits] as? Int else {
            return nil
        }
        return SecKeyTypeAndSize(type: type,
                                 size: size)
    }
    
    func getHeaderSize() -> [UInt8]? {
        guard let attributes = getTypeAndSize() else {
            return nil
        }
        switch attributes {
        case let attr where attr.type == kSecAttrKeyTypeRSA as String && attr.size == 2048:
            return Asn1Header.rsa2048
        case let attr where attr.type == kSecAttrKeyTypeRSA as String && attr.size == 4096:
            return Asn1Header.rsa4096
        case let attr where attr.type == kSecAttrKeyTypeECSECPrimeRandom as String && attr.size == 256:
            return Asn1Header.ecDsaSecp256r1
        case let attr where attr.type == kSecAttrKeyTypeECSECPrimeRandom as String && attr.size == 384:
            return Asn1Header.ecDsaSecp384r1
        default:
            return nil
        }
    }
    
    func getHashFromPublicKey() -> String? {
        var error: Unmanaged<CFError>?
        let data = SecKeyCopyExternalRepresentation(self, &error) as? Data
        return error == nil ? hash(data: data) : nil
    }
    
    private func hash(data: Data?) -> String? {
        guard let header = getHeaderSize(),
              let keyDaya = data else { return nil }
        var keyWithHeader = Data(header)
        keyWithHeader.append(keyDaya)
        return keyWithHeader.sha256Base64()
    }
}

extension Array where Element == SecKey {
    func getPublicKeyHashes() -> [KeyPin] {
        return compactMap { $0.getHashFromPublicKey() }
    }
}
