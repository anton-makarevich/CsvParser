import Foundation

protocol HasTextFileReaderService: class {
	var textFileReaderService: TextFileReaderServiceProtocol { get set }
}

protocol TextFileReaderServiceProtocol {
	func readFileContent(fileName: String) -> String?
}

class BundleReaderService: TextFileReaderServiceProtocol {
	func readFileContent(fileName: String) -> String? {
		if let filepath = Bundle.main.path(forResource: fileName, ofType: "csv") {
			do {
				let contents = try String(contentsOfFile: filepath)
				return contents
			} catch {
				return nil
			}
		} else {
			return nil
		}
	}
}
