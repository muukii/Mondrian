//
//  LayoutElement.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

public protocol LayoutElement {

//  var style: LayoutElementStyle { get }

  func layout(target: Node) -> Node

}

public protocol LayoutView {

  func layoutSpec() -> LayoutSpec
}
