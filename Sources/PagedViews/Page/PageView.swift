//
//  PageView.swift
//
//
//  Created by Donavon Buchanan on 10/18/20.
//

import SwiftUI

#if os(watchOS)
    typealias PageIndexViewStyle = PageTabViewStyle

    extension PageIndexViewStyle {
        typealias BackgroundDisplayMode = PageTabViewStyle.IndexDisplayMode

        init(backgroundDisplayMode: BackgroundDisplayMode) {
            self.init(indexDisplayMode: backgroundDisplayMode)
        }
    }

    extension View {
        func indexViewStyle<S>(_ style: S) -> some View where S: TabViewStyle {
            return self
        }
    }
#endif

@available(macOS, unavailable)
public struct PageView<Content, SelectionValue>: Pageable
where Content: View, SelectionValue: Hashable {

    public func indexDisplayMode(_ indexDisplayMode: IndexDisplayMode) -> PageView<
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

    public let indexDisplayMode: IndexDisplayMode

    public let position: PageIndexPosition
    public let orientation: PagingOrientation

    public let scrollDirection: ScrollDirection

    var selection: Binding<SelectionValue>?

    let content: Content

    @State
    private var size = CGSize()

    public init(
        selection: Binding<SelectionValue>?,
        pageIndexPosition: PageIndexPosition = .trailing,
        indexDisplayMode: IndexDisplayMode = .always,
        scrollDirection: ScrollDirection = .descending,
        orientation: PagingOrientation = .horizontal,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.selection = selection
        self.position = pageIndexPosition
        self.scrollDirection = scrollDirection
        self.orientation = orientation
        self.indexDisplayMode = indexDisplayMode
        self.content = content()
    }

    public var body: some View {
        ZStack {
            Color.clear
                .allowsHitTesting(false)
                /*
                 That one weird trick to w̶h̶i̶t̶e̶n̶ ̶y̶o̶u̶r̶ ̶t̶e̶e̶t̶h̶
                 constrain a GeometryReader's size
                 */
            .background(
                GeometryReader { geometry in
                    // Lazy VStack resulted in poor scrolling performance here
                    LazyVStack {
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
                                .aspectRatio(contentMode: .fit)
                                .frame(
                                    width: orientation == .horizontal
                                        ? geometry.size.width
                                        : geometry.size.height,
                                    height: orientation == .horizontal
                                        ? geometry.size.height
                                        : geometry.size.width
                                )
                                .modifier(WatchOSModifier(frame: geometry.frame(in: .global), position: self.position, orientation: self.orientation))
                        }
                        .frame(
                            width: orientation == .horizontal
                                ? geometry.size.width
                                : geometry.size.height,
                            height: orientation == .horizontal
                                ? geometry.size.height
                                : geometry.size.width
                        )
                        // Sets the visibility behavior of the paging dots
                        .indexViewStyle(
                            PageIndexViewStyle(backgroundDisplayMode: displayMode.pageStyle)
                        )
                        /*
                             For some reason, seems both of these modifiers are necessary to
                             achieve the desired behavior
                             */
                        .tabViewStyle(
                            PageTabViewStyle(indexDisplayMode: displayMode.tabViewStyle)
                        )
                    }
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
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
                }
            )
        }
    }

    // Index Display Mode
    #if os(watchOS)
        private var displayMode:
            (
                pageStyle: PageTabViewStyle.IndexDisplayMode,
                tabViewStyle: PageTabViewStyle.IndexDisplayMode
            )
        {
            // Just for my own convenience
            let pageStyle = PageIndexViewStyle.BackgroundDisplayMode.self
            let tabViewStyle = PageTabViewStyle.IndexDisplayMode.self

            switch indexDisplayMode {
            case .always:
                return (pageStyle.automatic, tabViewStyle.automatic)
            case .automatic:
                return (pageStyle.automatic, tabViewStyle.automatic)
            case .interactive:
                return (pageStyle.automatic, tabViewStyle.automatic)
            case .never:
                return (pageStyle.automatic, tabViewStyle.automatic)
            }
        }
    #endif

    #if !os(watchOS)
        private var displayMode:
            (
                pageStyle: PageIndexViewStyle.BackgroundDisplayMode,
                tabViewStyle: PageTabViewStyle.IndexDisplayMode
            )
        {
            // Just for my own convenience
            let pageStyle = PageIndexViewStyle.BackgroundDisplayMode.self
            let tabViewStyle = PageTabViewStyle.IndexDisplayMode.self

            switch indexDisplayMode {
            case .always:
                return (pageStyle.always, tabViewStyle.always)
            case .automatic:
                return (pageStyle.automatic, tabViewStyle.automatic)
            case .interactive:
                return (pageStyle.interactive, tabViewStyle.automatic)
            case .never:
                return (pageStyle.never, tabViewStyle.never)
            }
        }
    #endif

    // Rotation logic for the `.rotationEffect` and `.rotation3DEffect` modifiers.
    private var rotation: (content: Angle, content3D: Angle, container: Angle, container3D: Angle) {
        switch orientation {
        case .horizontal:
            switch position {
            case .trailing, .bottom:
                switch scrollDirection {
                case .ascending:
                    return (.degrees(180), .degrees(180), .degrees(180), .degrees(180))
                case .descending:
                    return (.degrees(0), .degrees(0), .degrees(0), .degrees(0))
                }
            case .leading, .top:
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
