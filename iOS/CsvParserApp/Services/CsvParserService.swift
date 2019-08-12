import Foundation

protocol HasCsvParserService: class {
	var csvParserService: CsvParserServiceProtocol { get set }
}

protocol CsvParserServiceProtocol {
	func parseProfiles(profilesData: String) -> [Profile]
}

class CsvParserService: CsvParserServiceProtocol {
	func parseProfiles(profilesData: String) -> [Profile] {
		var profiles: [Profile] = []
		let lines: [String] = Array(profilesData.components(separatedBy: "\n").dropFirst())
		var id = 1
		for line in lines {
			let components = line.components(separatedBy: ",")
			if components.count != 4 {
				continue
			}
			
			let dateString = removeQuotesFrom(string: components[3]) + "Z"
			
			guard let issueCount = Int(components[2]),
				let birthDate = ISO8601DateFormatter().date(from: dateString) else {continue}
			
			profiles.append( Profile(
				id: String(id),
				firstName: removeQuotesFrom(string: components[0]),
				lastName: removeQuotesFrom(string: components[1]),
				issuesCount: issueCount,
				birthDay: birthDate)
			)
			id += 1
		}
		return profiles
	}
	
	// could be a string extension
	private func removeQuotesFrom(string: String) -> String {
		return string.replacingOccurrences(of: "\"", with: "")
	}
}
