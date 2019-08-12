import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var startupCoordinator: ProfilesCoordinator?
	private let dependencies = CsvParserAppDependencies()

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let navigationController = UINavigationController()
		
		startupCoordinator = ProfilesCoordinator(
			withViewController: navigationController,
			dependencies: dependencies,
			andParentCoordinator: nil)
		startupCoordinator?.start()
		window = UIWindow()
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		
		return true
	}
}
