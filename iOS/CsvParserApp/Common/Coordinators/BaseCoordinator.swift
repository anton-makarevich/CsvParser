import Foundation
import UIKit

/// Base coordinator class, shouldn't be initialized directly

class BaseCoordinator: NSObject, CoordinatorProtocol {
	typealias Dependencies = CsvParserAppDependenciesProtocol
	
	weak var dependencies: Dependencies?
	
	var childCoordinators: [BaseCoordinator] = []
	
	var parentCoordinator: CoordinatorProtocol?
	
	var rootViewController: UIViewController
	
	var loadingView: UIActivityIndicatorView
	
	init(
		withViewController viewController: UIViewController,
		dependencies: Dependencies?,
		andParentCoordinator parentCoordinator: CoordinatorProtocol? = nil) {
		rootViewController = viewController
		self.parentCoordinator = parentCoordinator
		self.dependencies = dependencies
		
		loadingView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
	}
	
	func start() {}
	
	func stop(chilCoordinator: BaseCoordinator) {}
	
	func reset() {}
	
	func toggleLoadingAnimation(isAnimating: Bool, viewController: UIViewController? = nil) {
		let vc: UIViewController = viewController ?? rootViewController		
		loadingView.center = vc.view.center
		if isAnimating {
			vc.view.addSubview(loadingView)
			loadingView.startAnimating()
		} else {
			loadingView.stopAnimating()
			loadingView.removeFromSuperview()
		}
	}
}
