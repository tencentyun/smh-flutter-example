import 'package:smh_flutter_sdk/model/enum/smh_string_enum.dart';

import 'package:flutter/material.dart';
import 'package:smh_flutter_sdk/model/user_model/s_m_h_favorite_file_list_entity.dart';

import '../config/colours.dart';
import '../config/styles.dart';
import '../pages/file_page/menu_operation/smh_file_delete.dart';
import '../pages/file_page/menu_operation/smh_file_detail.dart';
import '../pages/file_page/menu_operation/smh_file_download.dart';
import '../pages/file_page/menu_operation/smh_file_operation.dart';

class SMHFileMenu extends StatelessWidget {
  late SMHFileListContent content;

  Function? finishCallBack;

  final List<SMHFileOperation> operations = [];

  SMHFileMenu(SMHFileListContent content, {this.finishCallBack}) {
    this.content = content;
    operations.add(SMHFileDetail());

    if (content.type?.name != SMHFileType.dir.name &&
        content.authorityList?.canDownload == true) {
      operations.add(SMHFileDownload());
    }

    if (content.authorityList?.canDelete == true)
      operations.add(SMHFileDelete());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colours.backgroundColorEEE,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Wrap(
        children: [
          ListTile(
            title: Text(
              content.name!,
              style: TextStyles.title,
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: operations.length,
              itemExtent: 50,
              itemBuilder: (BuildContext context, int index) {
                SMHFileOperation item = operations[index];
                return GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Image.asset(
                          item.icon!,
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(
                              item.name!,
                              style: TextStyles.title,
                            ))
                      ],
                    ),
                  ),
                  onTap: () {
                    item.handler([content]);
                    if (this.finishCallBack != null) {
                      this.finishCallBack!();
                    }
                  },
                );
              })
        ],
      ),
    );
  }
}
