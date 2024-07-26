
# flutter_svg

[![Pub](https://img.shields.io/pub/v/slideable_pop_scope)](https://pub.dartlang.org/packages/slideable_pop_scope) [![Coverage Status](https://coveralls.io/repos/github/HAM02020/slideable_pop_scope/badge.svg?branch=main)](https://coveralls.io/github/HAM02020/slideable_pop_scope?branch=main)

<!-- markdownlint-disable MD033 -->
<img src="https://raw.githubusercontent.com/dnfield/flutter_svg/7d374d7107561cbd906d7c0ca26fef02cc01e7c8/example/assets/flutter_logo.svg?sanitize=true" width="200px" alt="Flutter Logo which can be rendered by this package!">
<!-- markdownlint-enable MD033 -->

Popscope that easy to used and adapted to iOS slide to go back gesture


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