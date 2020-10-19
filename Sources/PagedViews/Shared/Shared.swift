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

// MARK: PageView
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
public extension VerticalPageView {
    
}

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
