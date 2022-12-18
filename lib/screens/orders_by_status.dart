import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../config/colors.dart';
import '../helpers/shared_value_helper.dart';
import '../lang/appLocalizations.dart';
import '../repositories/orders_repository.dart';
class OrdersByStatus extends StatefulWidget {
  final status_id;
  OrdersByStatus(this.status_id);

  @override
  State<OrdersByStatus> createState() => _OrdersByStatusState();
}

class _OrdersByStatusState extends State<OrdersByStatus> {
  List _orders = [];
  bool _LoadingData = true;

  fetchOrders() async {
    var ordersResponse = await OrderRepository().getOrdersByStatusResponse(user_id.$, widget.status_id);
    //print("or:"+orderResponse.toJson().toString());
    _orders.addAll(ordersResponse.orders);
    setState(() {
      _LoadingData = false;
    });
  }

  @override
  void initState() {
    fetchOrders();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final format = Intl.NumberFormat("#,###", "en_US");


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
        title: Text(AppLocalizations.of(context).getTranslate('orders'), style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyTheme.light_text
        ),),
      ),
      body: Container(
        color: MyTheme.light,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: SingleChildScrollView(
          child: _orders.length == 0 && _LoadingData == false ? Center(
            child: Container(
              height: MediaQuery.of(context).size.height - 80,
              child: Center(
                child: Text("لا توجد طلبات", style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.light_text.withOpacity(.6)
                ),),
              ),
            ),
          ) : _orders.length == 0 && _LoadingData == true ?
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
            itemCount: _orders.length,
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
                          _orders[index].driver_avatar,
                          height: 40,
                          width: 40,
                        ),
                      )
                    ],
                  ),
                  title: Text(
                    "${_orders[index].code}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              "${_orders[index].date} -",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )
                          ),
                          Text(
                            "${_orders[index].status}",
                            style: GoogleFonts.cairo(
                              fontSize: 13,
                              color: _orders[index].status == 'قيد التسليم'? MyTheme.accent_color : _orders[index].status == 'تم التسليم' ? MyTheme.green : MyTheme.danger,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      Text(AppLocalizations.of(context).getTranslate('customer') + _orders[index].customer, style: GoogleFonts.cairo()),
                      Text(AppLocalizations.of(context).getTranslate('governorate') + _orders[index].city, style: GoogleFonts.cairo()),
                      Text(AppLocalizations.of(context).getTranslate('address') + _orders[index].address, style: GoogleFonts.cairo()),
                      Text(AppLocalizations.of(context).getTranslate('phone') + _orders[index].driver_phone, style: GoogleFonts.cairo()),
                      Text(AppLocalizations.of(context).getTranslate('note') + _orders[index].note, style: GoogleFonts.cairo()),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Text(
                        "+${format.format(_orders[index].amount)} " + AppLocalizations.of(context).getTranslate('iqd'),
                        style: GoogleFonts.cairo(
                            fontSize: 17,
                            color: MyTheme.green,
                            letterSpacing: 0.24,
                            height: 1.6,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "-${format.format(_orders[index].fee_amount)} " + AppLocalizations.of(context).getTranslate('iqd'),
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
          ),
        ),
      )
    );
  }
}
