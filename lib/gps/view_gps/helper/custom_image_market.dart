import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getNetworkImageMarker(String imageUrl) async {
  final Uint8List bytes = await getImageFromUrl(imageUrl);
  final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetHeight: 50, targetWidth: 50);
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  final ByteData? data = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);

  if (data == null) {

    return await getAssetImageMarker();
  }

  final Uint8List resizedBytes = data.buffer.asUint8List();
  final BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(resizedBytes);

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

Future<BitmapDescriptor> getAssetImageMarker() async {
  // Devuelve un marcador de imagen de asset por defecto
  return BitmapDescriptor.asset(
    const ImageConfiguration(devicePixelRatio: 2.5),
    'assets/bozzicon.png',
  );
}

