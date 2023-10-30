import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:jlptgrammar/common/global.dart';


class ShareTool {
  // 返回二进制图片数据
  Future<Uint8List?> capturePngToByte(int index, List list) async {
    RenderRepaintBoundary? boundary = repaintWidgetKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    double dpr = ui.window.devicePixelRatio;
    ui.Image image = await boundary.toImage(pixelRatio: dpr);
    final sourceBytes = await image.toByteData(format: ImageByteFormat.png);
    print(sourceBytes!.buffer.asUint8List());
    return sourceBytes!.buffer.asUint8List();
  }

  // 数据转图片
  // TODO
  Future<Image?> pngToImage(Uint8List source) async {
    try {
      Image image = Image.memory(source);
      print("转换图片成功！");
      return image;
    }
    catch(e) {
      print("转换图片失败");
    }
    // 转换失败
    return null;
  }

  // 二次加工图片
  // TODO
  Future<ByteData?> betterImage() async {

  }

  // 分享图片
  Future<bool> shareImage(Uint8List? image) async {
    // path 图片路径
    // TODO 只传图片数据
    //时间戳命名
    final timeName = DateTime.now().toString();
    // 路径
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$timeName.png';

    print("filePath: $filePath");
    print("image: $image");

    File file = File(filePath);
    await file.writeAsBytes(image!);

    print("图片测试");


    final result = await Share.shareXFiles([XFile(filePath)], text: 'Grammar picture');
    if (result.status == ShareResultStatus.success) {
      print('分享了一张图片');
      return true;
    }
    else if(result.status == ShareResultStatus.dismissed) {
      print("取消分享图片");
      return false;
    }
    else {
      // 其他操作
      // TODO 处理其他情况
      print("分享失败");
      return false;
    }
  }
}
