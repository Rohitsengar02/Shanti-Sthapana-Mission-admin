import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunicationsScreen extends StatelessWidget {
  const CommunicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 30),
        _buildQuickActions(),
        const SizedBox(height: 30),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildNotificationHistory()),
              const SizedBox(width: 30),
              Expanded(child: _buildTemplates()),
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
              'Communications',
              style: GoogleFonts.oswald(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Manage notifications, emails, and newsletters',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send),
          label: const Text('COMPOSE MESSAGE'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00D494),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        _actionCard(
          Icons.email,
          'Email Blast',
          '1,856 subscribers',
          const Color(0xFF6C5CE7),
        ),
        _actionCard(
          Icons.chat,
          'SMS / WhatsApp',
          '892 contacts',
          const Color(0xFF25D366),
        ),
        _actionCard(
          Icons.notifications,
          'Push Notification',
          '2,340 devices',
          const Color(0xFFFFB800),
        ),
        _actionCard(
          Icons.newspaper,
          'Newsletter',
          'Monthly digest',
          const Color(0xFF00C7E2),
        ),
      ],
    );
  }

  Widget _actionCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationHistory() {
    final notifications = [
      {
        'type': 'email',
        'title': 'Donation Received Confirmation',
        'recipients': '156',
        'date': 'Dec 30, 2025',
        'status': 'sent',
      },
      {
        'type': 'sms',
        'title': 'Campaign Update: Education Fund',
        'recipients': '892',
        'date': 'Dec 29, 2025',
        'status': 'sent',
      },
      {
        'type': 'push',
        'title': 'New Event: Winter Charity Gala',
        'recipients': '2,340',
        'date': 'Dec 28, 2025',
        'status': 'sent',
      },
      {
        'type': 'email',
        'title': 'Monthly Newsletter - December',
        'recipients': '1,856',
        'date': 'Dec 25, 2025',
        'status': 'sent',
      },
      {
        'type': 'email',
        'title': 'Thank You Message',
        'recipients': '45',
        'date': 'Dec 24, 2025',
        'status': 'scheduled',
      },
    ];

    return Container(
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
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notification History',
                  style: GoogleFonts.oswald(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    _filterChip('All', true),
                    _filterChip('Email', false),
                    _filterChip('SMS', false),
                    _filterChip('Push', false),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) =>
                  _notificationItem(notifications[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF6C5CE7) : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.grey[600],
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _notificationItem(Map<String, String> notification) {
    final typeIcons = {
      'email': Icons.email,
      'sms': Icons.sms,
      'push': Icons.notifications,
    };
    final typeColors = {
      'email': const Color(0xFF6C5CE7),
      'sms': const Color(0xFF25D366),
      'push': const Color(0xFFFFB800),
    };
    final type = notification['type']!;
    final isScheduled = notification['status'] == 'scheduled';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: typeColors[type]!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(typeIcons[type], color: typeColors[type], size: 22),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.people, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 5),
                    Text(
                      '${notification['recipients']} recipients',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      notification['date']!,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isScheduled
                  ? const Color(0xFFFFB800).withOpacity(0.1)
                  : const Color(0xFF00D494).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              notification['status']!.toUpperCase(),
              style: TextStyle(
                color: isScheduled
                    ? const Color(0xFFFFB800)
                    : const Color(0xFF00D494),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {},
            tooltip: 'View Details',
          ),
        ],
      ),
    );
  }

  Widget _buildTemplates() {
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
              Text(
                'Message Templates',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(icon: const Icon(Icons.add), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 20),
          _templateItem(
            'Donation Thank You',
            'Auto-sent after donation',
            Icons.favorite,
            const Color(0xFF00D494),
          ),
          _templateItem(
            'Campaign Update',
            'Progress milestones',
            Icons.campaign,
            const Color(0xFF6C5CE7),
          ),
          _templateItem(
            'Welcome Message',
            'New subscriber welcome',
            Icons.waving_hand,
            const Color(0xFFFFB800),
          ),
          _templateItem(
            'Event Reminder',
            '24h before event',
            Icons.event,
            const Color(0xFF00C7E2),
          ),
          _templateItem(
            'Volunteer Appreciation',
            'Monthly recognition',
            Icons.volunteer_activism,
            const Color(0xFFFF6B6B),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFF8B7CF6)],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: Colors.white),
                    const SizedBox(width: 10),
                    const Text(
                      'Automation',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Set up automated thank-you messages and campaign updates',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6C5CE7),
                    ),
                    child: const Text('CONFIGURE'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _templateItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.edit, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
