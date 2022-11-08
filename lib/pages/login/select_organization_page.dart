import 'package:flutter/material.dart';
import 'package:smh_flutter_sdk/model/user_model/smh_organization_info.dart';

import '../../config/colours.dart';
import '../../config/styles.dart';

class SelectOrganizationPage extends StatelessWidget {
  final List<SMHOrganizationInfoOrganizations> infos;
  final Function(SMHOrganizationInfoOrganizations result) callBack;
  SelectOrganizationPage(this.infos, this.callBack);
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
              '选择企业',
              style: TextStyles.title,
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: infos.length,
              itemExtent: 50,
              itemBuilder: (BuildContext context, int index) {
                SMHOrganizationInfoOrganizations orgInfo = infos[index];
                return GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                    child: Text(
                      orgInfo.name!,
                      style: TextStyles.title,
                    ),
                  ),
                  onTap: () {
                    this.callBack(orgInfo);
                  },
                );
              })
        ],
      ),
    );
  }
}
