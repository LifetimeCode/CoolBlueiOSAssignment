//
//	ProductsProduct.swift
//
//	Create by Amr Hossam on 11/1/2020
//	Copyright © 2020 Lifetime Co.. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Product : Codable {

	let uSPs : [String]?
	let availabilityState : Int?
	let coolbluesChoiceInformationTitle : String?
	let listPriceExVat : Float?
	let listPriceIncVat : Int?
	let nextDayDelivery : Bool?
	let productId : Int?
	let productImage : String?
	let productName : String?
	let promoIcon : ProductsPromoIcon?
	let reviewInformation : ProductsReviewInformation?
	let salesPriceIncVat : Float?


	enum CodingKeys: String, CodingKey {
		case uSPs = "USPs"
		case availabilityState = "availabilityState"
		case coolbluesChoiceInformationTitle = "coolbluesChoiceInformationTitle"
		case listPriceExVat = "listPriceExVat"
		case listPriceIncVat = "listPriceIncVat"
		case nextDayDelivery = "nextDayDelivery"
		case productId = "productId"
		case productImage = "productImage"
		case productName = "productName"
		case promoIcon
		case reviewInformation
		case salesPriceIncVat = "salesPriceIncVat"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		uSPs = try values.decodeIfPresent([String].self, forKey: .uSPs)
		availabilityState = try values.decodeIfPresent(Int.self, forKey: .availabilityState)
		coolbluesChoiceInformationTitle = try values.decodeIfPresent(String.self, forKey: .coolbluesChoiceInformationTitle)
		listPriceExVat = try values.decodeIfPresent(Float.self, forKey: .listPriceExVat)
		listPriceIncVat = try values.decodeIfPresent(Int.self, forKey: .listPriceIncVat)
		nextDayDelivery = try values.decodeIfPresent(Bool.self, forKey: .nextDayDelivery)
		productId = try values.decodeIfPresent(Int.self, forKey: .productId)
		productImage = try values.decodeIfPresent(String.self, forKey: .productImage)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		promoIcon = try ProductsPromoIcon(from: decoder)
		reviewInformation = try ProductsReviewInformation(from: decoder)
		salesPriceIncVat = try values.decodeIfPresent(Float.self, forKey: .salesPriceIncVat)
	}

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(uSPs, forKey: CodingKeys.uSPs.rawValue)
        aCoder.encode(availabilityState, forKey: CodingKeys.availabilityState.rawValue)
        aCoder.encode(coolbluesChoiceInformationTitle, forKey: CodingKeys.coolbluesChoiceInformationTitle.rawValue)
        aCoder.encode(listPriceExVat, forKey: CodingKeys.listPriceExVat.rawValue)
        aCoder.encode(listPriceIncVat, forKey: CodingKeys.listPriceIncVat.rawValue)
        aCoder.encode(nextDayDelivery, forKey: CodingKeys.nextDayDelivery.rawValue)
        aCoder.encode(productId, forKey: CodingKeys.productId.rawValue)
        aCoder.encode(productImage, forKey: CodingKeys.productImage.rawValue)
        aCoder.encode(productName, forKey: CodingKeys.productName.rawValue)
        aCoder.encode(promoIcon, forKey: CodingKeys.promoIcon.rawValue)
        aCoder.encode(reviewInformation, forKey: CodingKeys.reviewInformation.rawValue)
        aCoder.encode(salesPriceIncVat, forKey: CodingKeys.salesPriceIncVat.rawValue)
    }

}
