//
//  LayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

public protocol LayoutSpec : LayoutElement {

}

protocol LayoutSpecInternal : LayoutSpec {
  var view: LayoutNode { get }
}

extension LayoutSpecInternal {

  public var style: LayoutElementStyle {
    get {
      return view.style
    }
    set {
      view.style = newValue
    }
  }
}
