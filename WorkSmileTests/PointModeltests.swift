import XCTest
@testable import WorkSmile

class PointModeltests: XCTestCase {

    let dataProvider: DataProvider = DataProvider()

    func test_modelParsedCorrectly() {
        dataProvider.fetch { objects, error in
            XCTAssertEqual(objects?.first?.latitude, "51.893638")
            XCTAssertEqual(objects?.first?.longitude, "19.315773")
            XCTAssertEqual(objects?.first?.accuracy, "9.864261")
            XCTAssertEqual(objects?.first?.distance, "0.000")
            XCTAssertEqual(objects?.first?.timestamp, "0")
            XCTAssertEqual(objects?.first?.altitude, "175.162534")
        }
    }
}
