import UIKit

final class RootController: UIViewController {
    
    private var customView: RootView {
        return view as! RootView
    }
    
    override func loadView() {
        view = RootView()
    }
    
    private let dataProvider = DataProvider()
    private var points: Array<Point> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        fetchData()
    }
    
    private func setupView() {
        title = "Worksmile"
        
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        let routeButton = UIBarButtonItem(title: "Show route", style: .done, target: self, action: #selector(showRoute))
        navigationItem.rightBarButtonItem = routeButton
    }
        
    private func fetchData() {
        dataProvider.fetch { [weak self] points, error in
            guard let self = self else { return }
            guard error == nil, let points = points else { fatalError() }

            self.points = points
        }
    }
    
    @objc private func showRoute() {
        customView.mapView.createPolyline(from: points)
    }
}

extension RootController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customView.didScroll(scrollView: scrollView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PointCell.reuseIdentifier, for: indexPath) as! PointCell
        let point = points[indexPath.row]
        cell.setup(with: point)
        return cell
    }
}
