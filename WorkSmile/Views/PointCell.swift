import UIKit

final class PointCell: UITableViewCell {
    
    static let reuseIdentifier = "PointCell"
    
    func setup(with point: Point) {
        textLabel?.text = String(format: "%@, %@", point.latitude, point.longitude)
        backgroundColor = point.isValid ? .white : .red
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
