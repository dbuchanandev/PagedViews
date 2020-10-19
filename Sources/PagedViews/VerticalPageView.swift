//
//  VerticalPageView.swift
//
//
//  Created by Donavon Buchanan on 10/19/20.
//

import SwiftUI

public struct VerticalPageView<Content, SelectionValue>: View
where Content: View, SelectionValue: Hashable {

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
