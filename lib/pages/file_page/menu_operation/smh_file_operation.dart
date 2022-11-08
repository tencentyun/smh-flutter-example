import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';
import 'package:flutter/material.dart';

abstract class SMHFileOperation {
  String? name;

  String? icon;
  SMHFileOperation(this.name, this.icon);
  dynamic handler(List<SMHFileListContent> contents);
}
