import UIKit

protocol CoordinatorProtocol: class {
	/// Array of children of current coordinator
	var childCoordinators: [BaseCoordinator] { get }
	
	/// Parent coordinator of current. Should be always present (exception of AppCoordinator).
	/// May serve as delegate for its children
	var parentCoordinator: CoordinatorProtocol? { get }
	
	var rootViewController: UIViewController { get set }
	
	/// Start current coordinator, code to init viewController should go there
	func start()
	
	/// Close child coordinator and remove it from children array
	func stop(chilCoordinator: BaseCoordinator)
	
	/// Reset coordinator state
	func reset()
}
