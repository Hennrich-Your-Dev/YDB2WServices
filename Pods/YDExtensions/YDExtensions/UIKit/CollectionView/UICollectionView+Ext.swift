//
//  UICollectionView+Ext.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 07/06/21.
//

import UIKit

public extension UICollectionView {
  func register<T: UICollectionViewCell>(_: T.Type) {
    register(T.self, forCellWithReuseIdentifier: T.identifier)
  }

  func dequeueReusableCell<T: UICollectionViewCell>(
    forIndexPath indexPath: IndexPath
  ) -> T {
    guard let cell = dequeueReusableCell(
      withReuseIdentifier: T.identifier,
      for: indexPath
    ) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.identifier)")
    }

    return cell
  }
}
