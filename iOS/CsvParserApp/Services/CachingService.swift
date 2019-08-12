import Foundation

protocol HasCachingService: class {
	var cachingService: CachingServiceProtocol { get set }
}

protocol CachingServiceProtocol {
	func getCachedProfiles() -> [Profile]?
	func cacheProfiles(_: [Profile])
}

class CachingService: CachingServiceProtocol {
	private let cacheKey = "Issues"
	private let userDefaults = UserDefaults.standard
	
	func cacheProfiles(_ profiles: [Profile]) {
		if let encoded = try? JSONEncoder().encode(profiles) {
			userDefaults.set(encoded, forKey: cacheKey)
			userDefaults.synchronize()
		}
	}
	
	func getCachedProfiles() -> [Profile]? {
		if let cached = userDefaults.data(forKey: cacheKey),
			let profiles = try? JSONDecoder().decode([Profile].self, from: cached){
			return profiles
		}
		return nil
	}
}
