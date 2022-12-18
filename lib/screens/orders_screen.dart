import 'package:flash/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../helpers/shared_value_helper.dart';
import '../lang/appLocalizations.dart';
import '../repositories/orders_repository.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  List<dynamic> _allOrdersList = [];
  bool _LoadingData = true;

  fetchAllOrders() async {
    var orderResponse = await OrderRepository().getAllOrdersResponse(user_id.$);
    //print("or:"+orderResponse.toJson().toString());
    _allOrdersList.addAll(orderResponse.orders);
    setState(() {
      _LoadingData = false;
    });
  }

  @override
  void initState() {
    fetchAllOrders();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final format = Intl.NumberFormat("#,###", "en_US");
    return Container(
      color: MyTheme.light,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: _allOrdersList.length == 0 && _LoadingData == false ? Center(
          child: Container(
            height: MediaQuery.of(context).size.height - 50,
            child: Center(
              child: Text(AppLocalizations.of(context).getTranslate('no_orders_found'), style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.light_text.withOpacity(.6)
              ),),
            ),
          ),
        ) : _allOrdersList.length == 0 && _LoadingData == true ?
        Container(
          height: MediaQuery.of(context).size.height - 50,
          child: Center(
            child: LoadingAnimationWidget.fourRotatingDots(
              color: MyTheme.accent_color,
              size: 50,
            ),
          ),
        ) :
        ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
            itemCount: _allOrdersList.length,
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
                          _allOrdersList[index].driver_avatar,
                          height: 40,
                          width: 40,
                        ),
                      )
                    ],
                  ),
                  title: Text(
                    "${_allOrdersList[index].code}",
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
                              "${_allOrdersList[index].date} -",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )
                          ),
                          Text(
                            "${_allOrdersList[index].status}",
                            style: GoogleFonts.cairo(
                              fontSize: 13,
                              color: _allOrdersList[index].status == 'معلقة'? MyTheme.accent_color : _allOrdersList[index].status == 'مسلّمة' ? MyTheme.green : MyTheme.danger,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      Text("${AppLocalizations.of(context).getTranslate('customer')} ${ _allOrdersList[index].customer}", style: GoogleFonts.cairo()),
                      Text("${AppLocalizations.of(context).getTranslate('governorate')}  ${_allOrdersList[index].city}", style: GoogleFonts.cairo()),
                      Text("${AppLocalizations.of(context).getTranslate('address')} ${_allOrdersList[index].address}", style: GoogleFonts.cairo()),
                      Text("${AppLocalizations.of(context).getTranslate('phone')} ${_allOrdersList[index].driver_phone}", style: GoogleFonts.cairo()),
                      Text("${AppLocalizations.of(context).getTranslate('note')} ${_allOrdersList[index].note == null ? '' : _allOrdersList[index].note}", style: GoogleFonts.cairo()),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Text(
                        "+${format.format(_allOrdersList[index].amount)} " + AppLocalizations.of(context).getTranslate('iqd'),
                        style: GoogleFonts.cairo(
                            fontSize: 17,
                            color: MyTheme.green,
                            letterSpacing: 0.24,
                            height: 1.6,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "-${format.format(_allOrdersList[index].fee_amount)} " + AppLocalizations.of(context).getTranslate('iqd'),
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
    );
  }
}
