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
		}
	}
}
