import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:learning/core/resources/apis.dart';
import 'package:learning/core/resources/images.dart';

class ResourceManager {
  static Future<String> getResource(String name, {ResourceType? type}) async {
    List<String> nameStringList = name.split('.');

    // create a function

    String path = 'assets/${_getResourceDirectory(nameStringList[nameStringList.length - 1], type: type)}/$name';

    try {
      await rootBundle.load(path);
    } catch (e) {
      if (nameStringList[nameStringList.length - 1] == "svg" || type == ResourceType.svg) {
        return getResource(noneSvg, type: ResourceType.svg);
      }
      if (nameStringList[nameStringList.length - 1] == "json" || type == ResourceType.map) {
        return getResource(map1, type: ResourceType.map);
      }
      return getResource(noneImg, type: ResourceType.image);
    }
    return path;
  }

  static String _getResourceDirectory(String ext, {ResourceType? type}) {
    if (type != null) {
      switch (type) {
        case ResourceType.image:
          return 'image';
        case ResourceType.svg:
          return 'svg';
        case ResourceType.lottie:
          return 'lottie';
        case ResourceType.map:
          return 'map';
      }
    } else {
      switch (ext) {
        case "svg":
          return 'svg';
        case "json":
          return 'map';
        default:
          return 'image';
      }
    }
  }

  static getAssetResource(String name, {ResourceType? type}) {
    List<String> nameStringList = name.split('.');
    return 'assets/${_getResourceDirectory(nameStringList[nameStringList.length - 1], type: type)}/$name';
  }

  static getNetworkResource(String name) {
    return "$host:$port$name";
  }
}

enum ResourceType {
  image,
  svg,
  map,
  lottie,
}
