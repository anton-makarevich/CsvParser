import UIKit

final class ProfilesCoordinator: BaseCoordinator {
	override func start() {
		guard let navigationController = rootViewController as? UINavigationController,
			let dependencies = self.dependencies else {
				return
		}
		
		let viewModel = ProfilesViewModel(dependencies: dependencies)
		
		viewModel.selectedProfile.bind(listener: { [weak self] product in
			self?.openProfileDetails(product)
		})
		
		viewModel.isLoading.bind(listener: {[weak self] isAnimating in
			self?.toggleLoadingAnimation(isAnimating: isAnimating)
		})
		
		guard let viewController = ProfilesViewController.createWith(viewModel) else {
			return
		}
		
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func openProfileDetails(_ viewModel: ProfileViewModel?) {
		guard let viewModel = viewModel,
			let navigationController = rootViewController as? UINavigationController,
			let viewController = ProfileViewController.createWith(viewModel) else {
			return
		}
		
		navigationController.pushViewController(viewController, animated: true)
	}
}
