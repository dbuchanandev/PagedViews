//
//  File.swift
//  
//
//  Created by Donavon Buchanan on 10/18/20.
//

import SwiftUI

public enum PageIndexPosition {
    case leading, trailing
}

public enum ScrollDirection {
    case ascending, descending
}

public enum PagingOrientation {
    case horizontal, vertical
}

protocol PagingView: View {
    associatedtype Content
    associatedtype SelectionValue
    
    var position: PageIndexPosition { get }
    var orientation: PagingOrientation { get }
    var scrollDirection: ScrollDirection { get }
    
    var selection: Binding<SelectionValue>? { get set }
    
    var content: Content { get }
    
    func position(_ position: PageIndexPosition) -> Self
    func orientation(_ orientation: PagingOrientation) -> Self
    func scrollDirection(_ direction: ScrollDirection) -> Self
}

// MARK: PageView
@available(watchOS, unavailable)
@available(macOS, unavailable)
public extension PageView {
    init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = nil
        self.orientation = .horizontal
        self.position = .trailing
        self.scrollDirection = .descending
        self.content = content()
    }
    
    init(
        selection: Binding<SelectionValue>? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        self.orientation = .horizontal
        self.position = .trailing
        self.scrollDirection = .descending
        self.content = content()
    }
}

@available(watchOS, unavailable)
@available(macOS, unavailable)
public extension PageView
where SelectionValue == Int {
    init(
        selection: Binding<Int>? = nil,
        orientation: PagingOrientation = .horizontal,
        pageIndexPosition: PageIndexPosition = .trailing,
        scrollDirection: ScrollDirection = .descending,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        self.orientation = orientation
        self.position = pageIndexPosition
        self.scrollDirection = scrollDirection
        self.content = content()
    }
    
    init(
        selection: Binding<SelectionValue>? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        self.orientation = .horizontal
        self.position = .trailing
        self.scrollDirection = .descending
        self.content = content()
    }
}

// MARK: VerticalPageView
@available(watchOS, unavailable)
@available(macOS, unavailable)
public extension VerticalPageView {
    
}

@available(watchOS, unavailable)
@available(macOS, unavailable)
public extension VerticalPageView
where SelectionValue == Int {
    init(
        selection: Binding<Int>? = nil,
        pageIndexPosition: PageIndexPosition = .trailing,
        scrollDirection: ScrollDirection = .descending,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        self.position = pageIndexPosition
        self.scrollDirection = scrollDirection
        self.content = content()
    }
}
