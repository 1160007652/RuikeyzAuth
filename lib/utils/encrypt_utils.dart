import 'dart:convert';
import 'package:dart_des/dart_des.dart';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

class EncryptUtils {
  static const String slat = "www";

  static String desEncrypt(String msg, String key) {
    List<int> encrypted;

    DES desECB = DES(
        key: key.codeUnits,
        mode: DESMode.ECB,
        paddingType: DESPaddingType.PKCS7);
    encrypted = desECB.encrypt(utf8.encode(msg));

    return hex.encode(encrypted);
  }

  static String desDecrypt(String msg, String key) {
    List<int> decrypted;

    DES desECB = DES(
        key: key.codeUnits,
        mode: DESMode.ECB,
        paddingType: DESPaddingType.PKCS7);

    decrypted = desECB.decrypt(hex.decode(msg));

    return utf8.decode(decrypted);
  }

  static String ruikeySign(String msg) {
    String sign = md5.convert(utf8.encode(msg)).toString();
    return sign;
  }
}
