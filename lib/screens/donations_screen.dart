import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonationsScreen extends StatelessWidget {
  const DonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 30),
        _buildStats(),
        const SizedBox(height: 30),
        Expanded(child: _buildDonationTable()),
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
              'Donation Management',
              style: GoogleFonts.oswald(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Track and manage all donations',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('EXPORT'),
            ),
            const SizedBox(width: 15),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('ADD OFFLINE DONATION'),
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

  Widget _buildStats() {
    return Row(
      children: [
        _statCard(
          'Total Donations',
          '\$872,400',
          Icons.attach_money,
          const Color(0xFF00D494),
        ),
        _statCard(
          'Online Payments',
          '\$654,300',
          Icons.credit_card,
          const Color(0xFF6C5CE7),
        ),
        _statCard(
          'Offline Donations',
          '\$218,100',
          Icons.money,
          const Color(0xFFFFB800),
        ),
        _statCard(
          'Pending',
          '\$12,500',
          Icons.pending,
          const Color(0xFFFF6B6B),
        ),
        _statCard('Refunds', '\$3,200', Icons.replay, Colors.grey),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.oswald(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationTable() {
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
                      hintText: 'Search donations...',
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
                _filterDropdown('Campaign', Icons.campaign),
                const SizedBox(width: 15),
                _filterDropdown('Payment Mode', Icons.payment),
                const SizedBox(width: 15),
                _filterDropdown('Date Range', Icons.date_range),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              children: [
                _tableHeader('DONOR', 2),
                _tableHeader('CAMPAIGN', 2),
                _tableHeader('AMOUNT', 1),
                _tableHeader('DATE', 1),
                _tableHeader('PAYMENT MODE', 1),
                _tableHeader('STATUS', 1),
                _tableHeader('ACTIONS', 1),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) => _donationRow(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(width: 8),
          Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _tableHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _donationRow(int index) {
    final statuses = [
      'completed',
      'completed',
      'pending',
      'failed',
      'completed',
    ];
    final status = statuses[index % 5];
    final statusColor = status == 'completed'
        ? const Color(0xFF00D494)
        : status == 'pending'
        ? const Color(0xFFFFB800)
        : const Color(0xFFFF6B6B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.1),
                  child: const Text(
                    'D',
                    style: TextStyle(
                      color: Color(0xFF6C5CE7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Donor ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'donor${index + 1}@email.com',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              ['Education Fund', 'Medical Aid', 'Food Drive'][index % 3],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '\$${(index + 1) * 250}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF00D494),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Dec ${28 - index}, 2025',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(['Card', 'UPI', 'Bank', 'Cash'][index % 4]),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.receipt_long, size: 20),
                  onPressed: () {},
                  tooltip: 'Generate Receipt',
                ),
                IconButton(
                  icon: const Icon(Icons.visibility, size: 20),
                  onPressed: () {},
                  tooltip: 'View Details',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
