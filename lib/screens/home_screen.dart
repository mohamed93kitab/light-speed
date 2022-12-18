import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/colors.dart';
import '../lang/appLocalizations.dart';
import 'home.dart';
import 'notifications_screen.dart';
import 'orders_screen.dart';

class MenuDashboardPage extends StatefulWidget {
  const MenuDashboardPage();
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> {



  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const OrdersScreen(),
  ];


  Widget bottomBar() {
    return Align(
      alignment: Alignment(-1, 1),
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyTheme.light_text.withOpacity(.07),
              offset: Offset(-2, -5),
              blurRadius: 5
            )
          ],
          color: MyTheme.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: IconButton(
                  highlightColor: MyTheme.danger,
                  splashColor: MyTheme.accent_color,
                  icon: Icon(
                    Icons.home,
                    color: Color(0xffa1a5b5),
                  ),
                  iconSize: 28,
                  onPressed: () {},
                )),
            Expanded(
              flex: 1,
              child: IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.swap_horiz,
                  color: Color(0xffa1a5b5),
                  size: 28,
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.show_chart,
                  color: Color(0xffa1a5b5),
                ),
                iconSize: 28,
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.notifications_none,
                  color: Color(0xffa1a5b5),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.person_outline,
                  color: Color(0xffa1a5b5),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.dark_bg,
      appBar: _selectedIndex == 1 ? AppBar(
        backgroundColor: MyTheme.white,
        centerTitle: true,
        elevation: 0,
        title: Text(AppLocalizations.of(context).getTranslate('orders'), style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyTheme.light_text
        ),),
      ) : null,
      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: GoogleFonts.cairo(),
        unselectedLabelStyle: GoogleFonts.cairo(),
        backgroundColor: MyTheme.white,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        selectedItemColor: MyTheme.accent_color,
        unselectedItemColor: MyTheme.light_text.withOpacity(.6),
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/dashboard.svg", width: 32, color: _selectedIndex == 0 ? MyTheme.accent_color : MyTheme.light_text.withOpacity(.6),),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/list-order.svg", width: 32, color: _selectedIndex == 1 ? MyTheme.accent_color : MyTheme.light_text.withOpacity(.6)),
            label: 'الطلبات',
          ),

        ],
      ),
    );
  }
}
