import Foundation
import UIKit

final class TableViewDataSource<T>: NSObject, UITableViewDataSource {
	
	private var data: [T]
	private let reuseIdentifier: String
	
	init(data: [T], reuseIdentifier: String) {
		self.data = data
		self.reuseIdentifier = reuseIdentifier
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let viewModel = data[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell()
		
		if let viewCell = cell as? BaseTableViewCell<T> {
			viewCell.viewModel = viewModel
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return ""
	}
	
	func cleanDataSource() {
		data.removeAll()
	}
}
