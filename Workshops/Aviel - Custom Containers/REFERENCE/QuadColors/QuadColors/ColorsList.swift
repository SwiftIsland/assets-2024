//
//  ColorsList.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

extension ContainerValues {
    @Entry var colorHint: String?
}

extension View {
    func colorHint(_ value: Int?) -> some View {
        containerValue(\.colorHint, value.map(String.init))
    }
}

struct ColorsList<Content: View>: View {
    let easyMode: Bool
    let content: Content

    init(easyMode: Bool = false, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.easyMode = easyMode
    }

    func sectionContent(_ section: SectionConfiguration) -> some View {
        VStack(spacing: 0) {
            ForEach(subviews: section.content) { item in
                item
                    .frame(width: 60, height: 60)
                    .overlay {
                        if let hint = item.containerValues.colorHint {
                            Text(hint)
                                .allowsHitTesting(false)
                        }
                    }
            }
        }
    }

    var body: some View {
        HStack {
            ForEach(sections: content) { section in
                sectionContent(section)
                    .border(Color.gray, width: 4)
            }
        }
    }
}
