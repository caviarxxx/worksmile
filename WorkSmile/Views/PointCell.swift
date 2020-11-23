import UIKit

final class PointCell: UITableViewCell {
    
    static let reuseIdentifier = "PointCell"
    
    func setup(with point: Point) {
        textLabel?.text = String(format: "%@, %@", point.latitude, point.longitude)
        backgroundColor = point.isValid ? .white : .red
    }
}
