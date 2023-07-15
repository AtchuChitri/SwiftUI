# SwiftUI
Working All Architecture in SwiftUI 

    ****TCA(The Composable Architecture)***
State: A type that describes the data your feature needs to perform its logic and render its UI.
Action: A type that represents all of the actions that can happen in your feature, such as user actions, notifications, event sources and more.
Reducer: A function that describes how to evolve the current state of the app to the next state given an action. The reducer is also responsible for returning any effects that should be run, such as API requests, which can be done by returning an Effect value.
Store: The runtime that actually drives your feature. You send all user actions to the store so that the store can run the reducer and effects, and you can observe state changes in the store so that you can update UI.

![Simulator Screenshot - iPhone 14 Pro - 2023-07-15 at 15 31 07](https://github.com/AtchuChitri/SwiftUI/assets/59951020/e93b58c5-b230-4317-8a95-7c59fa9da445)
