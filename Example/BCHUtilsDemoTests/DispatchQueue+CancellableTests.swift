import XCTest
import Nimble
import BCHUtils

final class DispatchQueue_CancellableTests: XCTestCase {

	func testWithoutCancelation() {
		var blockExecuted = false
		_ = DispatchQueue.global(qos: .default).cancellableAfter(0.1) {
			blockExecuted = true
		}

		expect(blockExecuted).toEventually(beTruthy(), timeout: 2)
	}

	func testCancelation() {
		let cancelationToken = DispatchQueue.global(qos: .default).cancellableAfter(0.1) {
			fail()
		}
		cancelationToken.cancel()
		usleep(200_000)
	}

}
