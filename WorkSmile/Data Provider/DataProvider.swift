import Foundation

final class PointsDataProvider: ObjectLoader {
    func fetch(completion: ((Array<Point>?, Error?) -> ())?) {
        let object: Array<Point>? = self.objects(fromFile: "path", ofType: "json").validate()
        completion?(object, nil)
    }
}

private extension Array where Element: Point {
    func validate() -> Array<Point> {
        var oldDistance: Double = 0.0
        self.forEach {
            let distance = Double($0.distance)!
            let difference = distance - oldDistance
            if difference < 0.01 {
                $0.isValid = true
            }
            oldDistance = distance
        }
        return self
    }
}
