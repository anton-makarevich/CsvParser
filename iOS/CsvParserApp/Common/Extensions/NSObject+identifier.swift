import Foundation

extension NSObject {
	class var classIdentifier: String {
		return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
	}
}
