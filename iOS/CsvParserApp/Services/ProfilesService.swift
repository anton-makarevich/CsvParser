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
		dependencies.cachingService.getCachedProfiles() { [weak self] cachedProfiles in
			if let cachedProfiles = cachedProfiles {
				completion(cachedProfiles)
				return
			} else {
				guard let self = self,
					let fileContent = self.dependencies.textFileReaderService.readFileContent(fileName: "") else {
						completion([])
						return
					}
				let profiles = self.dependencies.csvParserService.parseProfiles(profilesData: fileContent)
				self.dependencies.cachingService.cacheProfiles(profiles)
				completion(profiles)
			}
		}
	}
}
