import Foundation

protocol HasCachingService: class {
	var cachingService: CachingServiceProtocol { get set }
}

protocol CachingServiceProtocol {
	func getCachedProfiles() -> [Profile]?
	func cacheProfiles(_: [Profile])
}

class CachingService: CachingServiceProtocol {
	private let cacheKey = NSString("Issues")
	private let cache = NSCache<NSString,Wrapper<[Profile]>>()
	
	func cacheProfiles(_ profiles: [Profile]) {
		cache.setObject(Wrapper(profiles), forKey: cacheKey)
	}
	
	func getCachedProfiles() -> [Profile]? {
		guard let cached = cache.object(forKey: cacheKey) else {return nil }
		return cached.value
	}
}
