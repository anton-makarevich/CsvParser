import UIKit

class ProfileViewController: UIViewController, ViewControllerProtocol {
	typealias ViewModelType = ProfileViewModel
	
	var viewModel: ProfileViewModel?
	
	@IBOutlet weak var nameLabel: UILabel!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		bindViewModel()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		unbindViewModel()
	}
	
	func bindViewModel() {
		nameLabel.text = viewModel?.name
		title = viewModel?.name
	}
	
	func unbindViewModel() {
		
	}
	
	static func createWith(_ viewModel: ProfileViewModel) -> UIViewController? {
		let storyboard = R.storyboard.profiles()
		let viewController = storyboard.instantiateViewController(withIdentifier: classIdentifier)
			as? ProfileViewController
		viewController?.viewModel = viewModel
		
		return viewController
	}
}
