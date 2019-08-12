import Nimble
import Quick

@testable import CsvParserApp

class ProfileViewModelSpecs: QuickSpec {
	override func spec() {
		describe("Profile ViewModel Tests") {
			var sut: ProfileViewModel!
		
			beforeEach(){
				sut = ProfileViewModel(profile: profileStub)
			}
			
			it("returns correct name value") {
				let expectedName = "\(profileStub.firstName) \(profileStub.lastName)"
				expect(sut.name).to(equal(expectedName))
			}
			
			it("returns plural form (issues) if issueCount is more than 1") {
				let expectedIssyesText = "5 issues"
				expect(sut.issues).to(equal(expectedIssyesText))
			}
			
			it("returns single form (issue) if issueCount is equal to 1") {
				let profileWithSingleIssue = Profile(id: "1", firstName: "F", lastName: "S", issuesCount: 1, birthDay: Date())
				sut = ProfileViewModel(profile: profileWithSingleIssue)
				
				let expectedIssyesText = "1 issue"
				expect(sut.issues).to(equal(expectedIssyesText))
			}
			
			it("returns plural form (issues) if issueCount is equal to 0") {
				let profileWithSingleIssue = Profile(id: "1", firstName: "F", lastName: "S", issuesCount: 0, birthDay: Date())
				sut = ProfileViewModel(profile: profileWithSingleIssue)
				
				let expectedIssyesText = "0 issues"
				expect(sut.issues).to(equal(expectedIssyesText))
			}
		}
	}
}
