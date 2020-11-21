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

    func test_isValid_distance() {
        dataProvider.fetch { objects, error in
            guard let firstObject = objects?.first else {
                XCTFail()
                return
            }
            XCTAssertTrue(firstObject.isValid)
        }
    }
    
    func test_isNotValid_distance() {
        dataProvider.fetch { objects, error in
            guard let firstObject = objects?.first(where: { Double($0.distance)! > 0.03 }) else {
                XCTFail()
                return
            }
            XCTAssertFalse(firstObject.isValid)
        }
    }
}
