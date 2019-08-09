protocol HasProfilesService {
	var profilesService: ProfilesServiceProtocol { get set }
}

protocol ProfilesServiceProtocol {
	func getProfiles(completion: @escaping ([Profile]) -> Void)
}

class ProfilesService: ProfilesServiceProtocol {
	func getProfiles(completion: @escaping (([Profile]) -> Void)) {
		completion([])
	}
}
