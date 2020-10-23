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
        
//        LibraryItem(
//            base.allowsScrolling(scrollingEnabled),
//            visible: true,
//            title: "Scrolling Enabled",
//            category: .layout
//        )
        
        LibraryItem(
            base.indexDisplayMode(indexDisplayMode),
            visible: true,
            title: "Paging Index Display Mode",
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
    private let scrollingEnabled: Bool = true
    private let indexDisplayMode: IndexDisplayMode = .always
}

@available(watchOS, unavailable)
@available(macOS, unavailable)
public protocol PagingLibrary {
    associatedtype Content
    associatedtype SelectionValue

    /// Updates the `pageIndexPosition` value of the view and returns the modified view.
    /// - Parameter position: Case value of `PageIndexPosition` to set
    /// how the view positions its paging index view.
    func pagingPosition(_ position: PageIndexPosition) -> Self
    
    /// Updates the `orientation` value of the view and returns the modified view.
    /// - Parameter orientation: Case value of `PagingOrientation` to set
    /// if the view will be paginated in either `.vertical` or `.horizontal` orientation.
    func pagingOrientation(_ orientation: PagingOrientation) -> Self
    
    /// Updates the `direction` value of the view and returns the modified view.
    /// - Parameter direction: Case value of `ScrollDirection` to set
    /// which direction the view will scroll, with `.descending` being default behavior and
    /// `.ascending` being the inverse behavior.
    func scrollDirection(_ direction: ScrollDirection) -> Self
    
    func indexDisplayMode(_ displayMode: IndexDisplayMode) -> Self
    
    func allowsScrolling(_ bool: Bool) -> Self
}

@available(watchOS, unavailable)
@available(macOS, unavailable)
public struct PagingLibraryContent: PagingLibrary {
    public func indexDisplayMode(_ displayMode: IndexDisplayMode) -> PagingLibraryContent {
        self
    }
    
    public func allowsScrolling(_ bool: Bool) -> PagingLibraryContent {
        self
    }
    
    
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
