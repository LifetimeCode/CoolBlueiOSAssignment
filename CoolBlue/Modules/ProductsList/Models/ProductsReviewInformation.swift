//
//	ProductsReviewInformation.swift
//
//	Create by Amr Hossam on 11/1/2020
//	Copyright © 2020 Lifetime Co.. All rights reserved.

import Foundation

struct ProductsReviewInformation : Codable {

	let reviewSummary : ProductsReviewSummary?
	let reviews : [String]?

	enum CodingKeys: String, CodingKey {
		case reviewSummary
		case reviews = "reviews"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		reviewSummary = try ProductsReviewSummary(from: decoder)
		reviews = try values.decodeIfPresent([String].self, forKey: .reviews)
	}

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(reviewSummary, forKey: CodingKeys.reviewSummary.rawValue)
        aCoder.encode(reviews, forKey: CodingKeys.reviews.rawValue)
    }

}
