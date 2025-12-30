import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplianceScreen extends StatelessWidget {
  const ComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 30),
        _buildStatusCards(),
        const SizedBox(height: 30),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildDocuments()),
              const SizedBox(width: 30),
              Expanded(child: _buildCertificates()),
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
              'Compliance & Legal',
              style: GoogleFonts.oswald(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'NGO registrations, certificates, and legal documents',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.upload_file),
          label: const Text('UPLOAD DOCUMENT'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00D494),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCards() {
    return Row(
      children: [
        _statusCard(
          'NGO Registration',
          'Valid till Dec 2028',
          Icons.verified,
          const Color(0xFF00D494),
          true,
        ),
        _statusCard(
          '80G Certificate',
          'Valid till Mar 2026',
          Icons.description,
          const Color(0xFF00D494),
          true,
        ),
        _statusCard(
          'FCRA Status',
          'Active',
          Icons.public,
          const Color(0xFF6C5CE7),
          true,
        ),
        _statusCard(
          'Annual Report 2025',
          'Due in 30 days',
          Icons.assessment,
          const Color(0xFFFFB800),
          false,
        ),
      ],
    );
  }

  Widget _statusCard(
    String title,
    String status,
    IconData icon,
    Color color,
    bool isValid,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isValid
                ? color.withOpacity(0.3)
                : Colors.orange.withOpacity(0.3),
            width: 2,
          ),
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
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color),
                ),
                Icon(
                  isValid ? Icons.check_circle : Icons.warning,
                  color: isValid ? const Color(0xFF00D494) : Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              status,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocuments() {
    final documents = [
      {
        'title': 'NGO Registration Certificate',
        'date': 'Uploaded: Jan 2024',
        'type': 'pdf',
      },
      {'title': 'Trust Deed', 'date': 'Uploaded: Jan 2024', 'type': 'pdf'},
      {
        'title': 'FCRA Registration',
        'date': 'Uploaded: Mar 2024',
        'type': 'pdf',
      },
      {
        'title': 'Memorandum of Association',
        'date': 'Uploaded: Jan 2024',
        'type': 'pdf',
      },
      {'title': 'PAN Card', 'date': 'Uploaded: Jan 2024', 'type': 'image'},
      {
        'title': 'Bank Account Details',
        'date': 'Uploaded: Feb 2024',
        'type': 'pdf',
      },
    ];

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
            'Legal Documents',
            style: GoogleFonts.oswald(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) => _documentItem(documents[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentItem(Map<String, String> document) {
    final isPdf = document['type'] == 'pdf';
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
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isPdf
                    ? const Color(0xFFFF6B6B).withOpacity(0.1)
                    : const Color(0xFF6C5CE7).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isPdf ? Icons.picture_as_pdf : Icons.image,
                color: isPdf
                    ? const Color(0xFFFF6B6B)
                    : const Color(0xFF6C5CE7),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    document['date']!,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.download), onPressed: () {}),
            IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificates() {
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
            '80G Certificates',
            style: GoogleFonts.oswald(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Auto-generated tax exemption certificates',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 25),
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
                      'Auto-Generate',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Certificates are automatically generated and emailed to donors after each donation.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Text(
            'Recent Certificates',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) => _certificateItem(index),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFFFB800).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.info, color: Color(0xFFFFB800)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Annual Reports Due',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Upload 2024-25 report by Mar 31',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _certificateItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00D494).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.description,
              color: Color(0xFF00D494),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '80G-2025-${1000 + index}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Dec ${30 - index}, 2025',
                  style: TextStyle(color: Colors.grey[500], fontSize: 11),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Color(0xFF00D494), size: 18),
        ],
      ),
    );
  }
}
