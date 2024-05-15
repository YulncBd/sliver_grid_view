import 'package:flutter/material.dart';
import 'package:sliver_grid_view/sliver_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SliverGridView(
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
            return const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10);
          } else {
            return const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10);
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
    );
  }
}
