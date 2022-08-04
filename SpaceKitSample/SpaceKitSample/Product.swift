//
// Copyright © 2022 Dent Reality. All rights reserved.
//

struct Product: Decodable {
	let upc: String
	let name: String
	let icon: String
}

extension Product: Comparable {
	static func < (lhs: Product, rhs: Product) -> Bool {
		lhs.name < rhs.name
	}
	
	static func == (lhs: Product, rhs: Product) -> Bool {
		lhs.upc == rhs.upc
	}
}
