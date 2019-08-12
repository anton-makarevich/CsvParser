import Nimble
import Quick

@testable import CsvParserApp

class CsvParserServiceSpecs: QuickSpec {
	override func spec() {
		describe("Csv parser Tests") {
			var sut: CsvParserService!
			
			beforeEach(){
				sut = CsvParserService()
			}
			
			it("returns one profile when parsing valid file of one line") {
				let dataToParse = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\""
				
				let profiles = sut.parseProfiles(profilesData: dataToParse)
				
				if (profiles.isEmpty) {
					fail()
					return
				}
				let profile = profiles.first!;
				
				expect(profile.id).to(equal("1"))
				expect(profile.firstName).to(equal("Theo"))
				expect(profile.lastName).to(equal("Jansen"))
				expect(profile.issuesCount).to(equal(5))
				
				let calendar = Calendar.current
				let year = calendar.component(.year, from: profile.birthDay)
				expect(year).to(equal(1978))
			}
			
			it("doesn not returns profile when parsing file with invalid data") {
				let dataToParse = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\",\"Issue count\"\n\"Theo\",\"Jansen\",r,2,\"1978-01-02T00:00:00\""
				
				let profiles = sut.parseProfiles(profilesData: dataToParse)
				
				expect(profiles.isEmpty).to(beTrue())
			}
			
			it("doesn not returns profile when parsing file where issuesCount is nor int") {
				let dataToParse = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\n\"Theo\",\"Jansen\",r,\"1978-01-02T00:00:00\""
				
				let profiles = sut.parseProfiles(profilesData: dataToParse)
				
				expect(profiles.isEmpty).to(beTrue())
			}
			
			it("doesn not returns profile when parsing file where birthdate is in invalid format") {
				let dataToParse = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\n\"Theo\",\"Jansen\",5,\"1978-01-0:00:00\""
				
				let profiles = sut.parseProfiles(profilesData: dataToParse)
				
				expect(profiles.isEmpty).to(beTrue())
			}
			
			it("increases profile id") {
				let dataToParse = "\"First name\",\"Sur name\",\"Issue count\",\"Date of birth\"\n\"Theo\",\"Jansen\",5,\"1978-01-02T00:00:00\"\n\"Fiona\",\"de Vries\",7,\"1950-11-12T00:00:00\""
				
				let profiles = sut.parseProfiles(profilesData: dataToParse)
				
				if (profiles.isEmpty) {
					fail()
					return
				}
				expect(profiles.count).to(equal(2))
				
				let profile1 = profiles[0]
				let profile2 = profiles[1]
				
				expect(profile1.id).to(equal("1"))
				expect(profile2.id).to(equal("2"))
			}
		}
	}
}

