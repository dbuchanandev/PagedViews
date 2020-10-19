//
//  VerticalPageView.swift
//
//
//  Created by Donavon Buchanan on 10/19/20.
//

import SwiftUI

@available(watchOS, unavailable)
@available(macOS, unavailable)
public struct VerticalPageView<Content, SelectionValue>: PagingView
where Content: View, SelectionValue: Hashable {
    
    public func position(_ position: PageIndexPosition) -> VerticalPageView<Content, SelectionValue> {
        let newView = Self.init(selection: self.selection, pageIndexPosition: position, scrollDirection: self.scrollDirection) {
            content
        }
        return newView
    }
    
    internal func orientation(_ orientation: PagingOrientation) -> VerticalPageView<Content, SelectionValue> {
        // Only here to satisfy protocol requirement
        return self
    }
    
    public func scrollDirection(_ direction: ScrollDirection) -> VerticalPageView<Content, SelectionValue> {
        let newView = Self.init(selection: self.selection, pageIndexPosition: self.position, scrollDirection: direction) {
            content
        }
        return newView
    }
    

    let position: PageIndexPosition
    let orientation: PagingOrientation = .vertical
    let scrollDirection: ScrollDirection

    var selection: Binding<SelectionValue>?

    let content: Content

    public init(
        selection: Binding<SelectionValue>? = nil,
        pageIndexPosition: PageIndexPosition = .trailing,
        scrollDirection: ScrollDirection = .descending,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        self.position = pageIndexPosition
        self.scrollDirection = scrollDirection
        self.content = content()
    }

    public var body: some View {
        PageView(selection: selection, pageIndexPosition: position, scrollDirection: scrollDirection, orientation: orientation) {
            content
        }
    }
}
