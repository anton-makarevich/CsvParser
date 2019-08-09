import UIKit

class ProfileViewCell: BaseTableViewCell<ProfileViewModel> {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	
	override func configure() {
		guard let viewModel = viewModel else { return }
		
		nameLabel.text = viewModel.name
	}
}
