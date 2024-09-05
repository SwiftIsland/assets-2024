//
//  ColorsList.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

/// ``ContainerValues`` allows creating ``@Entry`` for values we want to pass down to our custom
/// container (kinda like ``@Environment``!).

<#- Make an extension on ContainerValues and add an entry of a boolean flag to know of an item is in the correct place#>

<#- Optional: Make an extension on View to have a nice function instead of calling `.containerValue(...)` directly#>

/// ColorsList takes a list of views and presents them on the screen in a custom layout
/// (to make the drag gesture work though - just show them in a VStack... - unless you want
/// to hack around the calculations in ``ReorderableForEach``...
///
/// It also (if you want!) decorates the views with border, corner radius, shadow, maybe a fun
/// overlay - the sky's the limit!
struct ColorsList<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        <#1. Use ForEach(subviews:content:) to iterate over the color subviews and lay them out in a VStack#>

        <#2. Use `.containerValues` on the subviews to access the boolean value you created above, and show a checkmark if it is true#>
    }
}
