//
//  PageExtensions.swift
//
//
//  Created by Donavon Buchanan on 10/19/20.
//

import SwiftUI

@available(watchOS, unavailable)
@available(macOS, unavailable)
extension PageView
where SelectionValue == Int {
    public init(
        pageIndexPosition: PageIndexPosition = .trailing,
        indexDisplayMode: IndexDisplayMode = .always,
        scrollDirection: ScrollDirection = .descending,
        scrollingEnabled: Bool = true,
        orientation: PagingOrientation = .horizontal,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = nil
        self.position = pageIndexPosition
        self.indexDisplayMode = indexDisplayMode
        self.scrollDirection = scrollDirection
        self.scrollingEnabled = scrollingEnabled
        self.orientation = orientation
        self.content = content()
    }
}
