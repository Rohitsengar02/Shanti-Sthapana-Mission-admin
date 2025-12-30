import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models.dart';
import 'page_builder_screen.dart';

class PagesListScreen extends StatefulWidget {
  const PagesListScreen({super.key});

  @override
  State<PagesListScreen> createState() => _PagesListScreenState();
}

class _PagesListScreenState extends State<PagesListScreen> {
  final List<PageData> _pages = [
    PageData(
      id: '1',
      title: 'Home',
      slug: '/',
      status: 'published',
      sections: [
        SectionData(
          id: '1',
          type: SectionType.hero,
          bgColor: '#F8F9FA',
          padding: 'large',
          blocks: [
            BlockData(
              id: '1',
              type: BlockType.heading,
              value: 'Welcome to Shanti Mission',
              alignment: 'center',
            ),
            BlockData(
              id: '2',
              type: BlockType.paragraph,
              value: 'Building hope, changing lives',
              alignment: 'center',
            ),
            BlockData(
              id: '3',
              type: BlockType.button,
              value: 'DONATE NOW',
              alignment: 'center',
            ),
          ],
        ),
        SectionData(
          id: '2',
          type: SectionType.stats,
          blocks: [BlockData(id: '4', type: BlockType.impactCounter)],
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    PageData(
      id: '2',
      title: 'About Us',
      slug: '/about',
      status: 'published',
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    PageData(
      id: '3',
      title: 'Donate',
      slug: '/donate',
      status: 'published',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PageData(
      id: '4',
      title: 'Contact',
      slug: '/contact',
      status: 'draft',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now(),
    ),
  ];

  void _openPageBuilder({PageData? page}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageBuilderScreen(
          existingPage: page,
          onSave: (savedPage) {
            setState(() {
              final index = _pages.indexWhere((p) => p.id == savedPage.id);
              if (index >= 0) {
                _pages[index] = savedPage;
              } else {
                _pages.add(savedPage);
              }
            });
          },
        ),
      ),
    );
  }

  void _deletePage(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Page'),
        content: Text(
          'Are you sure you want to delete "${_pages[index].title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _pages.removeAt(index));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
  }

  void _duplicatePage(int index) {
    setState(() {
      final original = _pages[index];
      _pages.add(
        PageData(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: '${original.title} (Copy)',
          slug: '${original.slug}-copy',
          status: 'draft',
          sections: original.sections,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 30),
        _buildStats(),
        const SizedBox(height: 30),
        Expanded(child: _buildPagesList()),
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
              'Page Builder',
              style: GoogleFonts.oswald(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Create and manage website pages',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => _openPageBuilder(),
          icon: const Icon(Icons.add),
          label: const Text('CREATE NEW PAGE'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00D494),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    final published = _pages.where((p) => p.status == 'published').length;
    final drafts = _pages.where((p) => p.status == 'draft').length;

    return Row(
      children: [
        _statCard(
          'Total Pages',
          '${_pages.length}',
          Icons.web,
          const Color(0xFF6C5CE7),
        ),
        _statCard(
          'Published',
          '$published',
          Icons.check_circle,
          const Color(0xFF00D494),
        ),
        _statCard(
          'Drafts',
          '$drafts',
          Icons.edit_note,
          const Color(0xFFFFB800),
        ),
        _templateCard(),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon, Color color) {
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
                  value,
                  style: GoogleFonts.oswald(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(title, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _templateCard() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6C5CE7), Color(0xFF8B7CF6)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.dashboard_customize,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Templates',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Use pre-built templates',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () => _showTemplatesDialog(),
            ),
          ],
        ),
      ),
    );
  }

  void _showTemplatesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Page Templates',
          style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _templateItem(
                'Home Page',
                'Hero + Stats + Campaigns + CTA',
                Icons.home,
              ),
              _templateItem('About Us', 'Hero + Team + Mission', Icons.info),
              _templateItem(
                'Donate',
                'Hero + Donation CTA + Impact',
                Icons.volunteer_activism,
              ),
              _templateItem(
                'Contact',
                'Hero + Contact Form',
                Icons.contact_mail,
              ),
              _templateItem(
                'Campaign',
                'Hero + Campaign Details + CTA',
                Icons.campaign,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  Widget _templateItem(String title, String description, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        _createFromTemplate(title);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
                color: const Color(0xFF6C5CE7).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFF6C5CE7)),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.add_circle_outline, color: Color(0xFF00D494)),
          ],
        ),
      ),
    );
  }

