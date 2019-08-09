protocol HasCachingService {
	var cachingService: CachingServiceProtocol { get set }
}

protocol CachingServiceProtocol {
	func getCachedProfiles(completion: @escaping ([Profile]) -> Void)
}

class CachingService: CachingServiceProtocol {
	func getCachedProfiles(completion: @escaping (([Profile]) -> Void)) {
		completion([])
	}
}
