//
//  LinkedListNode.swift
//  YLNote
//
//  Created by tangh on 2022/6/6.
//  Copyright © 2022 tangh. All rights reserved.
//

import Foundation
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
}

public class LinkList {
    fileprivate var head: ListNode?
      private var tail: ListNode?

      public var isEmpty: Bool {
        return head == nil
      }

      public var first: ListNode? {
        return head
      }

      public var last: ListNode? {
        return tail
      }
    
    public func append(value: Int) {
      let newNode = ListNode(value)
      if let tailNode = tail {
        tailNode.next = newNode
      } else {
        head = newNode
      }
      tail = newNode
    }

}
