import 'dart:math';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:jlptgrammar/common/global.dart';
import 'package:image/image.dart' as img;

class ShareTool {
  // 返回二进制图片数据
  Future<Uint8List?> capturePngToByte(int index, List list) async {
    RenderRepaintBoundary? boundary = repaintWidgetKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    double dpr = ui.window.devicePixelRatio;
    ui.Image image = await boundary.toImage(pixelRatio: dpr);
    // 拼接图片
    final sourceBytes = await image.toByteData(format: ImageByteFormat.png);
    var headerUint8List = sourceBytes!.buffer.asUint8List();
    headerUint8List = await betterImage(headerUint8List);
    return headerUint8List;
  }

  Future<Uint8List> betterImage(Uint8List headerUint8List) async {
    ByteData qrImgBytes = await rootBundle.load('lib/assets/shareQR.png');
    final qrImgUint8List = qrImgBytes.buffer.asUint8List();
    final img1 = img.decodeImage(headerUint8List);
    final img2 = img.decodeImage(qrImgUint8List);
    final resizedImg2 = img.copyResize(img2!, width: img1!.width);

    final mergedImage = img.Image(img1.width, img1.height + resizedImg2.height);
    img.copyInto(mergedImage, img1, dstY: 0, blend: false);
    img.copyInto(mergedImage, resizedImg2, dstY: img1.height, blend: false);

    headerUint8List = Uint8List.fromList(img.encodePng(mergedImage));
    // print("处理完成");
    return headerUint8List;
  }

  // 分享图片
  Future<bool> shareImage(Uint8List? image) async {
    // path 图片路径
    // 时间戳命名
    final timeName = DateTime.now().toString();
    // 路径
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$timeName.png';
    // print("filePath: $filePath");
    // print("image: $image");
    File file = File(filePath);
    await file.writeAsBytes(image!);
    // print("图片测试");
    final result = await Share.shareXFiles([XFile(filePath)], text: 'Grammar picture');
    try {
      if (result.status == ShareResultStatus.success) {
        // print('分享了一张图片');
        return true;
      } else if (result.status == ShareResultStatus.dismissed) {
        // print("取消分享图片");
        return false;
      } else {
        // 其他操作
        // print("分享失败");
        return false;
      }
    } catch (e) {
      print(e);
    } finally {
      file.deleteSync();
    }
    return false;
  }
}
