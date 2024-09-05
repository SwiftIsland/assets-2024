# Custom Containers

Welcome to the Custom Containers workshop!

In this workshop we are building a color matching game - the game begins with a row of shuffled colors, and your goal is to drag the tiles so that the shades are in order.

|In DuoColors (the first version of the game) we order the shades between two colors|In QuadColors (the second version) we order shades mixed from 4 colors!|
|-|-|
|<img width="250" alt="image" src="https://github.com/user-attachments/assets/d0c3c2d8-a709-46dc-8517-93ddbba7c4e4">|<img width="250" alt="image" src="https://github.com/user-attachments/assets/ebe3c6ff-b6a9-49c1-996e-9dccd09f7e45">|


# Navigating the repo
There are 3 main directories:
- `REFERENCE/`: If in a few months you want to check how we did something - this is the place to go. For the duration of the workshop though, there's no reason to use this folder! Inside you'll find 2 projects: DuoColors is the result of both task 1 and task 2, and QuadColors is task 3.
- `SOLVED/`: All the tasks - solved. If you are stuck and don't feel like trying to figure it out, you can peek - although you might have more fun if you try to ask folks around instead!
- `TODO/`: This is where the party happens! Each task is an Xcode project so it doesn't matter how you finished the previous task - we're all starting fresh each time.

# Tasks
Everything you need to do in each task is written as placeholders inside the code, and until you clear them up you won't be able to compile, so there's no way you'll miss anything. At a high level though, here's what we're doing in each task:

---

<img width="50" alt="image" src="https://github.com/user-attachments/assets/c57dc1a8-11b3-4dd5-ab2a-6ca79b366143">

### Task 1 - Homer Simpson
Building our first custom container! We'll use `ForEach(subviews:)`` to iterate the content's children, and also utilize ContainerValues and `@Entry` to pass so data down to the custom container when we iterate each subview.

---

<img width="40" alt="image" src="https://github.com/user-attachments/assets/92a716cc-056b-498b-800d-ee257a4e02b1">

### Task 2 - Marge Simpson (easy mode)
Adding an "Easy Mode" to our game - this will add some optional views that are then resolved to a view (or nothing) based on the view's state.
We'll also use container values again to pass a "hint" when easy mode is active.

---

<img width="140" alt="image" src="https://github.com/user-attachments/assets/3cf81159-876d-45e8-976d-064e5ff3a5d3">

### Task 3 - Kids (sections)
This task is using a modified version of the previous project. We are going to have multiple sections, where each section is a row of colors. We will use `ForEach(sections:)` to grab the sections, then `ForEach(subviews:)` to get each subview from each section.
For simplicity, the code here does not include easy mode or any of the container values, so that we can focus on the sections.

---

# Bonus Tasks
Done early? Want some extra challenge? Here are a few things you can add to the game!

- [ ] [MeshGradient](https://developer.apple.com/documentation/swiftui/meshgradient) is another really cool addition to SwiftUI this year! Try to use it to make a fun background for the "You Win" sheet, made from the colors of the game!
- [ ] Start from 2 random colors each time: Currently the game always starts from Red and Blue. It could be fun to make it start from 2 random colors instead!
- [ ] Start from 2 selected colors: What if the user could pick which 2 colors to start from? Hint - [there's an API for that!](https://developer.apple.com/documentation/swiftui/colorpicker)
- [ ] Challenge mode: Easy mode is great, but maybe the game is actually too easy and not too hard? You can add an option to start from 2 colors that are closer to each other (like Orange and Red instead of Blue and Red).
- [ ] Timer: Measure the time it takes to solve the game - then you can compete with friends to see who solves it the fastest!
- [ ] High score board: if you added a timer - make a board to keep score of previous games!

# Apple Docs:
- [`ForEach(subviews:)`](https://developer.apple.com/documentation/swiftui/foreach/init(subviews:content:)) - iterate each subview of given view and return a modified (or other) view.
- [`ForEach(sections:)`](https://developer.apple.com/documentation/swiftui/foreach/init(sections:content:)) - iterate each section of given view and return a modifier (or other) view.
- [`Group(subviews:)`](https://developer.apple.com/documentation/swiftui/group/init(subviews:transform:)) - access the subviews of given view and do whatever you want with them.
- [`Group(sections:)`](https://developer.apple.com/documentation/swiftui/group/init(sections:transform:)) - access the sections of given view and do whatever you want with them.
- [`containerValue(::)`](https://developer.apple.com/documentation/swiftui/view/containervalue(_:_:)) - set a container value to a subview
- [`@Entry`](https://developer.apple.com/documentation/swiftui/entry()#Container-Values)

# Other Resources:
- Apple Sample Code: [Creating custom container views](https://developer.apple.com/documentation/swiftui/creating-custom-container-views)
- WWDC24 Session 10146: [Demystify SwiftUI containers](https://developer.apple.com/wwdc24/10146)
- VariadicViews Blog Posts:
  - [Moving Parts](https://movingparts.io/variadic-views-in-swiftui)
  - [Chris Eidhof](https://chris.eidhof.nl/post/variadic-views/)
  - [Emerge Tools](https://www.emergetools.com/blog/posts/how-to-use-variadic-view)
