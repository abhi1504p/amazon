import 'package:flutter/material.dart';
import 'package:frontend/features/account/screens/account_screen.dart';
import 'package:frontend/features/home/screens/home_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:badges/badges.dart' as badges;

class PersistentBottomNavBarDemo extends StatelessWidget {
  const PersistentBottomNavBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: HomeScreen(),
            item: ItemConfig(icon: Icon(Icons.home), title: "Home"),
          ),
          PersistentTabConfig(
            screen: AccountScreen(),
            item: ItemConfig(icon: Icon(Icons.person), title: "Account"),
          ),
          PersistentTabConfig(
            screen: Text("cart"),
            item: ItemConfig(
              icon: badges.Badge(
                position: badges.BadgePosition.custom(top: -10, end: -14),
                badgeContent: Text("3"),
                badgeStyle: const badges.BadgeStyle(
                  elevation: 0,
                  shape: badges.BadgeShape.circle,
                ),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              title: "Settings",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
