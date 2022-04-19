//
//  ExtensionImageView.swift
//  reciplease
//
//  Created by Dimitry Aumont on 02/03/2022.
//

import Foundation
import UIKit


extension UIImageView{
    func fetchImage(from url: String?) -> UIImage? {
        guard let imageURL = url,
              let url = URL(string: imageURL) else {
            return nil
        }
        do {
            guard let data = try? Data(contentsOf: url) else {
                return nil
            }
            return UIImage(data: data)
        }
    }
}
