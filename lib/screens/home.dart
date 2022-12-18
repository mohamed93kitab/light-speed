import 'package:flash/screens/notifications_screen.dart';
import 'package:flash/screens/settings_screen.dart';
import 'package:flash/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toast/toast.dart';

import '../components/toast_component.dart';
import '../config/colors.dart';
import '../helpers/auth_helper.dart';
import '../helpers/shared_value_helper.dart';
import '../lang/appLocalizations.dart';
import '../lang/appLocalizations.dart';
import '../lang/appLocalizations.dart';
import '../main.dart';
import '../repositories/login_repository.dart';
import '../repositories/orders_repository.dart';
import 'orders_by_status.dart';
class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {


  onTapLogout(context) async {
    AuthHelper().clearUserData();

     var logoutResponse = await AuthRepository().getLogoutResponse();
    //
    if (logoutResponse.result == true) {
      ToastComponent.showDialog(logoutResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
        return SignInScreen();
      }),(route)=>false);
    }
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    //   return SignInScreen();
    // }),(route)=>false);
  }

  @override
  bool isCollapsed = true;
  bool _LoadingData = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 200);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  double mainBorderRadius = 0;
  Brightness statusIconColor = Brightness.dark;

  List<dynamic> _orderList = [];
  List<dynamic> _lastWeekOrderList = [];
  int _orderCountList = 0;
  int _orderAmountList = 0;
  int _orderDeliveryAmount = 0;
  int _orderShopAmount = 0;

  int _orderDeliveredCountList = 0;
  int _orderDeliveredAmountList = 0;
  int _orderDeliveredDeliveryAmount = 0;
  int _orderDeliveredShopAmount = 0;

  int _orderCanceledCountList = 0;
  int _orderCanceledAmountList = 0;
  int _orderCanceledDeliveryAmount = 0;
  int _orderCanceledShopAmount = 0;


  fetchOrders() async {
    var orderResponse = await OrderRepository().getOrdersTodayResponse(user_id.$);
    //print("or:"+orderResponse.toJson().toString());
    _orderList.addAll(orderResponse.orders);
    setState(() {
      _LoadingData = false;
    });
  }

  fetchLastWeekOrders() async {
    var orderLtWeekResponse = await OrderRepository().getOrdersWeekResponse(user_id.$);
    //print("or:"+orderResponse.toJson().toString());
    _lastWeekOrderList.addAll(orderLtWeekResponse.orders);
    setState(() {
      _LoadingData = false;
    });
  }

  fetchOrdersCount() async {
    var orderCountResponse = await OrderRepository().getOrdersCountResponse(user_id.$);
    //print("or:"+orderResponse.toJson().toString());
    setState(() {
      _orderCountList = orderCountResponse.data.toInt();
      _orderAmountList = orderCountResponse.totalAmount.toInt();
      _orderDeliveryAmount = orderCountResponse.delivery_amount.toInt();
      _orderShopAmount = orderCountResponse.shop_amount.toInt();
    });
  }
  fetchDeliveredOrdersCount() async {
    var orderDeliveredCountResponse = await OrderRepository().getDeliveredOrdersCountResponse(user_id.$);
    setState(() {
      _orderDeliveredCountList = orderDeliveredCountResponse.data.toInt();
      _orderDeliveredAmountList = orderDeliveredCountResponse.totalAmount.toInt();
      _orderDeliveredDeliveryAmount = orderDeliveredCountResponse.delivery_amount.toInt();
      _orderDeliveredShopAmount = orderDeliveredCountResponse.shop_amount.toInt();
    });
  }
  fetchCanceledOrdersCount() async {
    var orderCanceledCountResponse = await OrderRepository().getCanceledOrdersCountResponse(user_id.$);
    setState(() {
      _orderCanceledCountList = orderCanceledCountResponse.data.toInt();
      _orderCanceledAmountList = orderCanceledCountResponse.totalAmount.toInt();
      _orderCanceledDeliveryAmount = orderCanceledCountResponse.delivery_amount.toInt();
      _orderCanceledShopAmount = orderCanceledCountResponse.shop_amount.toInt();
    });
  }

  Future _onRefresh() async {
    setState(() {
      _orderList.clear();
      fetchOrders();
      fetchLastWeekOrders();
      fetchOrdersCount();
      fetchDeliveredOrdersCount();
      fetchCanceledOrdersCount();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
    fetchOrdersCount();
    fetchDeliveredOrdersCount();
    fetchCanceledOrdersCount();
    fetchLastWeekOrders();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.7).animate(_controller);
    _menuScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget menuItem({
    IconData iconData,
    String title,
    Function onTap,
    bool active = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 0.5 * screenWidth,
        child: Container(
          margin: EdgeInsets.only(
            bottom: 20,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Icon(
                  iconData,
                  color: (active) ? MyTheme.white : MyTheme.light_grey.withOpacity(.6),
                  size: 22,
                ),
              ),
              Expanded(
                flex: 14,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "$title",
                    style: GoogleFonts.cairo(
                      color: (active) ? MyTheme.white : MyTheme.light_grey.withOpacity(.6),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu(context) {
    Locale myLocale = Localizations.localeOf(context);
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: EdgeInsets.only(right : myLocale == "ar" ? 16.0 : 0, top: 40, left: myLocale == "ar" ? 0 : 16),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * .08,),
                IconButton(
                    onPressed: () => setState(() {
                      if (isCollapsed) {
                        mainBorderRadius = 30;
                        statusIconColor = Brightness.light;
                        _controller.forward();
                      } else {
                        _controller.reverse();
                        mainBorderRadius = 0;
                        statusIconColor = Brightness.dark;
                      }
                      isCollapsed = !isCollapsed;
                    }),
                    icon: Icon(Icons.close, color: MyTheme.white,)),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        width: 0.3 * screenWidth,
                        margin: EdgeInsets.only(
                          top: 0,
                          bottom: 10,
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            SizedBox(
                              height: 0.2 * screenWidth,
                              width: 0.2 * screenWidth,
                              child: Container(
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          avatar.$
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Text(
                              user_name.$,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              user_phone.$,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      menuItem(
                        title: AppLocalizations.of(context).getTranslate('home'),
                        iconData: Icons.grid_view_outlined,
                        active: true,
                        onTap: () {}
                      ),
                      menuItem(
                        title: AppLocalizations.of(context).getTranslate('messages'),
                        iconData: Icons.chat_bubble_outline,
                        onTap: () {}
                      ),
                      menuItem(
                        title: AppLocalizations.of(context).getTranslate('settings'),
                        iconData: Icons.settings,
                        onTap: () {
                          setState(() {
                            if (isCollapsed) {
                              mainBorderRadius = 30;
                              statusIconColor = Brightness.light;
                              _controller.forward();
                            } else {
                              _controller.reverse();
                              mainBorderRadius = 0;
                              statusIconColor = Brightness.dark;
                            }
                            isCollapsed = !isCollapsed;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
                        }
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                menuItem(
                  title: AppLocalizations.of(context).getTranslate('logout'),
                  iconData: Icons.exit_to_app,
                  onTap: () {
                    onTapLogout(context);
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget OrderCard({
    String title,
    int amount,
    String orderCount,
   // int deliveryAmount,
    int shopAmount,
    Color backgroundColor,
    Gradient gradientColor,
    Function onTap,
  }) {
    final format = Intl.NumberFormat("#,###", "en_US");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: gradientColor,
          borderRadius: BorderRadius.circular(18),
        ),
        width: MediaQuery.of(context).size.width - 190,
        child: Stack(
          children: <Widget>[
            ListView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
              children: <Widget>[
                Text(
                  '$title',
                  style: GoogleFonts.cairo(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${format.format(amount)} ' + AppLocalizations.of(context).getTranslate('iqd'),
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Text(
                  '$orderCount  ' + AppLocalizations.of(context).getTranslate('order'),
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1.3,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${format.format(shopAmount)} ' + AppLocalizations.of(context).getTranslate('iqd'),
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 1.3,
                      ),
                    ),
                    // Text(
                    //   '${format.format(deliveryAmount)} '+ AppLocalizations.of(context).getTranslate('iqd'),
                    //   style: GoogleFonts.cairo(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 16,
                    //     letterSpacing: 1.3,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget todayList(
      String strDate, {
        bool lastElement: false,
      }) {
    final format = Intl.NumberFormat("#,###", "en_US");

    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          child: Text(
            '$strDate',
            style: GoogleFonts.cairo(
              color: Color(0xffadb2be),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _orderList.length == 0 && _LoadingData == false ?
                 Container(
                  height: 75,
                  child: Center(
                    child: Text(AppLocalizations.of(context).getTranslate('no_today'), style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.light_text.withOpacity(.6)
                    ),),
                  ),
                ) : _orderList.length == 0 && _LoadingData == true ? Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: MyTheme.accent_color,
            size: 50,
          ),
        ) :
        ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 10, 5, (lastElement) ? 40 : 5),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
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
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          _orderList[index].driver_avatar,
                          height: 40,
                          width: 40,
                        ),
                      )
                    ],
                  ),
                  title: Text(
                    "${_orderList[index].code}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                          "${_orderList[index].date} -",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          )
                      ),
                      Text(
                        "${_orderList[index].status}",
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          color: _orderList[index].status == 'قيد التسليم'? MyTheme.accent_color : _orderList[index].status == 'تم التسليم' ? MyTheme.green : MyTheme.danger,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Text(
                        "+${format.format(_orderList[index].amount)} " + AppLocalizations.of(context).getTranslate('iqd'),
                        style: GoogleFonts.cairo(
                            fontSize: 17,
                            color: MyTheme.green,
                            letterSpacing: 0.24,
                            height: 1.6,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "-${format.format(_orderList[index].fee_amount)} " + AppLocalizations.of(context).getTranslate('iqd'),
                        style: GoogleFonts.cairo(
                            fontSize: 14,
                            color: MyTheme.danger,
                            height: 1.2,
                            letterSpacing: 0.24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );

          },
          itemCount: _orderList.length,
        ),
      ],
    );
  }
  Widget weekList(
      String strDate, {
        bool lastElement: false,
      }) {
    final format = Intl.NumberFormat("#,###", "en_US");
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          child: Text(
            '$strDate',
            style: GoogleFonts.cairo(
              color: Color(0xffadb2be),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _lastWeekOrderList.length == 0 && _LoadingData == false ?
        Container(
          height: 75,
          padding: EdgeInsets.fromLTRB(5, 10, 5, (lastElement) ? 40 : 5),
          child: Center(
            child: Text(AppLocalizations.of(context).getTranslate('no_last_week'), style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MyTheme.light_text.withOpacity(.6)
            ),),
          ),
        ) :  _lastWeekOrderList.length == 0 && _LoadingData == true ? Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: MyTheme.accent_color,
            size: 50,
          ),
        ) : ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 10, 5, (lastElement) ? 10 : 5),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,

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
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        _lastWeekOrderList[index].driver_avatar,
                        height: 40,
                        width: 40,
                      ),
                    )
                  ],
                ),
                title: Text(
                  "${_lastWeekOrderList[index].code}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                        "${_lastWeekOrderList[index].date} -",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                    Text(
                      "${_lastWeekOrderList[index].status}",
                      style: GoogleFonts.cairo(
                        fontSize: 13,
                        color: _lastWeekOrderList[index].status == 'قيد التسليم'? MyTheme.accent_color : _lastWeekOrderList[index].status == 'تم التسليم' ? MyTheme.green : MyTheme.danger,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  children: [
                    Text(
                      "+${format.format(_lastWeekOrderList[index].amount)} " + AppLocalizations.of(context).getTranslate('iqd'),
                      style: GoogleFonts.cairo(
                          fontSize: 17,
                          color: MyTheme.green,
                          letterSpacing: 0.24,
                          height: 1.6,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "-${format.format(_lastWeekOrderList[index].fee_amount)} " + AppLocalizations.of(context).getTranslate('iqd'),
                      style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: MyTheme.danger,
                          height: 1.2,
                          letterSpacing: 0.24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _lastWeekOrderList.length,
        ),
      ],
    );
  }

  Widget dashboard(context) {
    Locale myLocale = Localizations.localeOf(context);
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      right: myLocale.toString() == "ar" ? ( isCollapsed ? 0 : 0.5 * screenWidth) : null,
      left: myLocale.toString() == "en" ? ( isCollapsed ? 0 : 0.5 * screenWidth) : null,
      width: screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.only(
              topRight: isCollapsed ? Radius.circular(0) : Radius.circular(26),
              bottomRight: isCollapsed ? Radius.circular(0) : Radius.circular(26)
          ),
          animationDuration: duration,
          color: MyTheme.light,
          child: SafeArea(
              child: Stack(
                children: <Widget>[
                  ListView(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 50,
                        ),
                        decoration: BoxDecoration(
                          color: MyTheme.white,
                          borderRadius: BorderRadius.only(
                            topRight: isCollapsed ? Radius.circular(0) : Radius.circular(26),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.bars,
                                      color: MyTheme.light_text,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (isCollapsed) {
                                          mainBorderRadius = 30;
                                          statusIconColor = Brightness.light;
                                          _controller.forward();
                                        } else {
                                          _controller.reverse();
                                          mainBorderRadius = 0;
                                          statusIconColor = Brightness.dark;
                                        }
                                        isCollapsed = !isCollapsed;
                                      });
                                    },
                                  ),
                                  Text(
                                    AppLocalizations.of(context).getTranslate('dashboard'),
                                    style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/icons/bell.svg",
                                      color: MyTheme.soft_accent_color,
                                      width: 24,
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: (MediaQuery.of(context).size.width - 30) *
                                  (8 / 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(40),
                                ),
                              ),
                              child: PageView(
                                controller: PageController(viewportFraction: 0.9),
                                scrollDirection: Axis.horizontal,
                                pageSnapping: true,
                                children: <Widget>[
                                  OrderCard(
                                    title: AppLocalizations.of(context).getTranslate('on_progress_orders'),
                                    amount: _orderAmountList,
                                   // deliveryAmount: _orderDeliveryAmount,
                                    orderCount: _orderCountList.toString(),
                                    shopAmount: _orderShopAmount,
                                    backgroundColor: MyTheme.accent_color,
                                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersByStatus(1)))
                                  ),
                                  OrderCard(
                                      title: AppLocalizations.of(context).getTranslate('delivered_orders'),
                                      amount: _orderDeliveredAmountList,
                                     // deliveryAmount: _orderDeliveredDeliveryAmount,
                                      orderCount: _orderDeliveredCountList.toString(),
                                      shopAmount: _orderDeliveredShopAmount,
                                      backgroundColor: MyTheme.green,
                                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersByStatus(2)))
                                  ),
                                  OrderCard(
                                      title: AppLocalizations.of(context).getTranslate('canceled_orders'),
                                      amount: _orderCanceledAmountList,
                                     // deliveryAmount: _orderCanceledDeliveryAmount,
                                      orderCount: _orderCanceledCountList.toString(),
                                      shopAmount: _orderCanceledShopAmount,
                                      backgroundColor: MyTheme.danger,
                                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersByStatus(3)))
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            SizedBox(height: 15),
                            Container(
                              padding: EdgeInsets.only(
                                bottom: 16,
                                left: 16,
                                right: 16,
                              ),
                              child: ListView(
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context).getTranslate('all_orders'),
                                        style: GoogleFonts.cairo(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // IconButton(
                                      //   icon: Icon(
                                      //     Icons.settings,
                                      //     color: Color(0xffa4a6b8),
                                      //   ),
                                      //   onPressed: () {},
                                      // ),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  todayList(AppLocalizations.of(context).getTranslate('today')),
                                  weekList(
                                      AppLocalizations.of(context).getTranslate('last_week'),
                                      lastElement: true),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: statusIconColor,
      ),
    );
    return Stack(
      children: <Widget>[
        menu(context),
        dashboard(context),
      ],
    );
  }
}
