import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final String userName;
  final String userEmail;

  const DrawerMenu(
      {required this.userName, required this.userEmail, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                userName.substring(0, 2).toUpperCase(),
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              // Handle profile tap
            },
          ),
          ListTile(
            leading: Icon(Icons.card_membership),
            title: Text('Membership'),
            onTap: () {
              // Handle membership tap
            },
          ),
          ListTile(
            leading: Icon(Icons.bluetooth),
            title: Text('Pair device'),
            onTap: () {
              // Handle pair device tap
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle settings tap
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Shop'),
            onTap: () {
              // Handle shop tap
            },
          ),
          ListTile(
            leading: Icon(Icons.report_problem),
            title: Text('Report an issue'),
            onTap: () {
              // Handle report an issue tap
            },
          ),
          ListTile(
            leading: Icon(Icons.new_releases),
            title: Text("What's new"),
            onTap: () {
              // Handle what's new tap
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              // Handle help tap
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () {
              // Handle log out tap
            },
          ),
        ],
      ),
    );
  }
}
