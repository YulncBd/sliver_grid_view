## SliverGridView

![](/example/assets/demo.gif)

A sliver grid view

* create a group grid view
* support GridView's header and footer
* support section's header and footer
* support click section and scroll to the top
* you can set different grid delegate for each section

## Using

add sliver_grid_view to your pubspec.yaml file:
```dart
dependencies:
  sliver_grid_view: ^latest
```

import sliver_grid_view file that it will bu used:
```dart
import 'package:sliver_grid_view/sliver_grid_view.dart';
```

there is a example to help you
```dart
  SliverGridView(
    sections: 2,
    persistentHeader: Container(
      color: Colors.cyan,
      alignment: Alignment.center,
      child: const Text('persistent header'),
    ),
    scrollDirection: Axis.vertical,
    controller: ScrollController(),
    sectionClickToScroll: true,
    navigationBarHeight: 64,
    header: Container(
      color: Colors.red,
      height: 100,
      alignment: Alignment.center,
      child: const Text('GridView header'),
    ),
    footer: Container(
      color: Colors.red,
      height: 100,
      alignment: Alignment.center,
      child: const Text('GridView fotter'),
    ),
    gridDelegate: (section) {
      if (section == 0) {
        return const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10);
      } else {
        return const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10);
      }
    },
    rowsInSection: (section) {
      return section + 5;
    },
    itemBuilder: (context, indexPath) {
      return Container(
        color: Colors.blue,
        alignment: Alignment.center,
          child: Text('section: ${indexPath.section}, row: ${indexPath.row}'),
      );
    },
    sectionHeaderBuilder: (section) {
      return Container(
        height: 44,
        color: Colors.amber,
        alignment: Alignment.center,
        child: Text(
          'section：$section header',
        ),
        );
    },
    sectionFooterBuilder: (section) {
      return Container(
        height: 44,
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: Text(
          'section：$section footer',
        ),
        );
    },
  ),
```
