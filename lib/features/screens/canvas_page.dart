import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CanvasPage extends StatefulWidget {
  const CanvasPage({super.key});

  @override
  _CanvasPageState createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  List<Offset?> _points = [];
  GlobalKey _globalKey = GlobalKey();
  late Database _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, 'canvas_data.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE canvas(id INTEGER PRIMARY KEY, imagePath TEXT, recognizedText TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _capturePng() async {
    try {
      RenderRepaintBoundary? boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;

      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Save the image to local storage
      String filePath = await _saveImageToLocal(pngBytes);

      // Recognize text
      final recognizedText = await _recognizeText(pngBytes);

      // Save data to local database
      await _database.insert(
        'canvas',
        {'imagePath': filePath, 'recognizedText': recognizedText},
      );

      print("Image & Text Saved Successfully!");
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  Future<String> _saveImageToLocal(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/canvas_${DateTime.now().millisecondsSinceEpoch}.png';
    File file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }

  Future<String> _recognizeText(Uint8List pngBytes) async {
    final inputImage = InputImage.fromBytes(
      bytes: pngBytes,
      metadata: InputImageMetadata(
        size: Size(100, 100), // Adjust size dynamically
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: 100 * 4,
      ),
    );

    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();

    return recognizedText.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Handwriting to Text')),
      body: RepaintBoundary(
        key: _globalKey,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              _points.add(renderBox.globalToLocal(details.globalPosition));
            });
          },
          onPanEnd: (details) {
            setState(() {
              _points.add(null); // Separate strokes with null
            });
          },
          child: CustomPaint(
            painter: DrawingPainter(_points),
            child: Container(color: Colors.white),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _capturePng,
        child: Icon(Icons.save),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) =>
      oldDelegate.points != points;
}
