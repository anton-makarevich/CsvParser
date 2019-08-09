protocol HasTextFileReaderService {
	var textFileReaderService: TextFileReaderServiceProtocol { get set }
}

protocol TextFileReaderServiceProtocol {
	func readFileContent(fileName: String, completion: @escaping (String) -> Void)
}

class BundleReaderService: TextFileReaderServiceProtocol {
	func readFileContent(fileName: String, completion: @escaping (String) -> Void) {
		completion("")
	}
}
