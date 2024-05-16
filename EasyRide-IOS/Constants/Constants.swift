//
//  Constants.swift
//  EasyRide-IOS
//
//  Created by karthik on 4/17/24.
//

import Foundation
import UIKit
import SwiftUI

enum AppColors: String {
    case backGroundColor = "#252D37"
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(red: Double((rgb & 0xFF0000) >> 16) / 255.0,
                  green: Double((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: Double(rgb & 0x0000FF) / 255.0)
    }
}

struct HideNavigationBarLine: ViewModifier {
    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: ""), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage(named: "")
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func backgroundColor(_ color: Color) -> some View {
        self.background(color.edgesIgnoringSafeArea(.all))
    }
    func hideNavigationBarLine() -> some View {
          self.modifier(HideNavigationBarLine())
      }
}



struct CustomAppView<Content: View>: View {
    let content: Content
    let backgroundColor: Color

    init(backgroundColor: Color = .clear, @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }

    var body: some View {
        content.backgroundColor(Color(hex: AppColors.backGroundColor.rawValue) ?? .black).frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
