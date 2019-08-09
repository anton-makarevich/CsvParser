import UIKit

protocol ViewControllerProtocol {
	associatedtype ViewModelType: ViewModelProtocol
	
	var viewModel: ViewModelType? { get }
	
	func bindViewModel()
	func unbindViewModel()
	
	static func createWith(_ viewModel: ViewModelType) -> UIViewController?
}
