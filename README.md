# PagedViews

## Description
Simplifies creating paged tab views.
These views should behave very similarly to a standard SwiftUI TabView with regard to
selection values, tags, etc.
Does not support watchOS or native macOS. Documentation here is very incomplete.

## Usage
### Simple init with modifiers
```swift
import SwiftUI
import PagedViews

struct ContentView: View {
    
    var body: some View {
        PageView(selection: $selection) {
            Text("One")
            Text("Two")
            Text("Three")
            Text("Four")
            Text("Five")
            Text("Six")
        }
        .orientation(.vertical)
    }
}
```

### With selection value and ForEach automatic tagging
```swift
import SwiftUI
import PagedViews

struct ContentView: View {

    @State
    private var selection = 0
    
    let tabs: [Text] = [
        Text("One"),
        Text("Two"),
        Text("Three"),
        Text("Four"),
        Text("Five"),
        Text("Six")
    ]
    
    var body: some View {
        PageView(selection: $selection) {
            // ForEach automatically tags each View
            ForEach(tabs.indices, id: \.self) { index in
                tabs[index]
            }
        }
    }
}
```

### With selection value and manual tagging
```swift
import SwiftUI
import PagedViews

struct ContentView: View {

    @State
    private var selection = 0
    
    var body: some View {
        VerticalPageView(selection: $selection) {
            Text("One")
                .tag(0)
            Text("Two")
                .tag(1)
            Text("Three")
                .tag(2)
            Text("Four")
                .tag(3)
            Text("Five")
                .tag(4)
            Text("Six")
                .tag(5)
        }
    }
}
```

### Example Project
[Coming Soon](https://github.com/donavoncade/)

## Contact
[Twitter: @dbuchanandev](https://twitter.com/dbuchanandev)

## License
This project is [licensed](License.txt) under the terms of the GNU GPLv3 license.
