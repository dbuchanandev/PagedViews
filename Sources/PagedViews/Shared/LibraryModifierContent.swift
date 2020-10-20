//
//  LibraryModifierContent.swift
//
//
//  Created by Donavon Buchanan on 10/19/20.
//

import DeveloperToolsSupport
import SwiftUI

@available(watchOS, unavailable)
@available(macOS, unavailable)
public struct LibraryModifierContent: LibraryContentProvider {
    // MARK: Public

    @LibraryContentBuilder
    public func modifiers(base: PagingLibraryContent) -> [LibraryItem] {
        LibraryItem(
            base.pagingOrientation(orientation),
            visible: true,
            title: "Paging Orientation",
            category: .layout
        )

        LibraryItem(
            base.pagingPosition(position),
            visible: true,
            title: "Paging Position",
            category: .layout
        )

        LibraryItem(
            base.scrollDirection(scrollDirection),
            visible: true,
            title: "Scroll Direction",
            category: .layout
        )
    }

    @LibraryContentBuilder
    public var views: [LibraryItem] {
        LibraryItem(
            PageView {
                Text("One")
                Text("Two")
                Text("Three")
                Text("Four")
                Text("Five")
                Text("Six")
            },
            visible: true,
            category: .control
        )

        LibraryItem(
            VerticalPageView {
                Text("One")
                Text("Two")
                Text("Three")
                Text("Four")
                Text("Five")
                Text("Six")
            },
            visible: true,
            category: .control
        )
    }

    // MARK: Internal

    private let position: PageIndexPosition = .trailing
    private let orientation: PagingOrientation = .horizontal
    private let scrollDirection: ScrollDirection = .descending
}

@available(watchOS, unavailable)
@available(macOS, unavailable)
public protocol PagingLibrary {
    associatedtype Content
    associatedtype SelectionValue

    func pagingPosition(_ position: PageIndexPosition) -> Self
    func pagingOrientation(_ orientation: PagingOrientation) -> Self
    func scrollDirection(_ direction: ScrollDirection) -> Self
}

@available(watchOS, unavailable)
@available(macOS, unavailable)
public struct PagingLibraryContent: PagingLibrary {
    public func pagingPosition(_ position: PageIndexPosition) -> PagingLibraryContent {
        self
    }

    public func pagingOrientation(_ orientation: PagingOrientation) -> PagingLibraryContent {
        self
    }

    public func scrollDirection(_ direction: ScrollDirection) -> PagingLibraryContent {
        self
    }

    public typealias Content = View
    public typealias SelectionValue = Hashable

}
