//
//  File.swift
//  
//
//  Created by Mirsad Arslanovic on 7. 10. 2022..
//

import Foundation
import CertificatePinner

class OldNetworkMock: NSObject, URLSessionDelegate {
    var session: URLSession?
    let configuration: URLSessionConfiguration = .default
    var pinner: CertificatePinner!
    
    override init() {
        super.init()
        session = URLSession(configuration: configuration,
                                  delegate: self,
                                  delegateQueue: nil)
    }
    
    convenience init(pinner: CertificatePinner) {
        self.init()
        self.pinner = pinner
    }
    
    func request(completion: @escaping ((Error?) -> Void)) {
        let urlRequest = URLRequest(url: URL(string: "https://google.com")!)
        let task = session?.dataTask(with: urlRequest) { _, _, error in
            completion(error)
        }
        task?.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        pinner.checkCertificateValidity(for: challenge, completion: completionHandler)
    }
}
