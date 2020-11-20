import Foundation

final class DataProvider: ObjectLoader {
    func fetch(completion: ((Array<Point>?, Error?) -> ())?) {
        let object: Array<Point>? = self.objects(fromFile: "path", ofType: "json")
        completion?(object, nil)
    }
}
