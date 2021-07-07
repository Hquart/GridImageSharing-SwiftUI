//
//  Extensions.swift
//  Instagrid2
//
//  Created by Naji Achkar on 13/01/2021.
//

import Foundation
import UIKit
import SwiftUI

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// adding custom colors:
extension Color {
    static let appColor = Color("instagridColor")
    static let bordersColor = Color("bordersColor")
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIView {
    // we use this func to create a UIImage from a UIView
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
