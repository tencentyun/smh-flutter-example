import 'package:flutter/material.dart';

class MineListItem extends StatefulWidget {
  MineListItem(
      {Key? key,
      this.iconName,
      this.title,
      this.subTitle,
      this.rightIcon,
      this.clickDetail})
      : super(key: key);
  final String? iconName;
  final String? title;
  final String? subTitle;
  final String? rightIcon;
  VoidCallback? clickDetail;
  @override
  State<StatefulWidget> createState() {
    return _MineListItemState();
  }
}

class _MineListItemState extends State<MineListItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
        child: Container(
          height: 50,
          color: Colors.white,
          padding: EdgeInsets.only(right: 16, left: 16),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                child: widget.iconName != null
                    ? Image(
                        width: 24,
                        height: 24,
                        image: AssetImage(widget.iconName ?? ""),
                      )
                    : null,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title ?? "",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          widget.subTitle ?? "",
                          style: TextStyle(fontSize: 14, color: Colors.black38),
                        )
                      ],
                    ),
                  )),
              Container(
                child: Image(
                  width: 24,
                  height: 24,
                  image: AssetImage(widget.rightIcon ?? ""),
                ),
              ),
            ],
          ),
        ),
        onTap: widget.clickDetail ?? () {});
  }
}
