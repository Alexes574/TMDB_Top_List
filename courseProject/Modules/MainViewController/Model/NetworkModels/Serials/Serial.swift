import Foundation
struct Serial : Codable {
	let id : Int?
	let original_name : String?
	let origin_country : [String]?
	let first_air_date : String?
	let vote_count : Int?
	let vote_average : Double?
	let poster_path : String?
	let backdrop_path : String?
	let overview : String?
	let name : String?
	let genre_ids : [Int]?
	let original_language : String?
	let popularity : Double?
	let media_type : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case original_name = "original_name"
		case origin_country = "origin_country"
		case first_air_date = "first_air_date"
		case vote_count = "vote_count"
		case vote_average = "vote_average"
		case poster_path = "poster_path"
		case backdrop_path = "backdrop_path"
		case overview = "overview"
		case name = "name"
		case genre_ids = "genre_ids"
		case original_language = "original_language"
		case popularity = "popularity"
		case media_type = "media_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		original_name = try values.decodeIfPresent(String.self, forKey: .original_name)
		origin_country = try values.decodeIfPresent([String].self, forKey: .origin_country)
		first_air_date = try values.decodeIfPresent(String.self, forKey: .first_air_date)
		vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
		vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
		poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
		backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
		original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
		media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
	}

}
