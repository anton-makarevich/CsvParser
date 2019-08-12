import UIKit

class ProfilesViewController: UIViewController, ViewControllerProtocol {
	typealias ViewModelType = ProfilesViewModel
	
	@IBOutlet weak var productsTableView: UITableView!
	
	var viewModel: ProfilesViewModel?
	private var dataSource: TableViewDataSource<ProfileViewModel>?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Issues"
		productsTableView.delegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		bindViewModel()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		unbindViewModel()
	}
	
	func bindViewModel() {
		viewModel?.profiles.bind(listener: { [weak self] in
			guard let strongSelf = self else { return }
			strongSelf.dataSource = TableViewDataSource(
				data: $0,
				reuseIdentifier: R.reuseIdentifier.profileViewCell.identifier)
			strongSelf.productsTableView.dataSource = self!.dataSource
			strongSelf.productsTableView?.reloadData()
		})
		viewModel?.getProfiles()
	}
	
	func unbindViewModel() {
		
	}
	
	static func createWith(_ viewModel: ProfilesViewModel) -> UIViewController? {
		let storyboard = R.storyboard.profiles()
		let viewController = storyboard.instantiateViewController(withIdentifier: classIdentifier)
			as? ProfilesViewController
		viewController?.viewModel = viewModel
		
		return viewController
	}
}

extension ProfilesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let profiles = viewModel?.profiles {
			viewModel?.selectProfile(profileViewModel: profiles.value[indexPath.row])
		}
	}
}
