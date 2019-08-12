import Nimble
import Quick

@testable import CsvParserApp

class ProfilesServiceDependenciesMock: HasCachingService, HasTextFileReaderService, HasCsvParserService {
	var cachingService: CachingServiceProtocol
	
	var textFileReaderService: TextFileReaderServiceProtocol
	
	var csvParserService: CsvParserServiceProtocol
	
	init(
		cachingService: CachingServiceProtocol,
		textFileReaderService: TextFileReaderServiceProtocol,
		csvParserService: CsvParserServiceProtocol) {
		self.cachingService = cachingService
		self.csvParserService = csvParserService
		self.textFileReaderService = textFileReaderService
	}
}

class CachingServiceMock: CachingServiceProtocol {
	private var profilesToReturn: [Profile]?
	private(set) var cacheProfilesCalledTimes: Int = 0
	
	func getCachedProfiles() -> [Profile]? {
		return profilesToReturn
	}
	
	func cacheProfiles(_: [Profile]) {
		cacheProfilesCalledTimes += 1
	}
	
	init(profilesToReturn: [Profile]? = nil){
		self.profilesToReturn = profilesToReturn
	}
}

class TextFileServiceMock: TextFileReaderServiceProtocol {
	private var contentToReturn: String?
	
	func readFileContent(fileName: String) -> String? {
		return contentToReturn
	}
	
	init(contentToReturn: String? = nil){
		self.contentToReturn = contentToReturn
	}
}

class CsvParserMock: CsvParserServiceProtocol {
	private var profilesToReturn: [Profile]
	func parseProfiles(profilesData: String) -> [Profile] {
		return profilesToReturn
	}
	
	init(profilesToReturn: [Profile]){
		self.profilesToReturn = profilesToReturn
	}
}

class ProfilesServiceSpecs: QuickSpec {
	override func spec() {
		describe("Profiles Service Tests") {
			var sut: ProfilesService!
			
			it("returns local cache if present") {
				let profilesDependencies = ProfilesServiceDependenciesMock(
					cachingService: CachingServiceMock(profilesToReturn: [profileStub]),
					textFileReaderService: TextFileServiceMock(),
					csvParserService: CsvParserMock(profilesToReturn: [])
				)
				sut = ProfilesService(dependencies: profilesDependencies)
				var expectedProfiles: [Profile] = []
				sut.getProfiles() { profiles in
					expectedProfiles = profiles
				}
				
				expect(expectedProfiles).toNot(beEmpty())
				expect(expectedProfiles[0].id).to(equal(profileStub.id))
			}
			
			it("returns csv file values if cache is not there") {
				let cacheServiceMock = CachingServiceMock()
				let profilesDependencies = ProfilesServiceDependenciesMock(
					cachingService: cacheServiceMock,
					textFileReaderService: TextFileServiceMock(contentToReturn: "123,123"),
					csvParserService: CsvParserMock(profilesToReturn: [profileStub])
				)
				sut = ProfilesService(dependencies: profilesDependencies)
				var expectedProfiles: [Profile] = []
				sut.getProfiles() { profiles in
					expectedProfiles = profiles
				}
				
				expect(expectedProfiles).toNot(beEmpty())
				expect(expectedProfiles[0].id).to(equal(profileStub.id))
			}
			
			it("returns no profiles if cache is not there and it's not possible to read the file") {
				let cacheServiceMock = CachingServiceMock()
				let profilesDependencies = ProfilesServiceDependenciesMock(
					cachingService: cacheServiceMock,
					textFileReaderService: TextFileServiceMock(),
					csvParserService: CsvParserMock(profilesToReturn: [profileStub])
				)
				sut = ProfilesService(dependencies: profilesDependencies)
				var expectedProfiles: [Profile] = []
				sut.getProfiles() { profiles in
					expectedProfiles = profiles
				}
				
				expect(expectedProfiles).to(beEmpty())
			}
			
			it("saves cache parsed from a csv file") {
				let cacheServiceMock = CachingServiceMock()
				let profilesDependencies = ProfilesServiceDependenciesMock(
					cachingService: cacheServiceMock,
					textFileReaderService: TextFileServiceMock(contentToReturn: "123,123"),
					csvParserService: CsvParserMock(profilesToReturn: [profileStub])
				)
				sut = ProfilesService(dependencies: profilesDependencies)
				sut.getProfiles() { _ in}
					
				expect(cacheServiceMock.cacheProfilesCalledTimes).toNot(be(0))
			}
		}
	}
}
