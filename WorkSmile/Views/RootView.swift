import UIKit

final class RootView: UIView {
    
    lazy var mapView: MapView = {
        let mapView = MapView()
        return mapView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RootView {
    
    private func addSubviews() {
        [mapView, tableView].forEach { addSubview($0) }
    }
    
    private func setupLayout() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.heightAnchor.constraint(equalTo: mapView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
