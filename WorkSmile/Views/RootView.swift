import UIKit

final class RootView: UIScrollView {
    
    private let viewOffset = UIScreen.main.bounds.height / 2

    lazy var mapView: MapView = {
        let mapView = MapView()
        return mapView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PointCell.self, forCellReuseIdentifier: PointCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.contentOffset.y = -viewOffset
        tableView.contentInset.top = viewOffset
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
        
    func didScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        changeAlpha(value: offset)
        applyParalaxEffect(value: -offset)
    }
    
    private func applyParalaxEffect(value: CGFloat) {
        let offset = -(viewOffset - value)
        constraints.first { $0.firstItem is MapView && $0.firstAttribute == .top }?.constant = offset
    }
    
    private func changeAlpha(value: CGFloat) {
        let height = max(frame.size.height, 1.0)
        mapView.alpha = 1.0 - value/height
    }
}

extension RootView {
    
    private func addSubviews() {
        [tableView, mapView].forEach {
            addSubview($0)
        }
    }
    
    private func setupLayout() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
      
        let constraints = [
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: viewOffset),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
