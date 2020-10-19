//
//  PageView.swift
//
//
//  Created by Donavon Buchanan on 10/18/20.
//

import SwiftUI

@available(watchOS, unavailable)
@available(macOS, unavailable)
public struct PageView<Content, SelectionValue>: PagingView
where Content: View, SelectionValue: Hashable {
    
    public func position(_ position: PageIndexPosition) -> PageView<Content, SelectionValue> {
        let newView = Self.init(selection: self.selection, pageIndexPosition: position, scrollDirection: self.scrollDirection) {
            content
        }
        return newView
    }

    public func orientation(_ orientation: PagingOrientation) -> PageView<Content, SelectionValue> {
        let newView = Self.init(selection: self.selection, pageIndexPosition: self.position, scrollDirection: self.scrollDirection, orientation: orientation) {
            content
        }
        return newView
    }

    public func scrollDirection(_ direction: ScrollDirection) -> PageView<Content, SelectionValue> {
        let newView = Self.init(selection: self.selection, pageIndexPosition: position, scrollDirection: direction) {
            content
        }
        return newView
    }

    let position: PageIndexPosition
    let orientation: PagingOrientation
    let scrollDirection: ScrollDirection

    var selection: Binding<SelectionValue>?

    let content: Content

    public init(
        selection: Binding<SelectionValue>? = nil,
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
        if orientation == .horizontal {
            if scrollDirection == .descending {
                return (.degrees(0), .degrees(0), .degrees(0), .degrees(0))
            }
            else if scrollDirection == .ascending {
                return (.degrees(0), .degrees(180), .degrees(0), .degrees(180))
            }
            else {
                return (.degrees(0), .degrees(0), .degrees(0), .degrees(0))
            }
        }
        else {
            if position == .trailing, scrollDirection == .descending {
                return (.degrees(-90), .degrees(180), .degrees(-90), .degrees(180))
            }
            else if position == .trailing, scrollDirection == .ascending {
                return (.degrees(90), .degrees(0), .degrees(-90), .degrees(0))
            }
            else if position == .leading, scrollDirection == .descending {
                return (.degrees(-90), .degrees(0), .degrees(90), .degrees(0))
            }
            else if position == .leading, scrollDirection == .ascending {
                return (.degrees(90), .degrees(180), .degrees(90), .degrees(180))
            }
            else {
                return (.degrees(0), .degrees(0), .degrees(0), .degrees(0))
            }
        }
    }
    // Rotation axis logic for the `.rotationEffect` and `.rotation3DEffect` modifiers.
    private var axis: (x: CGFloat, y: CGFloat, z: CGFloat) {
        if orientation == .vertical {
            return (x: 1.0, y: 0.0, z: 0.0)
        }
        else {
            return (x: 0.0, y: 1.0, z: 0.0)
        }
    }
}
