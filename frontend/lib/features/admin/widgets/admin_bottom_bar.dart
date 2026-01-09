import 'package:flutter/material.dart';
import 'package:frontend/features/admin/screens/post_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class AdminBottomBar extends StatelessWidget {
  const AdminBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: PostScreen(),
            item: ItemConfig(icon: Icon(Icons.home), title: "Home"),
          ),
          PersistentTabConfig(
            screen: Text("inbox"),
            item: ItemConfig(
              icon: Icon(Icons.all_inbox_outlined),
              title: "Inbox",
            ),
          ),
          PersistentTabConfig(
            screen: Text("cart"),
            item: ItemConfig(
              icon: const Icon(Icons.analytics_outlined),
              title: "Analytics",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(5),
          ),
        ),

    );
  }
}
