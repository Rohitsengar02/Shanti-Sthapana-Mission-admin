import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../page_builder/pages_list_screen.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 20),
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color(0xFF6C5CE7),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF6C5CE7),
          tabs: const [
            Tab(text: 'PAGES'),
            Tab(text: 'BLOG'),
            Tab(text: 'NEWS'),
            Tab(text: 'GALLERY'),
            Tab(text: 'TESTIMONIALS'),
            Tab(text: 'IMPACT STORIES'),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildPages(),
              _buildBlog(),
              _buildNews(),
              _buildGallery(),
              _buildTestimonials(),
              _buildImpactStories(),
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
              'Content Management',
              style: GoogleFonts.oswald(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Manage website content, blogs, and media',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('ADD CONTENT'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00D494),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildPages() {
    final pages = [
      {
        'title': 'Homepage',
        'status': 'published',
        'lastEdited': 'Dec 28, 2025',
      },
      {
        'title': 'About Us',
        'status': 'published',
        'lastEdited': 'Dec 25, 2025',
      },
      {
        'title': 'Our Mission',
        'status': 'published',
        'lastEdited': 'Dec 20, 2025',
      },
      {'title': 'Contact', 'status': 'draft', 'lastEdited': 'Dec 29, 2025'},
      {'title': 'Donate', 'status': 'published', 'lastEdited': 'Dec 15, 2025'},
    ];

    return Column(
      children: [
        // Page Builder Card
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const PagesListScreen()),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFF8B7CF6)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.dashboard_customize,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Page Builder',
                        style: GoogleFonts.oswald(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Create and edit pages with drag-free visual builder',
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF6C5CE7),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Pages List
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 20,
                ),
              ],
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: pages.length,
              itemBuilder: (context, index) {
                final page = pages[index];
                return _contentItem(
                  page['title']!,
                  page['status']!,
                  page['lastEdited']!,
                  Icons.web,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBlog() {
    final blogs = [
      {
        'title': 'How Your Donations Change Lives',
        'status': 'published',
        'date': 'Dec 28, 2025',
      },
      {
        'title': 'Volunteer Stories: Making a Difference',
        'status': 'published',
        'date': 'Dec 25, 2025',
      },
      {
        'title': 'Year in Review 2025',
        'status': 'draft',
        'date': 'Dec 29, 2025',
      },
      {
        'title': 'Education Initiative Success',
        'status': 'published',
        'date': 'Dec 20, 2025',
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
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];
          return _contentItem(
            blog['title']!,
            blog['status']!,
            blog['date']!,
            Icons.article,
          );
        },
      ),
    );
  }

  Widget _buildNews() {
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
        itemCount: 5,
        itemBuilder: (context, index) => _contentItem(
          'News Update ${index + 1}',
          'published',
          'Dec ${28 - index}, 2025',
          Icons.newspaper,
        ),
      ),
    );
  }

  Widget _buildGallery() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Media Gallery',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload),
                label: const Text('UPLOAD'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: 20,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6C5CE7).withOpacity(0.3),
                      const Color(0xFF00D494).withOpacity(0.3),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.white.withOpacity(0.5),
                        size: 40,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Image ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonials() {
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
        itemCount: 6,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.1),
                child: const Icon(Icons.person, color: Color(0xFF6C5CE7)),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Testimonial from User ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '"This organization has changed my life..."',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: List.generate(
                        5,
                        (i) => const Icon(
                          Icons.star,
                          color: Color(0xFFFFB800),
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(value: index % 2 == 0, onChanged: (val) {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImpactStories() {
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
        itemCount: 4,
        itemBuilder: (context, index) => _contentItem(
          'Impact Story: ${['Education Changed Everything', 'From Hunger to Hope', 'Medical Aid Saves Lives', 'Clean Water Initiative'][index]}',
          'published',
          'Dec ${25 - index * 3}, 2025',
          Icons.auto_stories,
        ),
      ),
    );
  }

  Widget _contentItem(String title, String status, String date, IconData icon) {
    final isPublished = status == 'published';
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF6C5CE7)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Last edited: $date',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isPublished
                  ? const Color(0xFF00D494).withOpacity(0.1)
                  : const Color(0xFFFFB800).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status.toUpperCase(),
              style: TextStyle(
                color: isPublished
                    ? const Color(0xFF00D494)
                    : const Color(0xFFFFB800),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 15),
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
