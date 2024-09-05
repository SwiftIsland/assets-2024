//
//  ColorsList.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

struct ColorsList<Content: View>: View {
    let easyMode: Bool
    let content: Content

    init(easyMode: Bool = false, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.easyMode = easyMode
    }

    func sectionContent(_ section: SectionConfiguration) -> some View {
        VStack(spacing: 0) {
            <#Iterate the content of the section and show each item#>
            <#To ensure the dragging works make sure to apply .frame(width: 60, height: 60)#>
        }
    }

    var body: some View {
        <#Iterate content to get the sections and lay them out however you want! (easiest is to just put them in an HStack).#>
          <#Hint: Each section is the result of `sectionContent()`#>

        <#Optional: Since each section tracks dragging independly, feel free to add shadow, spacing, border, or anything to the result of sectionContent!#>
    }
}
