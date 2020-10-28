//
//  VerticalPageExtensions.swift
//
//
//  Created by Donavon Buchanan on 10/19/20.
//

import SwiftUI


@available(macOS, unavailable)
extension VerticalPageView {

}


@available(macOS, unavailable)
extension VerticalPageView
where SelectionValue == Int {
    public init(
        pageIndexPosition: PageIndexPosition = .trailing,
        indexDisplayMode: IndexDisplayMode = .always,
        scrollDirection: ScrollDirection = .descending,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = nil
        self.position = pageIndexPosition
        self.indexDisplayMode = indexDisplayMode
        self.scrollDirection = scrollDirection
        self.orientation = .vertical
        self.content = content()
    }
}
