protocol HasCachingService: class {
	var cachingService: CachingServiceProtocol { get set }
}

protocol CachingServiceProtocol {
	func getCachedProfiles(completion: @escaping ([Profile]?) -> Void)
	func cacheProfiles(_: [Profile])
}

class CachingService: CachingServiceProtocol {
	func cacheProfiles(_: [Profile]) {
		
	}
	
	func getCachedProfiles(completion: @escaping (([Profile]?) -> Void)) {
		completion([])
	}
}
