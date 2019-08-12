import Nimble
import Quick

@testable import CsvParserApp

let profileStub = Profile(
	id: "1",
	firstName: "Anton",
	lastName: "Makarevich",
	issuesCount: 5,
	birthDay: Date()
)

class ProfilesServiceMock: ProfilesServiceProtocol {
	func getProfiles(completion: @escaping ([Profile]) -> Void) {
		completion([profileStub])
	}
}


class ProfilesViewModelDependenciesMock: HasProfilesService {
	var profilesService: ProfilesServiceProtocol = ProfilesServiceMock()
}

class ProfilesViewModelSpecs: QuickSpec {
	override func spec() {
		describe("Profiles ViewModel Tests") {
			var sut: ProfilesViewModel!
			
			beforeEach(){
				sut = ProfilesViewModel(dependencies: ProfilesViewModelDependenciesMock())
			}
			
			it("gets profiles using profiles service") {
				var assignedProfiles: [ProfileViewModel] = []
				sut.profiles.bind(listener: {
					assignedProfiles = $0
				})

				sut.getProfiles()

				expect(assignedProfiles).toNot(beEmpty())
				expect(assignedProfiles[0].profile.id).to(equal(profileStub.id))
			}

			it("selects product") {
				var selectedProfile: ProfileViewModel?
				sut.selectedProfile.bind(listener: {
					selectedProfile = $0
				})

				let profileToSelect = ProfileViewModel(profile: profileStub)

				sut.selectProfile(profileViewModel: profileToSelect)

				expect(selectedProfile).to(be(profileToSelect))
			}
		}
	}
}
