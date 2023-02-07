import 'package:flutter/material.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onItemSelected;

  const BottomNavigation({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.white,
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemSelected,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home"
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Genres"
        ),
        BottomNavigationBarItem(
          icon: Consumer<AuthProvider>(
            builder: (context, AuthProvider provider, child) {
              if(provider.user == null) {
                return child!;
              }
              String? avatarUrl = getAvatarUrl(provider.user!);
              return CircleAvatar(
                maxRadius: 12, // Same as the icons
                backgroundImage: (avatarUrl != null ? NetworkImage(avatarUrl) : const AssetImage("lib/assets/images/default_avatar.webp")) as ImageProvider,
              );
            },
            child: const Icon(Icons.person),
          ),
          label: "Profile"
        ),
      ]
    );
  }
}
