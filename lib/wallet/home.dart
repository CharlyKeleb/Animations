import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:test_project/wallet/wallet_screen.dart';

class WalletHome extends StatefulWidget {
  const WalletHome({Key? key}) : super(key: key);

  @override
  _WalletHomeState createState() => _WalletHomeState();
}

class _WalletHomeState extends State<WalletHome> {
  int? page = 0;
  PageController? pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          WalletScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(color: Colors.blueAccent),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Theme.of(context).textTheme.headline6!.color,
        elevation: 50.0,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.card),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.cellular),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person),
            label: "",
          ),
        ],
        onTap: navigationTapped,
        currentIndex: page!,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        child: const Center(
          child: Icon(
            Ionicons.repeat_outline,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    pageController!.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController!.dispose();
  }
}
