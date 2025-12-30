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

    switch (section.type) {
      case SectionType.navHeader:
        return _NavHeaderPreview(section: section);
      case SectionType.footer:
        return _FooterPreview(section: section);
      case SectionType.hero:
        return _HeroPreview(section: section);
      case SectionType.featuresGrid:
        return _FeaturesGridPreview(section: section);
      case SectionType.stats:
        return _StatsPreview(section: section);
      case SectionType.ctaSection:
        return _CtaPreview(section: section);
      case SectionType.partners:
        return _PartnersPreview(section: section);
      case SectionType.contact:
        return _ContactPreview(section: section);
      default:
        return _GenericSection(section: section);
    }
  }
}

class _GenericSection extends StatelessWidget {
  final SectionData section;
  const _GenericSection({required this.section});

  @override
  Widget build(BuildContext context) {
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
}

// --- PREVIEW COMPONENTS ---

class _NavHeaderPreview extends StatelessWidget {
  final SectionData section;
  const _NavHeaderPreview({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.volunteer_activism,
                color: Color(0xFF00D494),
                size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                'Shanti Sthapana',
                style: GoogleFonts.fredoka(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: ['Home', 'About Us', 'Causes', 'Events', 'Contact']
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      e,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                  ),
                )
                .toList(),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
            ),
            child: const Text('DONATE'),
          ),
        ],
      ),
    );
  }
}

class _FooterPreview extends StatelessWidget {
  final SectionData section;
  const _FooterPreview({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A),
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shanti Sthapana Mission',
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Empowering lives since 2020',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.facebook, color: Colors.white, size: 20),
                  const SizedBox(width: 20),
                  Icon(Icons.email, color: Colors.white, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Divider(color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 20),
          Text(
            '© 2024 All Rights Reserved',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class _HeroPreview extends StatelessWidget {
  final SectionData section;
  const _HeroPreview({required this.section});

  @override
  Widget build(BuildContext context) {
    // Try to get content from blocks if available
    final title = section.blocks.isNotEmpty
        ? section.blocks[0].value
        : 'Hero Title';
    final subtitle = section.blocks.length > 1
        ? section.blocks[1].value
        : 'Hero Subtitle';

    return Container(
      height: 500,
      width: double.infinity,
      color: Colors.grey[300],
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color(
                0xFF00D494,
              ).withOpacity(0.8), // Placeholder for image
              child: const Center(
                child: Icon(Icons.image, size: 100, color: Colors.white24),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF00D494),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: GoogleFonts.fredoka(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF00D494),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                  ),
                  child: const Text('LEARN MORE'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturesGridPreview extends StatelessWidget {
  final SectionData section;
  const _FeaturesGridPreview({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Our Focus Areas',
            style: GoogleFonts.fredoka(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              _featureCard('Education', Icons.school, Colors.blue),
              const SizedBox(width: 20),
              _featureCard('Healthcare', Icons.medical_services, Colors.red),
              const SizedBox(width: 20),
              _featureCard('Environment', Icons.eco, Colors.green),
              const SizedBox(width: 20),
              _featureCard('Food', Icons.soup_kitchen, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _featureCard(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        height: 250,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.fredoka(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsPreview extends StatelessWidget {
  final SectionData section;
  const _StatsPreview({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      color: const Color(0xFF1A1A1A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statItem('50k+', 'Lives Impacted'),
          _statItem('120+', 'Projects'),
          _statItem('15k+', 'Volunteers'),
        ],
      ),
    );
  }

  Widget _statItem(String val, String label) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.oswald(
            color: const Color(0xFF00D494),
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: GoogleFonts.poppins(color: Colors.white70)),
      ],
    );
  }
}

class _CtaPreview extends StatelessWidget {
  final SectionData section;
  const _CtaPreview({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(80),
      color: const Color(0xFF00D494).withOpacity(0.1),
      child: Center(
        child: Column(
          children: [
            Text(
              'Ready to help?',
              style: GoogleFonts.fredoka(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A1A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
              ),
              child: const Text('Donate Now'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PartnersPreview extends StatelessWidget {
  final SectionData section;
  const _PartnersPreview({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          Text(
            'Our Partners',
            style: GoogleFonts.fredoka(fontSize: 24, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.business, size: 40, color: Colors.grey),
              SizedBox(width: 40),
              Icon(Icons.business_center, size: 40, color: Colors.grey),
              SizedBox(width: 40),
              Icon(Icons.domain, size: 40, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContactPreview extends StatelessWidget {
  final SectionData section;
  const _ContactPreview({required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 400,
              color: Colors.grey[200],
              child: const Center(child: Text('Map Placeholder')),
            ),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Get in Touch', style: GoogleFonts.fredoka(fontSize: 32)),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                const TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Send Message'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helpers
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

/// Renders individual blocks (for the GenericSection or reuse)
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

      default:
        return const SizedBox.shrink(); // Simplify for brevity in this refactor
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
}
