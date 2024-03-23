import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_flutter_admin_dashboard/components/card/white_card.dart';
import 'package:free_flutter_admin_dashboard/pages/layout.dart';
import 'package:hexcolor/hexcolor.dart';

class AlertPage extends LayoutWidget {
  @override
  Widget contentWidget(BuildContext context) {
    return WhiteCard(
      padding: EdgeInsets.all(30.w),
      child: Column(
        children: [
          _itemAlert(
              borderColor: HexColor('#FBBF24'),
              color: HexColor('#FEF5DE'),
              icon: Image.asset('images/alert/icon_warn.png',width: 32,),
              title: 'Attention Needed',
              content:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
              titleColor: HexColor('#9D5425'),
              contentColor: HexColor('#D0915C')),
          SizedBox(
            height: 20.h,
          ),
          _itemAlert(
              borderColor: HexColor('#34D399'),
              color: HexColor('#E1F9F0'),
              icon: Image.asset('images/alert/icon_success.png',width: 32,),
              title: 'Attention Needed',
              content:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
              titleColor: HexColor('#004434'),
              contentColor: HexColor('#637381')),
          SizedBox(
            height: 20.h,
          ),
          _itemAlert(
              borderColor: HexColor('#F87171'),
              color: HexColor('#FEEAEA'),
              icon: Image.asset('images/alert/icon_fail.png',width: 32,),
              title: 'Attention Needed',
              content:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
          titleColor: HexColor('#BC1C21'),
          contentColor: HexColor('#CD5D5D')),
        ],
      ),
    );
  }

  @override
  String title() {
    return 'Alerts';
  }

  _itemAlert(
      {required Color borderColor,
      required Color color,
      required Widget icon,
      required String title,
      required String content,
        required Color titleColor,
      required Color contentColor}) {
    return Container(
      height: 120.h,
      color: color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 4.w,
            height: double.maxFinite,
            color: borderColor,
          ),
          SizedBox(
            width: 20.w,
          ),
          icon,
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: titleColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(content,
                    style: TextStyle(color: contentColor, fontSize: 9.sp)),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}