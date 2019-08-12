import Foundation

struct Profile: Codable {
	var id: String
	var firstName: String
	var lastName: String
	var issuesCount: Int
	var birthDay: Date
}
