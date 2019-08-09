protocol ViewModelProtocol {
}

extension ViewModelProtocol {
	var identifier: String {
		return "\(type(of: self))"
	}
}
