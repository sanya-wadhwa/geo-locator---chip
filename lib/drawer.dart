import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const imageUrl =
        "https://files.worldwildlife.org/wwfcmsprod/images/Lion_WWFGIFTS_cover_2020/magazine_small/2wafu1bmcz_b21fc8e6.jpeg";
    return Drawer(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            const DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(color: Colors.white),
                accountName: Text(
                  "Sanya Wadhwa",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
                accountEmail: Text(
                  "sanyawadhwa@gmail.com",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.home, color: Colors.black54),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.profile_circled,
                  color: Colors.black54),
              title: const Text(
                "Create An Account",
                style: TextStyle(color: Colors.black54),
              ),
              onTap: () {},
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.mail, color: Colors.black54),
              title: Text(
                "Login",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const ListTile(
              leading:
                  Icon(CupertinoIcons.shopping_cart, color: Colors.black54),
              title: Text(
                "Shopping",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.phone, color: Colors.black54),
              title: Text(
                "Contact Us",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.search, color: Colors.black54),
              title: Text(
                "Search Anything",
                style: TextStyle(color: Colors.black54),
              ),
            )
          ],
        ),
      ),
    );
  }
}
