protocol HasCsvParserService {
	var csvParserService: CsvParserServiceProtocol { get set }
}

protocol CsvParserServiceProtocol {
	func parseProfiles(profilesData: String, completion: @escaping ([Profile])->Void)
}

class CsvParserService: CsvParserServiceProtocol {
	func parseProfiles(profilesData: String, completion: @escaping ([Profile]) -> Void) {
		completion([])
	}
}
