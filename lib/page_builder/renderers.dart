import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models.dart';

/// Renders a section based on its type and blocks
class SectionRenderer extends StatelessWidget {
  final SectionData section;

  const SectionRenderer({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    if (!section.isVisible) return const SizedBox.shrink();

    final padding = _getPadding(section.padding);
    final bgColor = _parseColor(section.bgColor);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: padding, horizontal: 40),
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: section.blocks
            .map((block) => BlockRenderer(block: block))
            .toList(),
      ),
    );
  }

  double _getPadding(String size) {
    switch (size) {
      case 'small':
        return 30;
      case 'large':
        return 80;
      default:
        return 50;
    }
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (e) {
      return Colors.white;
    }
  }
}

/// Renders individual blocks
class BlockRenderer extends StatelessWidget {
  final BlockData block;

  const BlockRenderer({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(block.color);
    final fontSize = _getFontSize(block.fontSize);
    final alignment = _getAlignment(block.alignment);

    switch (block.type) {
      case BlockType.heading:
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Align(
            alignment: alignment,
            child: Text(
              block.value,
              style: GoogleFonts.oswald(
                fontSize: fontSize * 2,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        );

      case BlockType.paragraph:
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: alignment,
            child: Text(
              block.value,
              style: GoogleFonts.poppins(
                fontSize: fontSize,
                color: color,
                height: 1.7,
              ),
            ),
          ),
        );

      case BlockType.image:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: block.value.isNotEmpty
                ? Image.network(
                    block.value,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => _imagePlaceholder(),
                  )
                : _imagePlaceholder(),
          ),
        );

      case BlockType.button:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Align(
            alignment: alignment,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D494),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                block.value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        );

      case BlockType.spacer:
        return SizedBox(height: fontSize * 2);

      case BlockType.divider:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Divider(color: color.withOpacity(0.2)),
        );

      case BlockType.campaignCard:
        return _campaignCard();

      case BlockType.donationButton:
        return _donationButton();

      case BlockType.impactCounter:
        return _impactCounter();

      case BlockType.volunteerCta:
        return _volunteerCta();

      case BlockType.eventCard:
        return _eventCard();
    }
  }

  Widget _imagePlaceholder() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Icon(Icons.image, size: 50, color: Colors.grey),
      ),
    );
  }

  Widget _campaignCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            block.value.isNotEmpty ? block.value : 'Campaign Title',
            style: GoogleFonts.oswald(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.65,
              minHeight: 10,
              backgroundColor: Color(0xFFE0E0E0),
              valueColor: AlwaysStoppedAnimation(Color(0xFF00D494)),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '65% funded • \$32,500 raised',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _donationButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CE7), Color(0xFF8B7CF6)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  block.value.isNotEmpty
                      ? block.value
                      : 'Make a Difference Today',
                  style: GoogleFonts.oswald(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your donation helps us change lives',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF6C5CE7),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            ),
            child: const Text(
              'DONATE NOW',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _impactCounter() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _counterItem('12,500+', 'Lives Changed'),
          _counterItem('850+', 'Volunteers'),
          _counterItem('\$2.5M+', 'Raised'),
          _counterItem('50+', 'Projects'),
        ],
      ),
    );
  }

  Widget _counterItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.oswald(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF00D494),
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  Widget _volunteerCta() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF00D494).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF00D494).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.volunteer_activism,
            size: 50,
            color: Color(0xFF00D494),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  block.value.isNotEmpty ? block.value : 'Become a Volunteer',
                  style: GoogleFonts.oswald(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Join our team and make an impact'),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF00D494),
            ),
            child: const Text('JOIN US'),
          ),
        ],
      ),
    );
  }

  Widget _eventCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'JAN',
                  style: TextStyle(
                    color: const Color(0xFF6C5CE7),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '15',
                  style: GoogleFonts.oswald(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6C5CE7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  block.value.isNotEmpty ? block.value : 'Upcoming Event',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Location • Time',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  double _getFontSize(String size) {
    switch (size) {
      case 'small':
        return 14;
      case 'large':
        return 20;
      default:
        return 16;
    }
  }

  Alignment _getAlignment(String align) {
    switch (align) {
      case 'center':
        return Alignment.center;
      case 'right':
        return Alignment.centerRight;
      default:
        return Alignment.centerLeft;
    }
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (e) {
      return const Color(0xFF1A1A1A);
    }
  }
}