  void _createFromTemplate(String template) {
    final page = PageData(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: template,
      slug: '/${template.toLowerCase().replaceAll(' ', '-')}',
    );

    // Add sections based on template
    switch (template) {
      case 'Home Page':
        page.sections.addAll([
          SectionData(
            id: '1',
            type: SectionType.hero,
            padding: 'large',
            bgColor: '#F8F9FA',
            blocks: [
              BlockData(
                id: '1',
                type: BlockType.heading,
                value: 'Welcome to Our Mission',
                alignment: 'center',
              ),
              BlockData(
                id: '2',
                type: BlockType.paragraph,
                value: 'Making a difference together',
                alignment: 'center',
              ),
              BlockData(
                id: '3',
                type: BlockType.button,
                value: 'LEARN MORE',
                alignment: 'center',
              ),
            ],
          ),
          SectionData(
            id: '2',
            type: SectionType.stats,
            blocks: [BlockData(id: '4', type: BlockType.impactCounter)],
          ),
          SectionData(
            id: '3',
            type: SectionType.donationCta,
            blocks: [BlockData(id: '5', type: BlockType.donationButton)],
          ),
        ]);
        break;
      case 'Donate':
        page.sections.addAll([
          SectionData(
            id: '1',
            type: SectionType.hero,
            padding: 'large',
            bgColor: '#6C5CE7',
            blocks: [
              BlockData(
                id: '1',
                type: BlockType.heading,
                value: 'Support Our Cause',
                alignment: 'center',
                color: '#FFFFFF',
              ),
              BlockData(
                id: '2',
                type: BlockType.paragraph,
                value: 'Every donation makes a difference',
                alignment: 'center',
                color: '#FFFFFF',
              ),
            ],
          ),
          SectionData(
            id: '2',
            type: SectionType.donationCta,
            blocks: [BlockData(id: '3', type: BlockType.donationButton)],
          ),
          SectionData(
            id: '3',
            type: SectionType.stats,
            blocks: [BlockData(id: '4', type: BlockType.impactCounter)],
          ),
        ]);
        break;
      default:
        page.sections.add(
          SectionData(
            id: '1',
            type: SectionType.hero,
            blocks: [
              BlockData(
                id: '1',
                type: BlockType.heading,
                value: template,
                alignment: 'center',
              ),
            ],
          ),
        );
    }

    _openPageBuilder(page: page);
  }

  Widget _buildPagesList() {
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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 50),
                Expanded(
                  flex: 3,
                  child: Text(
                    'PAGE',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'URL',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'STATUS',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'LAST UPDATED',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 120,
                  child: Text(
                    'ACTIONS',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _pages.length,
              itemBuilder: (context, index) => _pageRow(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageRow(int index) {
    final page = _pages[index];
    final isPublished = page.status == 'published';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.article,
              color: Color(0xFF6C5CE7),
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  page.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${page.sections.length} sections',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                page.slug,
                style: TextStyle(color: Colors.grey[700], fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isPublished
                    ? const Color(0xFF00D494).withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                page.status.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isPublished ? const Color(0xFF00D494) : Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              _formatDate(page.updatedAt),
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ),
          SizedBox(
            width: 120,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _openPageBuilder(page: page),
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () => _duplicatePage(index),
                  tooltip: 'Duplicate',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                  onPressed: () => _deletePage(index),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${date.month}/${date.day}/${date.year}';
  }
}
