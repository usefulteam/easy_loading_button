# easy_loading_button

![GitHub repo size](https://img.shields.io/github/repo-size/usefulteam/easy_loading_button.svg)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/usefulteam/easy_loading_button.svg)
![GitHub top language](https://img.shields.io/github/languages/top/usefulteam/easy_loading_button.svg)
[![GitHub issues](https://img.shields.io/github/issues/usefulteam/easy_loading_button.svg)](https://github.com/usefulteam/easy_loading_button/issues)
[![GitHub license](https://img.shields.io/github/license/usefulteam/easy_loading_button.svg)](https://github.com/usefulteam/easy_loading_button/blob/master/LICENSE)

**easy_loading_button** is a free and open source (MIT license) Material Flutter Button that supports variety of buttons style demands. It is designed to be easy to use and customizable.

<!-- <img src="https://github.com/usefulteam/easy_loading_button/blob/master/example/assets/example_20190616.gif" width="600"> -->

## Get started

### **Depend on it**

Add this to your package's `pubspec.yaml` file:

```yaml
easy_loading_button: '^0.1.0'
```

### **Install it**

You can install packages from the command line:

```
$ flutter pub get
```

Alternatively, your editor might support flutter pub get.

### **Import it**

Now in your Dart code, you can use:

```dart
import 'package:easy_loading_button/easy_loading_button.dart';

```

## How to use

Add `EasyButton` to your widget tree:

```dart
EasyButton(
  type: EasyButtonType.elevated,
  idleStateWidget: const Text(
    'Elevated Button',
    style: TextStyle(
      color: Colors.white,
    ),
  ),
  loadingStateWidget: const CircularProgressIndicator(
    strokeWidth: 3.0,
    valueColor: AlwaysStoppedAnimation<Color>(
      Colors.white,
    ),
  ),
  // Whether to animate the button width or not.
  useWidthAnimation: false,
  // When useWidthAnimation is set to false, you might want to set the  parameter to true.
  useEqualLoadingStateWidgetDimension: true,
  // If you want a fullwidth size, set this to double.infinity
  width: 150.0,
  height: 40.0,
  borderRadius: 4.0,
  // The gap between button and it's content. This will be ignored when the type is 
  contentGap: 6.0,
  buttonColor: Colors.blueAccent,
  onPressed: () {},
),
```

More parameters:
```dart
const EasyButton({
  Key? key,
  required this.idleStateWidget,
  required this.loadingStateWidget,
  this.type = EasyButtonType.elevated,
  this.useWidthAnimation = true,
  this.useEqualLoadingStateWidgetDimension = true,
  this.width = double.infinity,
  this.height = 40.0,
  this.contentGap = 0.0,
  this.borderRadius = 0.0,
  this.buttonColor = Colors.blueAccent,
  this.onPressed,
}) : super(key: key);
```

Three types supported:
```dart
enum EasyButtonType {
    elevated,
    outlined,
    text,
}
```

## Source
Source code and example of this library can be found in git:

```
$ git clone https://github.com/usefulteam/easy_loading_button.git
```

## License
[MIT License](https://oss.ninja/mit?organization=Useful%20Team)

## Credits
Thanks to x for the `flutter_progress_button` package. My package was based on it.
- [flutter_progress_button on GitHub](https://github.com/jiangyang5157/flutter_progress_button)
- [flutter_progress_button on pub.dev](https://pub.dev/packages/flutter_progress_button)
