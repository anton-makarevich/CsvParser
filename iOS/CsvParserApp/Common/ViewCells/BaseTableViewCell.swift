import UIKit

class BaseTableViewCell<TViewModel>: UITableViewCell {
	var viewModel: TViewModel? {
		didSet {
			configure()
		}
	}
	
	func configure() {
		
	}
}
