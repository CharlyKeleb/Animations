import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final quickLinkArrayList = [
    QuickLink(title: 'Send', icon: const Icon(Ionicons.repeat_outline)),
    QuickLink(title: 'Bills', icon: const Icon(Ionicons.card_outline)),
    QuickLink(
      title: 'TopUp',
      icon: const Icon(Ionicons.phone_portrait_outline),
    ),
    QuickLink(title: 'Ticket', icon: const Icon(Ionicons.ticket_outline)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 20.0,
            backgroundImage: AssetImage('assets/images/users/cm0.jpeg'),
          ),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Ionicons.notifications),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        children: [

          SizedBox(
            height: 200.0,
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: Container(
                    height: 50.0,
                    width: 45.0,
                    color: Colors.blueAccent,
                    child: const Center(
                      child: Icon(
                        Ionicons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    height: 175.0,
                    width: 340.0,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              const Text('Card Balance'),
                              const SizedBox(width: 5.0),
                              const Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Icon(
                                  Ionicons.eye,
                                  size: 14.0,
                                ),
                              ),
                              const Spacer(),
                              Image.asset(
                                'assets/images/mastercard.png',
                                height: 40.0,
                                width: 40.0,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                          const Text(
                            '\$40,533.89',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 25.0),
                          const Text(
                            '**** **** **** 7310',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Quick Links',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildQuickList(),
          const SizedBox(height: 10.0),
          const Text(
            'Send To',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildSendTo(),
          const SizedBox(height: 10.0),
          const Text(
            'Recent Transactions',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildRecentTransactions()
        ],
      ),
    );
  }

  _buildQuickList() {
    return SizedBox(
      height: 40.0,
      // color: Colors.amber,
      child: ListView.builder(
        itemCount: quickLinkArrayList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              height: 10.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xffD0D0D0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    quickLinkArrayList[index].icon,
                    Text(
                      quickLinkArrayList[index].title,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildSendTo() {
    int count = 5;
    return SizedBox(
      height: 80.0,
      child: ListView.builder(
        itemCount: count + 1,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 20.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.blueAccent,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage(
                      'assets/images/users/cm${Random().nextInt(3)}.jpeg',
                    ),
                  ),
                ),
                const Text('Chris')
              ],
            ),
          );
        },
      ),
    );
  }

  _buildRecentTransactions() {
    return SizedBox(
      child: ListView.builder(
        itemCount: 7,
        padding: const EdgeInsets.all(0.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.all(0.0),
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.green,
              backgroundImage: AssetImage(
                'assets/images/users/cm${Random().nextInt(4)}.jpeg',
              ),
            ),
            title: const Text('John Doe'),
            subtitle: const Text('22 June 10:30pm'),
            trailing: const Text(
              '+\$1300.00',
              style: TextStyle(color: Colors.green),
            ),
          );
        },
      ),
    );
  }
}

class QuickLink {
  final String title;
  final Icon icon;

  QuickLink({required this.title, required this.icon});
}
