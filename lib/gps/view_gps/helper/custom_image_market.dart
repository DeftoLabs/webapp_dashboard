import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

Future<BitmapDescriptor> getNetworkImageMarker(String imageUrl) async {
  final Uint8List bytes = await getImageFromUrl(imageUrl);
  final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetHeight: 50, targetWidth: 50);
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  final ByteData? data = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);

  final Uint8List resizedBytes = data!.buffer.asUint8List();
  final Uint8List circularBytes = await _getCircularImageWithBorder(
    resizedBytes, 
    Colors.black54, // Define the color of the border
    5.0 // Define the width of the border
  );

  final BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(circularBytes);

  return bitmapDescriptor;
}

Future<Uint8List> getImageFromUrl(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else {
    throw Exception('Failed to load image');
  }
}

Future<Uint8List> _getCircularImageWithBorder(Uint8List imageBytes, Color borderColor, double borderWidth) async {
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(imageBytes, (ui.Image img) {
    return completer.complete(img);
  });
  final ui.Image image = await completer.future;

  const double size = 50.0;
  final double borderSize = size + borderWidth * 2;

  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder);

  final Paint borderPaint = Paint()
    ..isAntiAlias = true
    ..color = borderColor;
  
  final Paint imagePaint = Paint()
    ..isAntiAlias = true
    ..shader = ImageShader(image, TileMode.clamp, TileMode.clamp, Float64List.fromList([
      size / image.width, 0, 0, 0,
      0, size / image.height, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    ]));

  // Draw border circle
  canvas.drawCircle(
    Offset(borderSize / 2, borderSize / 2),
    borderSize / 2,
    borderPaint,
  );

  // Draw image circle inside the border
  canvas.drawCircle(
    Offset(borderSize / 2, borderSize / 2),
    size / 2,
    imagePaint,
  );

  final ui.Picture picture = recorder.endRecording();
  final ui.Image img = await picture.toImage(borderSize.toInt(), borderSize.toInt());
  final ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}
