## Using the VIP pattern (Clean Swift) with SwiftUI

This is a small example project to demonstrate how to use the VIP pattern with SwiftUI.
It consists of three branches:

* `main` → a basic example of a view with two buttons and a label. Tapping the buttons increments or decrements the value of the label.
* `variations/subviews` → a further development of the `main` branch, moving the view with the buttons and the label to a subview.
* `variations/subviews-asynchronous-task` → a further development of the `variations/subviews` branch, adding a second subview which displays the result of a decoded response from a network call and has a reload button. E.g. when incrementing the counter and then tapping the reload button, it demonstrates that a state of one view will be unaffected when interacting with another subview within the same scene.

### Credit

* https://clean-swift.com
* https://www.kodeco.com/29416318-getting-started-with-the-vip-clean-architecture-pattern
  * I've used this article as the main inspiration, but my approach fixes the reference cycle that is present in this article (as of 14th of January 2023).
