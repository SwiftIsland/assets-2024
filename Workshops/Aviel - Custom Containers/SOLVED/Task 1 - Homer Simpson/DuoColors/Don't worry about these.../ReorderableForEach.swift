//
//  EmptyIdentifiable.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//


import SwiftUI
import UniformTypeIdentifiers

protocol EmptyIdentifiable: Identifiable {
    static var emptyId: ID { get }
}

struct ReorderableForEach<Content: View, Item: EmptyIdentifiable & Equatable>: View {
    let items: [Item]
    let itemHeight: CGFloat
    let content: (Item) -> Content
    let moveAction: (Int, Int) -> Void

    @State private var draggingItem: Item?
    @GestureState private var dragLocation: CGPoint? = nil
    @State private var placeholderIndex: Int?

    func dragGesture(for item: Item) -> some Gesture {
        let itemIndex = items.firstIndex(of: item)!
        return DragGesture(minimumDistance: 0)
            .onChanged { _ in
                draggingItem = item
                let locationY = (dragLocation?.y ?? 0)

                guard locationY != 0 else { return }

                let adjustedY = if locationY > itemHeight/2 {
                    locationY + itemHeight/2
                } else {
                    locationY - itemHeight/2
                }

                let indexShift = Int((adjustedY / itemHeight).rounded())
                placeholderIndex = min(max(indexShift + itemIndex, 0), items.count)
                //print("\(itemIndex) -> \(placeholderIndex!) (\(indexShift)) Y: \(Int(locationY.rounded())) (adjusted: \(Int(adjustedY.rounded()))")
            }
            .updating($dragLocation) { (value, location, transaction) in
                location = value.location
            }
            .onEnded { _ in
                if let placeholderIndex, itemIndex != placeholderIndex {
                    moveAction(itemIndex, min(items.count, placeholderIndex))
                }
                placeholderIndex = nil
                draggingItem = nil
            }
    }

    func offsetY(for item: Item) -> CGFloat {
        guard 
            let draggingItem,
            let placeholderIndex,
            let draggingItemIndex = items.firstIndex(of: draggingItem),
            let givenItemIndex = items.firstIndex(of: item),
            draggingItem != item
        else { return 0 }
        var result: CGFloat = 0
        if givenItemIndex > draggingItemIndex { result = -itemHeight }
        if givenItemIndex >= placeholderIndex { result += itemHeight }
        return result
    }

    var defaultPosition: CGPoint {
        CGPoint(x: itemHeight/2, y: itemHeight/2)
    }

    var body: some View {
        ForEach(items) { item in
            ItemView(
                offsetY: offsetY(for: item),
                position: draggingItem == item ? dragLocation ?? defaultPosition : defaultPosition,
                isDragging: draggingItem == item
            ) {
                content(item)
            }
            .gesture(dragGesture(for: item))
        }
    }
}

struct ItemView<Content: View>: View {
    let content: Content
    let offsetY: CGFloat
    let position: CGPoint
    let isDragging: Bool

    init(offsetY: CGFloat, position: CGPoint, isDragging: Bool, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.offsetY = offsetY
        self.position = position
        self.isDragging = isDragging
    }

    var body: some View {
        content
            .opacity(isDragging ? 0.5 : 1)
            .offset(y: offsetY)
            .zIndex(isDragging ? 1 : 0)
            .position(position)
    }
}
