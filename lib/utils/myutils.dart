import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MyUtils {
  static void copyToClipboard(BuildContext context, String string) {
    if(string != null && string.isNotEmpty) {
      Clipboard.setData(new ClipboardData(text: string));
      //MyToast.normalMsg("Copied", context);
    }
  }

  /*static String getCachedFirebaseImageUrlFromUrl(String url) {
    if(url.startsWith("https://storage.googleapis.com/")) {
      return url;
    }
    else if(url.startsWith("https://firebasestorage.googleapis.com/")) {
      String bucketName = Firebase.app().options.storageBucket ?? "my-image-editor-7eaeb.appspot.com";

      String newUrl = url;
      newUrl = newUrl.replaceAll(newUrl.substring(0, newUrl.indexOf(bucketName)), "https://storage.googleapis.com/");
      newUrl = newUrl.replaceAll("%2F", "/");
      newUrl = newUrl.replaceAll("/o/", "/");
      newUrl = newUrl.substring(0, newUrl.indexOf("?"));
      //MyPrint.printOnConsole("newUrl:${newUrl}");

      return newUrl;
    }
    else {
      return url;
    }
  }*/

  /*static Future<void> enableDisableCapture({required bool isEnabled}) async {
    if(isEnabled) {
      await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    }
    else {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  }*/
}