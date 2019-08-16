import Foundation

final class ProfilesViewModel: ViewModelProtocol {
	typealias Dependencies = HasProfilesService
	
	var dependencies: Dependencies
	var profiles: Observable<[ProfileViewModel]> = Observable([])
	var selectedProfile: Observable<ProfileViewModel?> = Observable(nil)
	var isLoading: Observable<Bool> = Observable(false)
	
	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}
	
	func getProfiles() {
		isLoading.value = true
		DispatchQueue.global(qos: .background).async { [weak self] in
			guard let strongSelf = self else { return }
			strongSelf.dependencies.profilesService.getProfiles { result in
				DispatchQueue.main.async {
					strongSelf.isLoading.value = false
					strongSelf.profiles.value = result.map { ProfileViewModel(profile: $0) }
				}
			}
		}
	}
	
	func selectProfile(profileViewModel: ProfileViewModel) {
		selectedProfile.value = profileViewModel
	}
}
