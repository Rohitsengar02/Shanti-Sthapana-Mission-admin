import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'screens/dashboard_screen.dart';
import 'screens/users_screen.dart';
import 'screens/campaigns_screen.dart';
import 'screens/donations_screen.dart';
import 'screens/volunteers_screen.dart';
import 'screens/events_screen.dart';
import 'screens/content_screen.dart';
import 'screens/media_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/communications_screen.dart';
import 'screens/forms_screen.dart';
import 'screens/compliance_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/logs_screen.dart';

void main() {
  runApp(const NGOAdminApp());
}

class NGOAdminApp extends StatelessWidget {
  const NGOAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helpes Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF6C5CE7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C5CE7),
          primary: const Color(0xFF6C5CE7),
          secondary: const Color(0xFF00D494),
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const AdminPortal(),
    );
  }
}

class AdminPortal extends StatefulWidget {
  const AdminPortal({super.key});

  @override
  State<AdminPortal> createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.dashboard_outlined, 'label': 'Dashboard'},
    {'icon': Icons.people_outline, 'label': 'Users'},
    {'icon': Icons.campaign_outlined, 'label': 'Campaigns'},
    {'icon': Icons.volunteer_activism_outlined, 'label': 'Donations'},
    {'icon': Icons.group_outlined, 'label': 'Volunteers'},
    {'icon': Icons.event_outlined, 'label': 'Events'},
    {'icon': Icons.article_outlined, 'label': 'Content'},
    {'icon': Icons.perm_media_outlined, 'label': 'Media'},
    {'icon': Icons.analytics_outlined, 'label': 'Reports'},
    {'icon': Icons.mail_outline, 'label': 'Communications'},
    {'icon': Icons.dynamic_form_outlined, 'label': 'Forms'},
    {'icon': Icons.verified_outlined, 'label': 'Compliance'},
    {'icon': Icons.settings_outlined, 'label': 'Settings'},
    {'icon': Icons.history_outlined, 'label': 'Logs'},
  ];

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const UsersScreen();
      case 2:
        return const CampaignsScreen();
      case 3:
        return const DonationsScreen();
      case 4:
        return const VolunteersScreen();
      case 5:
        return const EventsScreen();
      case 6:
        return const ContentScreen();
      case 7:
        return const MediaScreen();
      case 8:
        return const ReportsScreen();
      case 9:
        return const CommunicationsScreen();
      case 10:
        return const FormsScreen();
      case 11:
        return const ComplianceScreen();
      case 12:
        return const SettingsScreen();
      case 13:
        return const LogsScreen();
      default:
        return const DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: _selectedIndex == 0
                      ? _getScreen(_selectedIndex)
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(30),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 130,
                            child: _getScreen(_selectedIndex),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 260,
      color: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.handHoldingHeart,
                color: Color(0xFF00D494),
                size: 26,
              ),
              const SizedBox(width: 12),
              Text(
                'Helpes Admin',
                style: GoogleFonts.fredoka(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                final isSelected = _selectedIndex == index;
                return InkWell(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF6C5CE7)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item['icon'],
                          color: isSelected ? Colors.white : Colors.white54,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item['label'],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white54,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFF6C5CE7),
                    child: Text('A', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Admin User',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Super Admin',
                          style: TextStyle(color: Colors.white54, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.logout, color: Colors.white54, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      color: Colors.white,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _menuItems[_selectedIndex]['label'],
                style: GoogleFonts.oswald(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Welcome back, Admin!',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 20, color: Colors.grey),
                const SizedBox(width: 10),
                Text('Search...', style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.notifications_none, size: 22),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6B6B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
