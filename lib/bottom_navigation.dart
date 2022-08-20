import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_management/screens/buySell/buySell.dart';
import 'package:portfolio_management/screens/dashboard/dashboard.dart';
import 'package:portfolio_management/screens/transactions/transactions.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigation extends StatefulWidget {
  int currentIndx;
  BottomNavigation({Key? key, required this.currentIndx}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  PageController _pageController = PageController();
  var screens = [
    Transactions(),
    Dashboard(),
    BuySell(),
  ];

  @override
  void initState() {
    super.initState();
    //_pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double btmNavIconSize = size.height / 25;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height / 10,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
                child: Text(
                  'Good ' + greeting() + ', Samaira!',
                  style: GoogleFonts.poppins(
                      fontSize: size.width / 20, fontWeight: FontWeight.w500),
                ),
              ),
              CircleAvatar(
                radius: size.width / 10,
                backgroundColor: Colors.deepOrange[500],
                child: ClipOval(
                  child: Image.network(
                    'https://d2qp0siotla746.cloudfront.net/img/use-cases/profile-picture/template_3.jpg',
                    fit: BoxFit.cover,
                    width: size.width / 5,
                    height: size.width / 5,
                  ),
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 4, 151, 110),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => widget.currentIndx = index);
        },
        children: <Widget>[
          screens[widget.currentIndx],
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 20),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color.fromARGB(255, 4, 151, 110),
            unselectedItemColor: Colors.black,
            selectedFontSize: size.width / 40,
            unselectedFontSize: size.width / 40,
            // backgroundColor: Colors.deepOrange[50],
            backgroundColor: Colors.white,
            elevation: 20.0,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            currentIndex: widget.currentIndx,
            showUnselectedLabels: false,
            onTap: _onItemTapped,

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                // backgroundColor: Colors.amber,
                icon: Icon(
                  Icons.history,
                  size: btmNavIconSize,
                ),
                label: 'TRANSACTIONS',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                  size: btmNavIconSize,
                ),
                label: 'DASHBOARD',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.sync_alt,
                  size: btmNavIconSize,
                ),
                label: 'BUY/SELL',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.currentIndx = index;
      //using this page controller you can make beautiful animation effects
      // _pageController.animateToPage(index,
      //     duration: Duration(milliseconds: 1000), curve: Curves.easeInSine);
    });
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning';
    }
    if (hour < 17) {
      return 'afternoon';
    }
    return 'evening';
  }
}
