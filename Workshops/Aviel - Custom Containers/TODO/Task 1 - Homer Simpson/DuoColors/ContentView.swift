//
//  ContentView.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var colors: [ColorModel]

    var body: some View {
        VStack {
            customContainerContent
            variadicViewFooter
        }
    }
    
    /// This is just an example showing you how Variadic view works in action.
    /// There's nothing you need to do here!
    ///
    /// Note how we pass a custom `FooterVStackLayout` we created - which decides how to layout
    /// the views (it adds a divider, some padding, and a background).
    var variadicViewFooter: some View {
        _VariadicView.Tree(FooterVStackLayout(alignment: .leading)) {
            Text("How to play:")
                .bold()
            VStack(alignment: .leading) {
                Text("Drag to organize the colors in order, once you finish - the game ends!")
                Text("When a color is in the correect place, it will have a \(Image(systemName: "checkmark")).")
            }
            .font(.caption)
            .foregroundStyle(Color.secondary)
            .multilineTextAlignment(.leading)
        }
        .padding([.horizontal, .top])
    }

    /// ▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽
    /// ===> This is where you come in! <===
    /// △△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△
    ///
    /// ``ColorsList`` is our custom container!
    /// 
    /// ``ReorderableForEach`` is a custom view built for this workshop. It works exactly like the
    /// regular ForEach we know and love, but it let's you drag views. We know that ForEach needs
    /// the elements to be ``Identifiable``, and `colors` is and array of ``ColorModel``, which is.
    /// If you poke at the `body` of ``ReorderableForEach``, you'll see that it just
    /// calls `ForEach`, so you can imagine this propert is actually:
    /// ```
    ///     var customContainerContent: some View {
    ///         ColorsList {
    ///             ForEach(colors) { color in
    ///                 ...
    ///             }
    ///         }
    ///     }
    /// ```
    /// ForEach(colors
    var customContainerContent: some View {
        ColorsList {

            ReorderableForEach(items: colors, itemHeight: 60) { item in

                item.color
                    .<#Pass the container value you declared in ColorsList.swift:#>
                     <#Use `isCorrect(item)` to get the value and pass it#>

            } moveAction: { from, to in

                colors.move(fromOffsets: .init(integer: from), toOffset: to)

            }

        }
    }
    
    /// Don't look inside here I'm force unwrapping a value it's terrible! It also isn't relavent
    /// for our workshop, I promise it works...(I think)
    func isCorrect(_ item: ColorModel) -> Bool {
        return colors.firstIndex(of: item)! + 1 == item.id
    }
}
