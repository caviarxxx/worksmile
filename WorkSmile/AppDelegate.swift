import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: RootController())

        return true
    }
}
