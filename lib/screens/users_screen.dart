import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 30),
        TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF6C5CE7),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF6C5CE7),
          tabs: const [
            Tab(text: 'DONORS'),
            Tab(text: 'VOLUNTEERS'),
            Tab(text: 'ADMIN ROLES'),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildDonorsList(),
              _buildVolunteersList(),
              _buildAdminRoles(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Management',
              style: GoogleFonts.oswald(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Manage donors, volunteers, and admin roles',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('EXPORT CSV'),
            ),
            const SizedBox(width: 15),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('ADD USER'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D494),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDonorsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search donors...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list, size: 20),
                      const SizedBox(width: 8),
                      const Text('Filter'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => _donorItem(
                'Donor ${index + 1}',
                'donor${index + 1}@email.com',
                '\$${(index + 1) * 500}',
                index % 3 == 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _donorItem(
    String name,
    String email,
    String totalDonated,
    bool isAnonymous,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.1),
            child: isAnonymous
                ? const Icon(Icons.visibility_off, color: Color(0xFF6C5CE7))
                : Text(
                    name[0],
                    style: const TextStyle(
                      color: Color(0xFF6C5CE7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      isAnonymous ? 'Anonymous Donor' : name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (isAnonymous)
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Anonymous',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                  ],
                ),
                Text(
                  email,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                totalDonated,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00D494),
                  fontSize: 16,
                ),
              ),
              const Text(
                'Total Donated',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(width: 20),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'view', child: Text('View Profile')),
              const PopupMenuItem(
                value: 'history',
                child: Text('Donation History'),
              ),
              const PopupMenuItem(value: 'contact', child: Text('Contact')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVolunteersList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20),
        ],
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 8,
        itemBuilder: (context, index) => _volunteerItem(
          'Volunteer ${index + 1}',
          ['Teaching', 'Medical', 'Event Management', 'Fundraising'][index % 4],
          ['Education Fund', 'Medical Aid', 'Food Drive'][index % 3],
          index % 2 == 0 ? 'approved' : 'pending',
        ),
      ),
    );
  }

  Widget _volunteerItem(
    String name,
    String skill,
    String project,
    String status,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF00D494).withOpacity(0.1),
            child: Text(
              name[0],
              style: const TextStyle(
                color: Color(0xFF00D494),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        skill,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6C5CE7),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Assigned: $project',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: status == 'approved'
                  ? const Color(0xFF00D494).withOpacity(0.1)
                  : const Color(0xFFFFB800).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status.toUpperCase(),
              style: TextStyle(
                color: status == 'approved'
                    ? const Color(0xFF00D494)
                    : const Color(0xFFFFB800),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 15),
          if (status == 'pending') ...[
            IconButton(
              icon: const Icon(Icons.check_circle, color: Color(0xFF00D494)),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.cancel, color: Color(0xFFFF6B6B)),
              onPressed: () {},
            ),
          ] else
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildAdminRoles() {
    final roles = [
      {
        'name': 'Super Admin',
        'users': 2,
        'permissions': 'Full Access',
        'color': const Color(0xFF6C5CE7),
      },
      {
        'name': 'Campaign Manager',
        'users': 5,
        'permissions': 'Campaigns, Content',
        'color': const Color(0xFF00D494),
      },
      {
        'name': 'Content Manager',
        'users': 3,
        'permissions': 'Content, Media',
        'color': const Color(0xFFFFB800),
      },
      {
        'name': 'Finance Admin',
        'users': 2,
        'permissions': 'Donations, Reports',
        'color': const Color(0xFF00C7E2),
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 2,
      ),
      itemCount: roles.length,
      itemBuilder: (context, index) {
        final role = roles[index];
        return Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (role['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.admin_panel_settings,
                      color: role['color'] as Color,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              const Spacer(),
              Text(
                role['name'] as String,
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${role['users']} users • ${role['permissions']}',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }
}
