import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 30),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildFormsList()),
              const SizedBox(width: 30),
              Expanded(child: _buildSubmissions()),
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
              'Forms Management',
              style: GoogleFonts.oswald(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Create and manage forms, view submissions',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('CREATE FORM'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00D494),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildFormsList() {
    final forms = [
      {
        'title': 'Donation Form',
        'submissions': 1256,
        'status': 'active',
        'type': 'donation',
      },
      {
        'title': 'Volunteer Registration',
        'submissions': 342,
        'status': 'active',
        'type': 'volunteer',
      },
      {
        'title': 'Contact Us',
        'submissions': 89,
        'status': 'active',
        'type': 'contact',
      },
      {
        'title': 'Event Registration',
        'submissions': 156,
        'status': 'active',
        'type': 'event',
      },
      {
        'title': 'Feedback Form',
        'submissions': 67,
        'status': 'draft',
        'type': 'feedback',
      },
      {
        'title': 'Newsletter Signup',
        'submissions': 1856,
        'status': 'active',
        'type': 'newsletter',
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
            child: Text(
              'All Forms',
              style: GoogleFonts.oswald(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: forms.length,
              itemBuilder: (context, index) => _formItem(forms[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formItem(Map<String, dynamic> form) {
    final typeIcons = {
      'donation': Icons.attach_money,
      'volunteer': Icons.volunteer_activism,
      'contact': Icons.email,
      'event': Icons.event,
      'feedback': Icons.feedback,
      'newsletter': Icons.newspaper,
    };
    final typeColors = {
      'donation': const Color(0xFF00D494),
      'volunteer': const Color(0xFF6C5CE7),
      'contact': const Color(0xFFFFB800),
      'event': const Color(0xFF00C7E2),
      'feedback': const Color(0xFFFF6B6B),
      'newsletter': Colors.teal,
    };
    final type = form['type'] as String;
    final isActive = form['status'] == 'active';

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
            child: Icon(typeIcons[type], color: typeColors[type], size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  form['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${form['submissions']} submissions',
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF00D494).withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              (form['status'] as String).toUpperCase(),
              style: TextStyle(
                color: isActive ? const Color(0xFF00D494) : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
            tooltip: 'Edit Form',
          ),
          IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {},
            tooltip: 'View Submissions',
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {},
            tooltip: 'Duplicate',
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissions() {
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
          Text(
            'Recent Submissions',
            style: GoogleFonts.oswald(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => _submissionItem(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submissionItem(int index) {
    final forms = [
      'Donation Form',
      'Volunteer Registration',
      'Contact Us',
      'Event Registration',
    ];
    final colors = [
      const Color(0xFF00D494),
      const Color(0xFF6C5CE7),
      const Color(0xFFFFB800),
      const Color(0xFF00C7E2),
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: colors[index % 4].withOpacity(0.1),
              child: Text(
                'U${index + 1}',
                style: TextStyle(
                  color: colors[index % 4],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forms[index % 4],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '${index + 1}h ago',
                    style: TextStyle(color: Colors.grey[500], fontSize: 11),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.arrow_forward_ios, size: 12),
            ),
          ],
        ),
      ),
    );
  }
}
