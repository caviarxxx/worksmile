import UIKit

final class RootController: UIViewController {
    
    private var customView: RootView {
        return view as! RootView
    }
    
    override func loadView() {
        view = RootView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
