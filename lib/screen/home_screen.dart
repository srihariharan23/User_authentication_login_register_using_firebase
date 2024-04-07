import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    SizedBox(
        width: 400,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color(0xFF202038), Colors.greenAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("SIGNAL STRENGTH",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    Text("95%",
                        style: TextStyle(color: Colors.white, fontSize: 45)),
                    SizedBox(
                        width: 150,
                        height: 50,
                        child: Card(
                          color: Colors.blueGrey,
                          shape: RoundedRectangleBorder(),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("GOOD",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 25)),
                                Icon(
                                  Icons.gpp_good_outlined,
                                  size: 25,
                                  color: Colors.green,
                                ),
                              ]),
                        ))
                  ],
                )))),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Maintenance\n Screen",
            style: TextStyle(color: Colors.white, fontSize: 40)),
        Icon(
          Icons.cloud_sync_sharp,
          size: 150,
          color: Colors.white,
        ),
      ],
    ),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Diagnostics",
            style: TextStyle(color: Colors.white, fontSize: 40)),
        Icon(
          Icons.search_off_outlined,
          size: 150,
          color: Colors.white,
        ),
      ],
    ),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Settings", style: TextStyle(color: Colors.white, fontSize: 40)),
        Icon(
          Icons.settings,
          size: 150,
          color: Colors.white,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202038),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                  ),
                  const Text('Welcome back!'),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.electric_meter_outlined,
              ),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.call_split_outlined,
              ),
              title: const Text('Maintenance'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.search_off_outlined,
              ),
              title: const Text('Diagnostics'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.electric_meter_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.call_split_outlined),
            label: 'Maintenance',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.search_off_outlined),
            label: 'Diagnostics',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.red,
        elevation: 5,
        actions: [
          TextButton(
            child: const Text(
              "Log out",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginView()));
              });
            },
          ),
        ],
        title: Image.asset(
          'assets/logo.png',
          fit: BoxFit.cover,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
