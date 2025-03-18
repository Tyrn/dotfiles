#### Create an RxBloc Hello project

- Use Very Good CLI:
```
$ very_good create flutter_app very_hello
$ cd very_hello
```
- Add Linux platform:
```
$ flutter create --platforms=linux .
```
- Add to `dependencies` (`$ flutter pub add`):
```
  auto_route:
  flutter_rx_bloc:
  window_size:
    git:
      url: https://github.com/google/flutter-desktop-embedding.git
      path: plugins/window_size
      ref: 6c66ad23ee79749f30a8eece542cf54eaf157ed8
```
- Add to `dev_dependencies` (`$ flutter pub add -d`):
```
  import_sorter:
  rx_bloc_generator:
  auto_route_generator:
  rx_bloc_test:
  build_runner:
```
- [Import sorter](https://pub.dev/packages/import_sorter) usage:
```
$ flutter pub run import_sorter:main
```
- Create `lib/platform.dart`:
```
import 'package:flutter/foundation.dart';

class Platform {
  static bool get isDesktop {
    return isLinux || isMacOS || isWindows;
  }

  static bool get isLinux {
    return defaultTargetPlatform == TargetPlatform.linux;
  }

  static bool get isMacOS {
    return defaultTargetPlatform == TargetPlatform.macOS;
  }

  static bool get isWindows {
    return defaultTargetPlatform == TargetPlatform.windows;
  }

  static bool get isFuchsia {
    return defaultTargetPlatform == TargetPlatform.fuchsia;
  }

  static bool get isAndroid {
    return defaultTargetPlatform == TargetPlatform.android;
  }

  static bool get isIOS {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }
}
```
- Remove standard boilerplate; new `lib/main.dart`:
```
import 'package:very_hello/main_development.dart' as development;
import 'package:very_hello/main_production.dart' as production;
import 'package:very_hello/main_staging.dart' as staging;

void main() {
  return development.main();
}
```
- Remove error from `test/widget_test.dart`:
```
import 'package:very_hello/app/app.dart';
...
    await tester.pumpWidget(const App());
```

