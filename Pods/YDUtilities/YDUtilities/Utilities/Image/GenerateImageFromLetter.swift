//
//  GenerateImageFromLetter.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 14/01/21.
//

import UIKit

public class GenerateImageFromLetter: NSObject {

  public class func withName(
    _ name: String,
    backgroundColor: UIColor,
    textColor: UIColor,
    textFont: UIFont
  ) -> UIImage? {

    let frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    let nameLabel = UILabel(frame: frame)

    nameLabel.textAlignment = .center
    nameLabel.backgroundColor = backgroundColor
    nameLabel.textColor = textColor
    nameLabel.font = textFont

    var initials = ""

    let initialsArray = name.components(separatedBy: " ")

    if let firstWord = initialsArray.first {
      if let firstLetter = firstWord.first {
        initials += String(firstLetter).capitalized
      }
    }

    if initialsArray.count > 1,
       let lastWord = initialsArray.last {
      if let lastLetter = lastWord.first {
        initials += String(lastLetter).capitalized
      }
    }

    nameLabel.text = initials
    UIGraphicsBeginImageContext(frame.size)

    if let currentContext = UIGraphicsGetCurrentContext() {
      nameLabel.layer.render(in: currentContext)
      let nameImage = UIGraphicsGetImageFromCurrentImageContext()
      return nameImage
    }

    return nil
  }
}
