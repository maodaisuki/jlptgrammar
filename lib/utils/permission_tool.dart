import 'package:permission_handler/permission_handler.dart';

// 存储权限
Future<bool> requestStoragePermission() async {
  // 请求读写存储权限
  PermissionStatus status = await Permission.storage.request();
  print("请求存储权限 ${status == PermissionStatus.granted}");
  return status == PermissionStatus.granted;
}