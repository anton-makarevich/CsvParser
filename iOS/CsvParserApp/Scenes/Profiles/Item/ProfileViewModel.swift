import UIKit

class ProfileViewModel: ViewModelProtocol {
	
	private(set) var profile: Profile
	
	init(profile: Profile) {
		self.profile = profile
	}
	
	var name: String {
		return "\(self.profile.firstName) \(self.profile.lastName)"
	}
	
	var issues: String {
		let issueText = self.profile.issuesCount == 1 ? "issue": "issues"
		return "\(self.profile.issuesCount) \(issueText)"
	}
}
