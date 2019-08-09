protocol HasCsvParserService: class {
	var csvParserService: CsvParserServiceProtocol { get set }
}

protocol CsvParserServiceProtocol {
	func parseProfiles(profilesData: String) -> [Profile]
}

class CsvParserService: CsvParserServiceProtocol {
	func parseProfiles(profilesData: String) -> [Profile] {
		return []
	}
}
