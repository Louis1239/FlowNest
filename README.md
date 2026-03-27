# FlowNest

FlowNest is a UIKit container for pages that share a top header while each page owns its own vertical scroll view.

It supports:

- Shared header + sticky segment
- Horizontal paging between child controllers
- Nested parent/child scroll coordination
- Built-in or custom segment view
- Built-in or custom navigation bar view
- Parent-level pull to refresh forwarded to the current child

## Installation

```ruby
pod 'FlowNest'
```

Or use a Git tag directly before publishing to CocoaPods trunk:

```ruby
pod 'FlowNest', :git => 'https://github.com/Louis/FlowNest.git', :tag => '0.1.0'
```

## Requirements

- iOS 15.0+
- UIKit
- MJRefresh

## Quick Start

```swift
import UIKit
import FlowNest

let config = FlowNestConfig()
config.navigationBarHeight = 88
config.navigationBarTitle = "FlowNest"
config.headerHeight = 220
config.segmentHeight = 48

let container = FlowNestContainerViewController(config: config)
container.headerView = headerView
container.setViewControllers([
    firstViewController,
    secondViewController,
    thirdViewController
])
navigationController?.pushViewController(container, animated: true)
```

Each child controller must conform to `FlowNestChildProtocol`.

If you want parent pull-to-refresh to trigger the current child, also conform to `FlowNestRefreshableChildProtocol`.

## Configuration

`FlowNestConfig` currently exposes:

- `navigationBarHeight`
- `navigationBarTitle`
- `showsNavigationBarBackButton`
- `navigationBarBackButtonTitle`
- `headerHeight`
- `segmentHeight`
- `maxOffset`

`maxOffset` is the parent/child scroll handoff threshold. When it is `0`, FlowNest falls back to `headerHeight`.

## Customization

Pass a custom `segmentView` or `navigationBarView` when the built-in ones are not enough.

If your custom segment needs to stay in sync with paging, conform it to `FlowNestSegmentContentProtocol`.

## Example App

The example project includes four demos:

- No navigation bar + default segment
- Built-in navigation bar + default segment
- Built-in navigation bar + custom segment
- Custom navigation bar + default segment

To run the example:

```bash
cd Example
pod install
open FlowNest.xcworkspace
```

## Author

Louis, 13032678708@163.com

## License

FlowNest is available under the MIT license. See the LICENSE file for more info.
