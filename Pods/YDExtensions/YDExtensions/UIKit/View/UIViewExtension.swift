//
//  UIViewExtension.swift
//  YDExtensions
//
//  Created by Douglas Hennrich on 22/10/20.
//
// swiftlint:disable force_unwrapping force_cast
import UIKit

public extension UIView {

  class var identifier: String {
    return String(describing: self)
  }

  func loadNib() -> UIView {
    let bundle = Bundle.init(for: type(of: self))
    let nibName = Self.description().components(separatedBy: ".").last!
    let nib = UINib(nibName: nibName, bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil).first as! UIView
  }

  class func loadFromNibNamed(
    _ nibNamed: String,
    _ bundle: Bundle? = Bundle.main
  ) -> UINib {
    return UINib(nibName: nibNamed, bundle: bundle)
  }

  class func loadNib(_ bundle: Bundle? = Bundle.main) -> UINib {
    return loadFromNibNamed(self.identifier, bundle)
  }

  class func loadFromNib(bundle: Bundle? = Bundle.main) -> UIView? {
    return loadFromNibNamed(self.identifier, bundle).instantiate(
      withOwner: nil,
      options: nil
    )[0] as? UIView
  }
}

public extension UIView {

  // MARK: Loading
  func startLoader(message: String? = nil) {
    let viewLoading = UIView(frame: self.frame)
    viewLoading.tag = 99999
    viewLoading.backgroundColor = .white
    viewLoading.center = self.center

    // Activity Indicator
    let loader = UIActivityIndicatorView(style: .whiteLarge)
    loader.startAnimating()
    loader.center = viewLoading.center
    loader.color = UIColor.customRed
    viewLoading.addSubview(loader)

    self.addSubview(viewLoading)
    self.bringSubviewToFront(viewLoading)
  }

  func stopLoader() {
    self.subviews.forEach { view in
      if view.tag == 99999 {
        view.removeFromSuperview()
      }
    }
  }

  // MARK: Corner round
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(
      roundedRect: bounds,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
}

// NSConstraint
public extension UIView {
  // Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
  // Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
  func bindFrame(
    top: CGFloat = 0,
    bottom: CGFloat = 0,
    leading: CGFloat = 0,
    trailing: CGFloat = 0,
    toView view: UIView
  ) {
    translatesAutoresizingMaskIntoConstraints = false
    topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
    bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
    leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
    trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
  }

  func bindFrameToSuperview(
    top: CGFloat = 0,
    bottom: CGFloat = 0,
    leading: CGFloat = 0,
    trailing: CGFloat = 0
  ) {
    guard let superview = superview else {
      print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperview()` to fix this.")
      return
    }
    
    translatesAutoresizingMaskIntoConstraints = false
    topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
    bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom).isActive = true
    leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
    trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing).isActive = true
  }
}

// MARK: Shimmer
public extension UIView {
  func startShimmer(
    colorOne: UIColor = UIColor.Zeplin.graySurface,
    colorTwo: UIColor = UIColor.Zeplin.grayOpaque,
    speed: Double = 1,
    delay: Double = 0
  ) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.bounds
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorOne.cgColor]
    gradientLayer.locations = [0.0, 0.5, 1.0]
    gradientLayer.name = "shimmerAnimation"

    let animation = CABasicAnimation(keyPath: "locations")
    animation.fromValue = [-1.0, -0.5, 0.0]
    animation.toValue = [1.0, 1.5, 2.0]
    animation.repeatCount = .infinity
    animation.duration = speed
    animation.beginTime = CFTimeInterval() + delay

    gradientLayer.add(animation, forKey: "shimmerAnimation")
    layer.addSublayer(gradientLayer)
  }

  func stopShimmer() {
    layer.removeAnimation(forKey: "shimmerAnimation")
    layer.sublayers?.first(where: { $0.name == "shimmerAnimation" })?.removeFromSuperlayer()
  }
}
