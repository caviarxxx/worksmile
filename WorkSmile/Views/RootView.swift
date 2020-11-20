import UIKit

final class RootView: UIScrollView {
    
    lazy var mapView: MapView = {
        let mapView = MapView()
        return mapView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
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
    
    var inflateOnPullDown = false
    
    func didScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        changeAlpha(value: offset)
        applyParalaxEffect(value: inflateOnPullDown ? -offset : min(-offset, 0.0))
    }
    
    private func applyParalaxEffect(value: CGFloat) {
        constraints.first { $0.firstItem is MapView && $0.firstAttribute == .top }?.constant = value
    }
    
    private func changeAlpha(value: CGFloat) {
        let height = max(frame.size.height, 1.0)
        mapView.alpha = 1.0 - value/height
    }
}

extension RootView {
    
    private func addSubviews() {
        [mapView, tableView].forEach {
            addSubview($0)
        }
    }
    
    private func setupLayout() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 300),
            
            tableView.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension RootView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll(scrollView: scrollView)
    }
}

extension RootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
