import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reorderables/reorderables.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'models.dart';

class PageBuilderScreen extends StatefulWidget {
  const PageBuilderScreen({super.key});

  @override
  State<PageBuilderScreen> createState() => _PageBuilderScreenState();
}

class _PageBuilderScreenState extends State<PageBuilderScreen> {
  final List<PageModel> _pages = [
    PageModel(title: 'Home', path: '/', isPublished: true),
    PageModel(title: 'About Us', path: '/about', isPublished: true),
    PageModel(title: 'Contact', path: '/contact', isPublished: false),
  ];

  PageModel? _editingPage;

  @override
  Widget build(BuildContext context) {
    if (_editingPage != null) {
      return _buildEditor();
    }
    return _buildPageList();
  }

  Widget _buildPageList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'User Pages',
              style: GoogleFonts.oswald(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _editingPage = PageModel(
                    title: 'New Page',
                    path: '/new-page',
                  );
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('CREATE NEW PAGE'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D494),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _pages.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final page = _pages[index];
              return ListTile(
                contentPadding: const EdgeInsets.all(25),
                title: Text(
                  page.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  page.path,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: page.isPublished
                            ? const Color(0xFF00D494).withOpacity(0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        page.isPublished ? 'PUBLISHED' : 'DRAFT',
                        style: TextStyle(
                          color: page.isPublished
                              ? const Color(0xFF00D494)
                              : Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => setState(() => _editingPage = page),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => setState(() => _editingPage = null),
            ),
            const SizedBox(width: 10),
            Text(
              'Editing: ${_editingPage!.title}',
              style: GoogleFonts.oswald(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => setState(() => _editingPage = null),
              child: const Text('CANCEL'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                // Save logic
                setState(() => _editingPage = null);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text('SAVE PAGE'),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Panel: Settings
            Expanded(flex: 1, child: _buildEditorSettings()),
            const SizedBox(width: 30),
            // Middle Panel: Reorderable Sections
            Expanded(flex: 2, child: _buildEditorCanvas()),
            const SizedBox(width: 30),
            // Right Panel: Available Components
            Expanded(flex: 1, child: _buildComponentLibrary()),
          ],
        ),
      ],
    );
  }

  Widget _buildEditorSettings() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Page Settings',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: TextEditingController(text: _editingPage!.title),
            decoration: const InputDecoration(
              labelText: 'Page Title',
              border: OutlineInputBorder(),
            ),
            onChanged: (val) => _editingPage!.title = val,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: TextEditingController(text: _editingPage!.path),
            decoration: const InputDecoration(
              labelText: 'Route Path',
              border: OutlineInputBorder(),
            ),
            onChanged: (val) => _editingPage!.path = val,
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Published'),
            value: _editingPage!.isPublished,
            onChanged: (val) => setState(() => _editingPage!.isPublished = val),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorCanvas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Page Content',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: _editingPage!.sections.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Text(
                      'No sections added yet.\nDrag components from the library or click to add.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ReorderableColumn(
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      final item = _editingPage!.sections.removeAt(oldIndex);
                      _editingPage!.sections.insert(newIndex, item);
                    });
                  },
                  children: _editingPage!.sections.map((section) {
                    return Container(
                      key: ValueKey(section.id),
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.drag_indicator, color: Colors.grey),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                section.type.name.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C5CE7),
                                ),
                              ),
                              Text(
                                'Section ID: ${section.id.substring(0, 8)}...',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.settings_outlined),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                _editingPage!.sections.remove(section);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildComponentLibrary() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Component Library',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 25),
          _componentItem(SectionType.hero, FontAwesomeIcons.image),
          _componentItem(SectionType.about, Icons.info_outline),
          _componentItem(SectionType.stats, Icons.query_stats),
          _componentItem(SectionType.cta, Icons.call_to_action_outlined),
          _componentItem(SectionType.gallery, Icons.grid_view),
          _componentItem(SectionType.testimonials, Icons.reviews_outlined),
          _componentItem(SectionType.faq, Icons.help_outline),
          _componentItem(SectionType.textOnly, Icons.text_fields),
        ],
      ),
    );
  }

  Widget _componentItem(SectionType type, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            _editingPage!.sections.add(SectionModel(type: type, data: {}));
          });
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF6C5CE7)),
              const SizedBox(width: 15),
              Text(
                type.name.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.add_circle_outline,
                size: 20,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
