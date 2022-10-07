import Security
import Foundation

public typealias KeyPin = String
public typealias ChallengeResponse = (URLSession.AuthChallengeDisposition, URLCredential?)
public typealias ChallengeResponseCompletion =  (URLSession.AuthChallengeDisposition, URLCredential?) -> Void

public class CertificatePinner {
    private var keyPins: [KeyPin] = []
    private var baseUrl: String?
    
    public init() {}
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public init(baseUrl: String, pins: [KeyPin]) {
        self.baseUrl = baseUrl
        self.keyPins = pins
    }
    
    public init(pins: [KeyPin]) {
        self.keyPins = pins
    }
    
    public func setPublicKeyHashes(_ pins: [KeyPin]) {
        self.keyPins = pins
    }
    
    public func setBaseUrl(_ baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    private func validate(trust: SecTrust, for requestUrl: String? = nil) -> Bool {
        guard let baseUrl = requestUrl ?? baseUrl,
              let url = URL(string: baseUrl),
              let host = url.host
        else {
            return false
        }
                
        trust.setSSLPolicy(for: host)
        return trust.canEvaluate()
    }
    
    private func validatePublicKeys(for trust: SecTrust, and url: String? = nil) -> Bool {
        guard validate(trust: trust, for: url) else { return false }
        let hashes = trust.getPublicKeyHashes()
        return hashes.contains(where: { keyPins.contains($0) })
    }
    
    public func checkCertificateValidity(for challenge: URLAuthenticationChallenge, completion: ChallengeResponseCompletion) {
        guard let trust = challenge.getTrust(),
              let url = challenge.protectionSpace.getBaseUrl() else {
            return completion(.performDefaultHandling, nil)
        }

        if validatePublicKeys(for: trust, and: url) {
            let credential = URLCredential(trust: trust)
            return completion(.useCredential, credential)
        } else {
            return completion(.cancelAuthenticationChallenge, nil)
        }
    }
    
    @available(iOS 13.0.0, *)
    public func checkCertificateValidity(for challenge: URLAuthenticationChallenge) async -> ChallengeResponse {
        guard let trust = challenge.getTrust(),
              let url = challenge.protectionSpace.getBaseUrl() else {
            return (.performDefaultHandling, nil)
        }

        if validatePublicKeys(for: trust, and: url) {
            let credential = URLCredential(trust: trust)
            return (.useCredential, credential)
        } else {
            return (.cancelAuthenticationChallenge, nil)
        }
    }
}
