protocol HasTextFileReaderService: class {
	var textFileReaderService: TextFileReaderServiceProtocol { get set }
}

protocol TextFileReaderServiceProtocol {
	func readFileContent(fileName: String) -> String?
}

class BundleReaderService: TextFileReaderServiceProtocol {
	func readFileContent(fileName: String) -> String? {
		return ""
	}
}
