

> Note: When using Flutter's official PopScope, the iOS slide to go back feature becomes ineffective. SlideablePopScope was introduced to solve this issue.

---

## Usage

To use this package, add `slideable_pop_scope` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).


## Examples

### Import the library

``` dart
// main.dart
import 'package:slideable_pop_scope/slideable_pop_scope.dart';
```
###### Using SlideablePopScope:
``` dart
// my_screen.dart
@override
Widget build(BuildContext context) {
  return SlideablePopScope(
    child: _MyScreenContent(),
    onWillPop: _onWillPop,
  );
}
```