import XCTest
@testable import CertificatePinner

final class CertificatePinnerTests: XCTestCase {
    var pinner = CertificatePinner(pins: ["zCTnfLwLKbS9S2sbp+uFz4KZOocFvXxkV06Ce9O5M2w="])
    var pinnerWithNoPins = CertificatePinner(pins: [""])
    
    func testiOS13AndNewer() throws {
        if #available(iOS 13.0.0, *) {
            let network = NetworkMock(pinner: pinner)
            let expectation = expectation(description: "Wait network call")
            network.request { error in
                XCTAssertNil(error)
                expectation.fulfill()
            }
            waitForExpectations(timeout: 5, handler: nil)
        }
    }
    
    func testFailedPinningForiOS13AndNewer() throws {
        if #available(iOS 13.0.0, *) {
            let network = NetworkMock(pinner: pinnerWithNoPins)
            let expectation = expectation(description: "Wait network call")
            network.request { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            waitForExpectations(timeout: 5, handler: nil)
        }
    }
    
    func testOlderiOSVersions() throws {
        let network = OldNetworkMock(pinner: pinner)
        let expectation = expectation(description: "Wait network call")
        network.request { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFailedPinningForOlderiOSVersions() throws {
        let network = OldNetworkMock(pinner: pinnerWithNoPins)
        let expectation = expectation(description: "Wait network call")
        network.request { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
