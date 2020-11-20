import XCTest
@testable import WorkSmile

class DataProviderTests: XCTestCase {
    
    let dataProvider: DataProvider = DataProvider()
    
    func test_jsonObjectParsed() {
        dataProvider.fetch { objects, error in
            XCTAssertNotNil(objects != nil)
        }
    }
    
    func test_jsonCountIsValid() {
        dataProvider.fetch { objects, error in
            XCTAssertNotEqual(objects?.count, 0)
        }
        
        dataProvider.fetch { objects, error in
            XCTAssertEqual(objects?.count, 11088)
        }
    }
}
