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
        var allObjects = 0
        var validObjects = 0
        var notValidObjects = 0
        
        dataProvider.fetch { objects, error in
            
            var oldDistance: Double = 0.0
            objects?.forEach {

                allObjects += 1

                let distance = Double($0.distance)!
                let difference = distance - oldDistance
                if difference < 0.01 {
                    validObjects += 1
                    $0.isValid = true
                } else {
                    notValidObjects += 1
                }
                oldDistance = distance
            }
        
            XCTAssertEqual(allObjects, 11088)
            XCTAssertEqual(validObjects, 11085)
            XCTAssertEqual(notValidObjects, 3)
        }
    }
}
