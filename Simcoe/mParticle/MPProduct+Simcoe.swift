//
//  MPProduct+Simcoe.swift
//  Simcoe
//
//  Created by Michael Campbell on 10/25/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import mParticle_Apple_SDK

extension MPProduct {

    /// A convenience initializer.
    ///
    /// - Parameter product: A SimcoeProductConvertible instance.
    internal convenience init(product: SimcoeProductConvertible) {
        let simcoeProduct = product.toSimcoeProduct()
        self.init(name: simcoeProduct.productName,
                  // INTENTIONAL: In MPProduct: SKU of a product. This is the product id
                  sku: simcoeProduct.productId,
                  quantity: NSNumber(value: simcoeProduct.quantity),
                  price: NSNumber(value: simcoeProduct.price ?? 0))

        guard let properties = simcoeProduct.properties else {
            return
        }

        if let brand = properties[MPProductKeys.brand.rawValue] as? String {
            self.brand = brand
        }

        if let category = properties[MPProductKeys.category.rawValue] as? String {
            self.category = category
        }

        if let couponCode = properties[MPProductKeys.couponCode.rawValue] as? String {
            self.couponCode = couponCode
        }

        if let sku = properties[MPProductKeys.sku.rawValue] as? String {
            // INTENTIONAL: In MPProduct: The variant of the product
            self.variant = sku
        }

        if let position = properties[MPProductKeys.position.rawValue] as? UInt {
            self.position = position
        }
        
        let remaining = MPProductKeys.remaining(properties: properties)
        
        for (key, value) in remaining {
            if let value = value as? String {
                self[key] = value
            }
        }
    }
    
}
