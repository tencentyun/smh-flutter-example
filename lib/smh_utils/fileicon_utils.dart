import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';

class FileIconUtils {
  static Map<String, dynamic> map = {
    'image': 'assets/images/fileicon/pic.png',
    'powerpoint': 'assets/images/fileicon/ppt.png',
    'word': 'assets/images/fileicon/word.png',
    'text': 'assets/images/fileicon/txt.png',
    'known': 'assets/images/fileicon/other.png',
    '': 'assets/images/fileicon/other.png',
    'audio': 'assets/images/fileicon/audio.png',
    'video': 'assets/images/fileicon/video.png',
    'archive': 'assets/images/fileicon/zip.png',
    'portable': 'assets/images/fileicon/pdf.png',
    'excel': 'assets/images/fileicon/excel.png',
    'dir': 'assets/images/fileicon/dir.png',
  };

  static getFileIcon(String? type) {
    if (type == null) {
      return 'assets/images/fileicon/other.png';
    }
    if (map[type] != null) {
      return map[type];
    } else {
      return 'assets/images/fileicon/other.png';
    }
  }

  static getFileType(String fileName) {
    if (fileName.split('.').length < 2) {
      return SMHFileType.other;
    }
    String type = fileName.split('.').last.toLowerCase();
    if (['psd'].contains(type)) {
      return SMHFileType.psd;
    }
    if (['txt', 'rtf'].contains(type)) {
      return SMHFileType.text;
    }
    if (["wps", "doc", "docx", "dot", "wps", "wpt", "dotx", "docm", "dotm"]
        .contains(type)) {
      return SMHFileType.word;
    }

    if ([
      "ppt",
      "keynote",
      "pptx",
      "pot",
      "potx",
      "pps",
      "ppsx",
      "dps",
      "dpt",
      "pptm",
      "potm",
      "ppsm"
    ].contains(type)) {
      return SMHFileType.portable;
    }

    if (["jpg", "jpeg", "png", "bmp", "gif", "mac", "heic", "ico", "tif"]
        .contains(type)) {
      return SMHFileType.image;
    }

    if (["pdf"].contains(type)) {
      return SMHFileType.portable;
    }

    if (["mp3", "ogg", "aac", "wma", "wav", "ape", "flag"].contains(type)) {
      return SMHFileType.audio;
    }

    if (["avi", "wmv", "mpeg", "rm", "rmvb", "mkv", "mov", "qt", "mp4"]
        .contains(type)) {
      return SMHFileType.video;
    }

    if (["xls", "xlsx", "et"].contains(type)) {
      return SMHFileType.excel;
    }
    if (["zip", "tar", "gz"].contains(type)) {
      return SMHFileType.archive;
    }
    if (["md", "markdown"].contains(type)) {
      return SMHFileType.text;
    }
    if (["dir"].contains(type)) {
      return SMHFileType.dir;
    }
    return SMHFileType.other;
  }
}
