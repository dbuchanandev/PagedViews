//
//  WatchOSModifier.swift
//  
//
//  Created by Donavon Buchanan on 10/27/20.
//

import SwiftUI

struct WatchOSModifier: ViewModifier {
    let frame: CGRect
    let position: PageIndexPosition
    let orientation: PagingOrientation
    
    private var isWatchOS:Bool {
        #if os(watchOS)
        return true
        #else
        return false
        #endif
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isWatchOS, orientation == .vertical {
            content
                .position(x: frame.origin.x + (frame.height / 2), y: frame.origin.y + (frame.width / 3))
        } else {
            content
        }
    }
}
