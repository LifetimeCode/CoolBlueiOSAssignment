//
//  ProductsCell.swift
//  CoolBlue
//
//  Created by Amr Hossam on 1/11/20.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import UIKit
import Kingfisher

let ProductCellName = "ProductsCell"
let ProductCellID = "CellID"

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var priceNoVATLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    func configure(with product: Product) {
        titleLbl.text = product.productName
        priceLbl.text = "\(product.salesPriceIncVat ?? 0.00) Eur"
        priceNoVATLbl.text = ""
        imgView.kf.setImage(with: URL(string: product.productImage ?? ""))
    }
}
