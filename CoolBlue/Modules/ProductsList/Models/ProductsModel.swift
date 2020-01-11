//
//	ProductsModel.swift
//
//	Create by Amr Hossam on 11/1/2020
//	Copyright © 2020 Lifetime Co.. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ProductsModel : Codable {

	let currentPage : Int?
	let pageCount : Int?
	let pageSize : Int?
	let products : [Product]?
	let totalResults : Int?


	enum CodingKeys: String, CodingKey {
		case currentPage = "currentPage"
		case pageCount = "pageCount"
		case pageSize = "pageSize"
		case products = "products"
		case totalResults = "totalResults"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
		pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
		pageSize = try values.decodeIfPresent(Int.self, forKey: .pageSize)
		products = try values.decodeIfPresent([Product].self, forKey: .products)
		totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
	}

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(currentPage, forKey: CodingKeys.currentPage.rawValue)
        aCoder.encode(pageCount, forKey: CodingKeys.pageCount.rawValue)
        aCoder.encode(pageSize, forKey: CodingKeys.pageSize.rawValue)
        aCoder.encode(products, forKey: CodingKeys.products.rawValue)
        aCoder.encode(totalResults, forKey: CodingKeys.totalResults.rawValue)
    }
}
