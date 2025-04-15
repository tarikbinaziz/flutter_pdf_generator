import 'package:flutter/material.dart';
import 'package:flutter_pdf_generate/pdf_api.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final pdf = pw.Document();
                pdf.addPage(
                  pw.Page(
                    build:
                        (pw.Context context) =>
                            pw.Center(child: pw.Text('Hello World')),
                  ),
                );
                final file = await PdfApi.saveDocument(
                  name: 'hello.pdf',
                  pdf: pdf,
                );
                PdfApi.openFile(file);
              },
              child: const Text('generate PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
