//
//  PageView.swift
//
//
//  Created by Donavon Buchanan on 10/18/20.
//

import SwiftUI

@available(watchOS, unavailable)
@available(macOS, unavailable)
public struct PageView<Content, SelectionValue>: Pageable
where Content: View, SelectionValue: Hashable {

    public func pagingPosition(_ position: PageIndexPosition) -> PageView<Content, SelectionValue> {
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

    public func pagingOrientation(_ orientation: PagingOrientation) -> PageView<
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

    public func scrollDirection(_ direction: ScrollDirection) -> PageView<Content, SelectionValue> {
        let newView = Self.init(
            selection: self.selection,
            pageIndexPosition: position,
            scrollDirection: direction,
            orientation: self.orientation
        ) {
            content
        }
        return newView
    }

    public let position: PageIndexPosition
    public let orientation: PagingOrientation
    public let scrollDirection: ScrollDirection

    var selection: Binding<SelectionValue>?

    let content: Content

    public init(
        selection: Binding<SelectionValue>?,
        pageIndexPosition: PageIndexPosition = .trailing,
        scrollDirection: ScrollDirection = .descending,
        orientation: PagingOrientation = .horizontal,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        self.position = pageIndexPosition
        self.scrollDirection = scrollDirection
        self.orientation = orientation
        self.content = content()
    }

    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyHStack {
                    TabView(selection: selection) {
                        content
                            // Rotates each Tab's content as needed
                            .rotationEffect(
                                rotation.content
                            )
                            // Flips each Tab's content as needed
                            .rotation3DEffect(
                                rotation.content3D,
                                axis: axis
                            )
                    }
                    // Sets the visibility behavior of the paging dots
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    /*
                     For some reason, seems both of these modifiers are necessary to
                     achieve the desired behavior
                     */
                    .tabViewStyle(PageTabViewStyle())
                    /*
                     When the TabView is rotated, SwiftUI tends to favor the smallest possible
                     frame size, causing all the content, including the paging dots, to collapse inward
                     */
                    // Rotates the TabView to the specified vertical position
                    .rotationEffect(
                        rotation.container
                    )
                    // Flips the TabView to the specified position
                    .rotation3DEffect(
                        rotation.container3D,
                        axis: axis
                    )
                    // TODO: frame needs to account for orientation
                    .frame(
                        width: orientation == .horizontal
                            ? geometry.size.width
                            : geometry.size.height,
                        height: orientation == .horizontal
                            ? geometry.size.height
                            : geometry.size.width
                    )
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }

    // Rotation logic for the `.rotationEffect` and `.rotation3DEffect` modifiers.
    private var rotation: (content: Angle, content3D: Angle, container: Angle, container3D: Angle) {
        switch orientation {
        case .horizontal:
            switch position {
            case .leading, .trailing, .bottom:
                switch scrollDirection {
                case .ascending:
                    return (.degrees(180), .degrees(180), .degrees(180), .degrees(180))
                case .descending:
                    return (.degrees(0), .degrees(0), .degrees(0), .degrees(0))
                }
            case .top:
                switch scrollDirection {
                case .ascending:
                    return (.degrees(180), .degrees(0), .degrees(180), .degrees(0))
                case .descending:
                    return (.degrees(0), .degrees(180), .degrees(0), .degrees(180))
                }
            }
        case .vertical:
            switch position {
            case .leading, .top:
                switch scrollDirection {
                case .ascending:
                    return (.degrees(90), .degrees(180), .degrees(90), .degrees(180))
                case .descending:
                    return (.degrees(-90), .degrees(0), .degrees(90), .degrees(0))
                }
            case .bottom, .trailing:
                switch scrollDirection {
                case .ascending:
                    return (.degrees(90), .degrees(0), .degrees(-90), .degrees(0))
                case .descending:
                    return (.degrees(-90), .degrees(180), .degrees(-90), .degrees(180))
                }
            }
        }
    }

    // Rotation axis logic for the `.rotationEffect` and `.rotation3DEffect` modifiers.
    private var axis: (x: CGFloat, y: CGFloat, z: CGFloat) {
        return (x: 1.0, y: 0.0, z: 0.0)
    }
}
