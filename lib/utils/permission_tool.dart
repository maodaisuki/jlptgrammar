import 'package:permission_handler/permission_handler.dart';

// 存储权限
Future<bool> requestStoragePermission() async {
  // 请求读写存储权限
  PermissionStatus status = await Permission.storage.request();
  return status == PermissionStatus.granted;
}

// 允许安装应用
// bug for 11
Future<bool> requestInstallPermission() async {
  PermissionStatus status = await Permission.requestInstallPackages.request();
  return status == PermissionStatus.granted;
}
