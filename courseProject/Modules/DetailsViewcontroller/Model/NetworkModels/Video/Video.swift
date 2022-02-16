

import Foundation
struct Video : Codable {
	let iso_639_1 : String?
	let iso_3166_1 : String?
	let name : String?
	let key : String?
	let site : String?
	let size : Int?
	let type : String?
	let official : Bool?
	let published_at : String?
	let id : String?

	enum CodingKeys: String, CodingKey {

		case iso_639_1 = "iso_639_1"
		case iso_3166_1 = "iso_3166_1"
		case name = "name"
		case key = "key"
		case site = "site"
		case size = "size"
		case type = "type"
		case official = "official"
		case published_at = "published_at"
		case id = "id"
	}
}
