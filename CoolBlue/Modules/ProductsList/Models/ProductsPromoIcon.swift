//
//	ProductsPromoIcon.swift
//
//	Create by Amr Hossam on 11/1/2020
//	Copyright © 2020 Lifetime Co.. All rights reserved.

import Foundation

struct ProductsPromoIcon : Codable {

	let text : String?
	let type : String?

	enum CodingKeys: String, CodingKey {
		case text = "text"
		case type = "type"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: CodingKeys.text.rawValue)
        aCoder.encode(type, forKey: CodingKeys.type.rawValue)
    }

}
