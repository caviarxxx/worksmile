import UIKit

final class RootController: UIViewController {
    
    private var customView: RootView {
        return view as! RootView
    }
    
    override func loadView() {
        view = RootView()
    }
    
    private let dataProvider = DataProvider()
    private var points: Array<Point>? {
        didSet {
            customView.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
    private func setupView() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    private func fetchData() {
        dataProvider.fetch { [weak self] points, error in
            guard let self = self else { return }
            if let _ = error {
                fatalError()
            } else {
                self.points = points
            }
        }
    }
}

extension RootController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customView.didScroll(scrollView: scrollView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PointCell.reuseIdentifier, for: indexPath) as? PointCell,
              let point = points?[indexPath.row] else {
            return UITableViewCell()
        }

        cell.setup(with: point)
        return cell
    }
}
