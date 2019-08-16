protocol HasProfilesService {
	var profilesService: ProfilesServiceProtocol { get set }
}

protocol ProfilesServiceProtocol {
	func getProfiles(completion: @escaping ([Profile]) -> Void)
}

class ProfilesService: ProfilesServiceProtocol {
	typealias Dependencies = HasCachingService
		& HasCsvParserService
		& HasTextFileReaderService
	unowned var dependencies: Dependencies
	
	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}
}

extension ProfilesService {
	func getProfiles(completion: @escaping (([Profile]) -> Void)) {
		
		if let cachedProfiles = dependencies.cachingService.getCachedProfiles() {
			completion(cachedProfiles)
			return
		} else {
			guard let fileContent = self.dependencies.textFileReaderService.readFileContent(fileName: "issues") else {
					completion([])
					return
				}
			let profiles = self.dependencies.csvParserService.parseProfiles(profilesData: fileContent)
			self.dependencies.cachingService.cacheProfiles(profiles)
			completion(profiles)
		}
	}
}
