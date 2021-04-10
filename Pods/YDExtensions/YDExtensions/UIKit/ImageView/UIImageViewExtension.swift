//
//  UIImageViewExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 13/11/20.
//

import UIKit
import Kingfisher
import KingfisherWebP

public extension UIImageView {
  func setImage(_ imageStringOpt: String?, placeholder: UIImage? = nil) {
    guard let imageString = imageStringOpt,
          let escapedString = imageString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
    else {
      image = placeholder
      return
    }

    kf.setImage(
      with: URL(string: escapedString),
      placeholder: placeholder,
      options: [
        .progressiveJPEG(ImageProgressive(isBlur: false, isFastestScan: false, scanInterval: 0.1)),
        .processor(WebPProcessor.default)
      ],
      completionHandler: { [weak self] result in
        guard let self = self else { return }

        if case .success(let imageSuccess) = result {
          let ratio = imageSuccess.image.size.width / imageSuccess.image.size.height

          if self.frame.width > self.frame.height {
            let newHeight = self.frame.width / ratio
            self.frame.size = CGSize(width: self.frame.width, height: newHeight)

          } else {
            let newWidth = self.frame.height * ratio
            self.frame.size = CGSize(width: newWidth, height: self.frame.height)
          }
        }
        //
      }
    )
  }
}
