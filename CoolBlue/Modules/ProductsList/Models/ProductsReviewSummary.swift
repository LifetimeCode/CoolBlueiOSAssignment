//
//	ProductsReviewSummary.swift
//
//	Create by Amr Hossam on 11/1/2020
//	Copyright © 2020 Lifetime Co.. All rights reserved.

import Foundation

struct ProductsReviewSummary : Codable {

	let reviewAverage : Float?
	let reviewCount : Int?

	enum CodingKeys: String, CodingKey {
		case reviewAverage = "reviewAverage"
		case reviewCount = "reviewCount"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		reviewAverage = try values.decodeIfPresent(Float.self, forKey: .reviewAverage)
		reviewCount = try values.decodeIfPresent(Int.self, forKey: .reviewCount)
	}

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(reviewAverage, forKey: CodingKeys.reviewAverage.rawValue)
        aCoder.encode(reviewCount, forKey: CodingKeys.reviewCount.rawValue)
    }

}
