import UIKit

class ProfileViewController: UIViewController, ViewControllerProtocol {
	typealias ViewModelType = ProfileViewModel
	
	var viewModel: ProfileViewModel?
	
	@IBOutlet weak var issuesLabel: UILabel!
	@IBOutlet weak var birthdayLabel: UILabel!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		bindViewModel()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		unbindViewModel()
	}
	
	func bindViewModel() {
		title = viewModel?.name
		issuesLabel.text = viewModel?.issues
		birthdayLabel.text = viewModel?.birthday
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
