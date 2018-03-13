//
//  MondrianView.swift
//  Mondrian
//
//  Created by muukii on 3/11/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import UIKit

public protocol MondrianViewType {

  func layoutSpec() -> LayoutSpec
}

extension MondrianNamespace where Base : UIView & MondrianViewType {

  public func applyLayoutSpec() {
    _ = base.defineLayout(target: base)
  }

  public func invalidateLayoutSpec() {
    // TODO: Optimize
    destroyCurrentLayoutSpec()
    applyLayoutSpec()
  }

  public func relayout(layoutMode: LayoutMode = .currentSize) {

    base.yoga.isEnabled = true

    switch layoutMode {
    case .currentSize:
      base.yoga.applyLayout(
        preservingOrigin: true
      )
    case .flexibleHeight:
      base.yoga.applyLayout(
        preservingOrigin: true,
        dimensionFlexibility: .flexibleHeight
      )
    case .flexibleWidth:
      base.yoga.applyLayout(
        preservingOrigin: true,
        dimensionFlexibility: .flexibleWidth
      )
    }
  }

  private func destroyCurrentLayoutSpec() {

    var nodes: [UIView] = []

    func recursive(root: UIView) {
      for child in root.subviews {
        if child is LayoutNode {
          nodes.append(child)
        }
        recursive(root: child)
      }
    }

    recursive(root: base)

    for node in nodes {
      node.subviews.forEach {
        $0.removeFromSuperview()
      }
      node.yoga.calculateLayout(with: .zero) // To remove child node
      node.removeFromSuperview()
    }

  }

}

open class MondrianView : UIView, MondrianViewType {

  open override func didMoveToSuperview() {
    super.didMoveToSuperview()

    if superview != nil {
      mond.applyLayoutSpec()
    }
  }

  open override func layoutSubviews() {
    super.layoutSubviews()    
  }

  open func layoutSpec() -> LayoutSpec {
    return WrapperLayoutSpec(child: self)
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

open class MondrianCollectionViewCell : UICollectionViewCell, MondrianViewType {
  
  open func layoutSpec() -> LayoutSpec {
    return WrapperLayoutSpec(child: self)
  }
}
