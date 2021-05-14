//
//  UIColorExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 22/10/20.
//

import UIKit

infix operator |: AdditionPrecedence
public extension UIColor {
  /// Easily define two colors for both light and dark mode.
  /// - Parameters:
  ///   - lightMode: The color to use in light mode.
  ///   - darkMode: The color to use in dark mode.
  /// - Returns: A dynamic color that uses both given colors respectively for the given user interface style.
  static func | (lightMode: UIColor, darkMode: UIColor) -> UIColor {
    guard #available(iOS 13.0, *) else { return lightMode }

    return UIColor { (traitCollection) -> UIColor in
      return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
    }
  }
}

public extension UIColor {
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1.0)
  }

  convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
  }

  static var random: UIColor {
    return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
  }
}

public extension UIColor {
  static let customRed = UIColor(red: 230/255, green: 0/255, blue: 20/255, alpha: 1)
}

// MARK: Zeplin
public extension UIColor {

  struct Zeplin {
    public static var black: UIColor {
      return UIColor(r: 51, g: 51, b: 51) | UIColor(r: 255, g: 255, b: 255)
    }

    public static var white: UIColor {
      return UIColor(white: 1.0, alpha: 1.0) | UIColor(r: 51, g: 51, b: 51)
    }

    public static var separator: UIColor {
      return UIColor(white: 232.0 / 255.0, alpha: 1.0)
    }

