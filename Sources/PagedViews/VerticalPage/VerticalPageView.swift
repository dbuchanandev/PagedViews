//
//  VerticalPageView.swift
//
//
//  Created by Donavon Buchanan on 10/19/20.
//

import SwiftUI

@available(watchOS, unavailable)
@available(macOS, unavailable)
public struct VerticalPageView<Content, SelectionValue>: Pageable
where Content: View, SelectionValue: Hashable {

    public func indexDisplayMode(_ indexDisplayMode: IndexDisplayMode) -> VerticalPageView<
        Content, SelectionValue
    > {
        let newView = Self.init(
            selection: self.selection,
            pageIndexPosition: self.position,
            indexDisplayMode: indexDisplayMode,
            scrollDirection: self.scrollDirection,
            orientation: self.orientation
        ) {
            content
        }
        return newView
    }

    public func pagingPosition(_ position: PageIndexPosition) -> VerticalPageView<
        Content, SelectionValue
    > {
        let newView = Self.init(
            selection: self.selection,
            pageIndexPosition: position,
            scrollDirection: self.scrollDirection,
            orientation: self.orientation
        ) {
            content
        }
        return newView
    }

    public func pagingOrientation(_ orientation: PagingOrientation) -> VerticalPageView<
        Content, SelectionValue
    > {
        let newView = Self.init(
            selection: self.selection,
            pageIndexPosition: self.position,
            scrollDirection: self.scrollDirection,
            orientation: orientation
        ) {
            content
        }
        return newView
    }

    public func scrollDirection(_ direction: ScrollDirection) -> VerticalPageView<
        Content, SelectionValue
    > {
        let newView = Self.init(
            selection: self.selection,
            pageIndexPosition: self.position,
            scrollDirection: direction,
            orientation: self.orientation
        ) {
            content
        }
        return newView
    }

    let indexDisplayMode: IndexDisplayMode

    let position: PageIndexPosition
    let orientation: PagingOrientation

    let scrollDirection: ScrollDirection

    var selection: Binding<SelectionValue>?

    let content: Content

    public init(
        selection: Binding<SelectionValue>,
        pageIndexPosition: PageIndexPosition = .trailing,
        indexDisplayMode: IndexDisplayMode = .always,
        scrollDirection: ScrollDirection = .descending,
        scrollingEnabled: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        self.position = pageIndexPosition
        self.scrollDirection = scrollDirection
        self.orientation = .vertical
        self.indexDisplayMode = indexDisplayMode
        self.content = content()
    }

    private init(
        selection: Binding<SelectionValue>? = nil,
        pageIndexPosition: PageIndexPosition = .trailing,
        indexDisplayMode: IndexDisplayMode = .always,
        scrollDirection: ScrollDirection = .descending,
        scrollingEnabled: Bool = true,
        orientation: PagingOrientation = .vertical,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        self.position = pageIndexPosition
        self.indexDisplayMode = indexDisplayMode
        self.scrollDirection = scrollDirection
        self.orientation = orientation
        self.content = content()
    }

    public var body: some View {
        PageView(
            selection: selection,
            pageIndexPosition: position,
            scrollDirection: scrollDirection,
            orientation: orientation
        ) {
            content
        }
    }
}
