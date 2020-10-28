//
//  File.swift
//
//
//  Created by Donavon Buchanan on 10/18/20.
//

import SwiftUI

public enum PageIndexPosition {
    case leading, trailing, top, bottom
}

public enum ScrollDirection {
    case ascending, descending
}

public enum PagingOrientation {
    case horizontal, vertical
}

public enum IndexDisplayMode {
    case always, automatic, interactive, never
}


@available(macOS, unavailable)
protocol Pageable: View {
    associatedtype Content
    associatedtype SelectionValue
    
    var indexDisplayMode: IndexDisplayMode { get }

    var position: PageIndexPosition { get }
    var orientation: PagingOrientation { get }
    
    var scrollDirection: ScrollDirection { get }
    
//    var scrollingEnabled: Bool { get }

    var selection: Binding<SelectionValue>? { get set }

    var content: Content { get }
    
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
    
//    func allowsScrolling(_ bool: Bool) -> Self
}
