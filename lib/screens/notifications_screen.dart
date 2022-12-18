import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../config/colors.dart';
import '../helpers/shared_value_helper.dart';
import '../repositories/notification_repository.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen();

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List _allNotificationsList = [];

  bool _LoadingData = true;

  fetchAllNotifications() async {
    var notificationResponse = await NotificationRepository().getNotificationResponse(user_id.$);
    //print("or:"+orderResponse.toJson().toString());
    _allNotificationsList.addAll(notificationResponse.data);
    setState(() {
      _LoadingData = false;
    });
  }

  @override
  void initState() {
    fetchAllNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MyTheme.light_text,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: MyTheme.white,
        centerTitle: true,
        elevation: 0,
        title: Text("كل الإشعارات", style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyTheme.light_text
        ),),
      ),
      body: Container(
          color: MyTheme.bg_light,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 16, right: 12, left: 12),
          child: SingleChildScrollView(
            child: _allNotificationsList.length == 0 && _LoadingData == false ? Center(
              child: Container(
                height: MediaQuery.of(context).size.height - 80,
                child: Center(
                  child: Text("لا توجد إشعارات", style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.light_text.withOpacity(.6)
                  ),),
                ),
              ),
            ) : _allNotificationsList.length == 0 && _LoadingData == true ?
            Container(
              height: MediaQuery.of(context).size.height - 80,
              child: Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: MyTheme.accent_color,
                  size: 50,
                ),
              ),
            ) :
            ListView.builder(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _allNotificationsList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    color: MyTheme.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: MyTheme.light_text.withOpacity(.08),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  // padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                    title: Text(
                      "${_allNotificationsList[index].title_ar}",
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                        "${_allNotificationsList[index].content_ar}",
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                    trailing: Text(
                      "${_allNotificationsList[index].created_at}",
                      style: GoogleFonts.cairo(
                          fontSize: 17,
                          color: MyTheme.green,
                          letterSpacing: 0.24,
                          height: 1.6,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            )
          )
      ),
    );
  }
}