    // MARK: Red
    public static var colorPrimaryLight: UIColor {
      return UIColor(red: 252.0 / 255.0, green: 13.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    }

    public static var colorPrimaryLightDisabled: UIColor {
      return UIColor(red: 243.0 / 255.0, green: 128.0 / 255.0, blue: 138.0 / 255.0, alpha: 1.0)
    }

    public static var redBranding: UIColor {
      return UIColor(r: 230.0, g: 0.0, b: 20.0) | UIColor(r: 230.0, g: 0.0, b: 20.0, a: 0.85)
    }

    public static var redDark: UIColor {
      return UIColor(red: 171.0 / 255.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }

    public static var redOpaque: UIColor {
      return UIColor(red: 255.0 / 255.0, green: 235.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }

    public static var redNight: UIColor {
      return UIColor(red: 255.0 / 255.0, green: 69.0 / 255.0, blue: 58.0 / 255.0, alpha: 1.0)
    }

    public static var redPale: UIColor {
      return UIColor(red: 255.0 / 255.0, green: 243.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }

    // MARK: Green
    public static var green: UIColor {
      return UIColor(red: 151.0 / 255.0, green: 202.0 / 255.0, blue: 88.0 / 255.0, alpha: 1.0)
    }

    public static var greenLight: UIColor {
      return UIColor(red: 153.0 / 255.0, green: 224.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0)
    }

    public static var greenNight: UIColor {
      return UIColor(red: 50.0 / 255.0, green: 215.0 / 255.0, blue: 75.0 / 255.0, alpha: 1.0)
    }

    public static var greenDone: UIColor {
      return UIColor(red: 102.0 / 255.0, green: 206.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0)
    }

    public static var greenOpaque: UIColor {
      return UIColor(red: 220.0 / 255.0, green: 237.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
    }

    public static var greenDark: UIColor {
      return UIColor(red: 0.0, green: 177.0 / 255.0, blue: 1.0 / 255.0, alpha: 1.0)
    }

    // MARK: Yellow
    public static var yellowBranding: UIColor {
      return UIColor(red: 250.0 / 255.0, green: 215.0 / 255.0, blue: 10.0 / 255.0, alpha: 1.0)
    }

    public static var yellowDark: UIColor {
      return UIColor(red: 229.0 / 255.0, green: 157.0 / 255.0, blue: 14.0 / 255.0, alpha: 1.0)
    }

    public static var yellowLight: UIColor {
      return UIColor(red: 255.0 / 255.0, green: 240.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0)
    }

    public static var yellowNight: UIColor {
      return UIColor(red: 255.0, green: 214.0 / 255.0, blue: 10.0 / 255.0, alpha: 1.0)
    }

    public static var yellowOpaque: UIColor {
      return UIColor(red: 255.0, green: 244.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
    }

    // MARK: Blue
    public static var blueDark: UIColor {
      return UIColor(red: 25.0 / 255.0, green: 160.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
    }

    public static var blueLight: UIColor {
      return UIColor(red: 36.0 / 255.0, green: 203.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }

    public static var blueNight: UIColor {
      return UIColor(red: 100.0 / 255.0, green: 210.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }

    public static var blueOpaque: UIColor {
      return UIColor(red: 225.0 / 255.0, green: 245.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0)
    }

    // MARK: Gray
    public static var grayDisabled: UIColor {
      return UIColor(white: 232.0 / 255.0, alpha: 1.0)
    }

    public static var grayLight: UIColor {
      return UIColor(white: 136.0 / 255.0, alpha: 1.0) | UIColor(r: 204, g: 204, b: 204)
    }

    public static var grayNight: UIColor {
      return UIColor(white: 204.0 / 255.0, alpha: 1.0) | UIColor(white: 136.0 / 255.0, alpha: 1.0)
    }

    public static var grayOpaque: UIColor {
      return UIColor(white: 241.0 / 255.0, alpha: 1.0) | UIColor(r: 28, g: 28, b: 28)
    }

    public static var graySurface: UIColor {
      return UIColor(white: 248.0 / 255.0, alpha: 1.0)
    }
  }
}

// MARK: Enum Zeplin
public enum Zeplin {
  public static var black: UIColor = UIColor.Zeplin.black
  public static var white: UIColor = UIColor.Zeplin.white
  public static var separator: UIColor = UIColor.Zeplin.separator

  // MARK: Red
  public static var colorPrimaryLight: UIColor = UIColor.Zeplin.colorPrimaryLight
  public static var colorPrimaryLightDisabled: UIColor = UIColor.Zeplin.colorPrimaryLightDisabled
  public static var redBranding: UIColor = UIColor.Zeplin.redBranding
  public static var redDark: UIColor = UIColor.Zeplin.redDark
  public static var redOpaque: UIColor = UIColor.Zeplin.redOpaque
  public static var redNight: UIColor = UIColor.Zeplin.redNight
  public static var redPale: UIColor = UIColor.Zeplin.redPale

  // MARK: Green
  public static var green: UIColor = UIColor.Zeplin.green
  public static var greenLight: UIColor = UIColor.Zeplin.greenLight
  public static var greenNight: UIColor = UIColor.Zeplin.greenNight
  public static var greenDone: UIColor = UIColor.Zeplin.greenDone
  public static var greenOpaque: UIColor = UIColor.Zeplin.greenOpaque
  public static var greenDark: UIColor = UIColor.Zeplin.greenDark

  // MARK: Yellow
  public static var yellowBranding: UIColor = UIColor.Zeplin.yellowBranding
  public static var yellowDark: UIColor = UIColor.Zeplin.yellowDark
  public static var yellowLight: UIColor = UIColor.Zeplin.yellowLight
  public static var yellowNight: UIColor = UIColor.Zeplin.yellowNight
  public static var yellowOpaque: UIColor = UIColor.Zeplin.yellowOpaque

  // MARK: Blue
  public static var blueDark: UIColor = UIColor.Zeplin.blueDark
  public static var blueLight: UIColor = UIColor.Zeplin.blueLight
  public static var blueNight: UIColor = UIColor.Zeplin.blueNight
  public static var blueOpaque: UIColor = UIColor.Zeplin.blueOpaque

  // MARK: Gray
  public static var grayDisabled: UIColor = UIColor.Zeplin.grayDisabled
  public static var grayLight: UIColor = UIColor.Zeplin.grayLight
  public static var grayNight: UIColor = UIColor.Zeplin.grayNight
  public static var grayOpaque: UIColor = UIColor.Zeplin.grayOpaque
  public static var graySurface: UIColor = UIColor.Zeplin.graySurface
}

// MARK: Hex
// how to use:
// let white = UIColor(hex: "#ffffff")
public extension UIColor {
  convenience init?(hex: String) {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0

    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 1.0

    let length = hexSanitized.count

    guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

    if length == 6 {
      r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
      g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
      b = CGFloat(rgb & 0x0000FF) / 255.0

    } else if length == 8 {
      r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
      g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
      b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
      a = CGFloat(rgb & 0x000000FF) / 255.0

    } else {
      return nil
    }

    self.init(red: r, green: g, blue: b, alpha: a)
  }
}
