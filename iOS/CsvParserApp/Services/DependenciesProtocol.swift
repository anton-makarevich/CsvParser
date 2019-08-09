protocol CsvParserAppDependenciesProtocol:
	HasCsvParserService,
	HasCachingService,
	HasProfilesService,
	HasTextFileReaderService {}

class CsvParserAppDependencies: CsvParserAppDependenciesProtocol {
	lazy var csvParserService: CsvParserServiceProtocol = CsvParserService()
	
	lazy var cachingService: CachingServiceProtocol = CachingService()
	
	lazy var profilesService: ProfilesServiceProtocol = ProfilesService(dependencies: self)
	
	lazy var textFileReaderService: TextFileReaderServiceProtocol = BundleReaderService()
}
