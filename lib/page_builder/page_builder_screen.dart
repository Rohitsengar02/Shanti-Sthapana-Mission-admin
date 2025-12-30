import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models.dart';
import 'renderers.dart';
import 'dart:convert';

class PageBuilderScreen extends StatefulWidget {
  final PageData? existingPage;
  final Function(PageData)? onSave;

  const PageBuilderScreen({super.key, this.existingPage, this.onSave});

  @override
  State<PageBuilderScreen> createState() => _PageBuilderScreenState();
}

class _PageBuilderScreenState extends State<PageBuilderScreen> {
  late PageData _page;
  SectionData? _selectedSection;
  BlockData? _selectedBlock;
  bool _showPreview = false;

  @override
  void initState() {
    super.initState();
    _page =
        widget.existingPage ??
        PageData(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'New Page',
          slug: '/new-page',
        );
  }

  void _addSection(SectionType type) {
    setState(() {
      final section = SectionData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
      );
      // Add default blocks based on section type
      switch (type) {
        case SectionType.hero:
          section.blocks.addAll([
            BlockData(
              id: '${section.id}_1',
              type: BlockType.heading,
              value: 'Welcome to Our Mission',
              alignment: 'center',
            ),
            BlockData(
              id: '${section.id}_2',
              type: BlockType.paragraph,
              value: 'Making a difference in the world, one step at a time.',
              alignment: 'center',
            ),
            BlockData(
              id: '${section.id}_3',
              type: BlockType.button,
              value: 'DONATE NOW',
              alignment: 'center',
            ),
          ]);
          section.bgColor = '#F8F9FA';
          section.padding = 'large';
          break;
        case SectionType.text:
          section.blocks.add(
            BlockData(
              id: '${section.id}_1',
              type: BlockType.paragraph,
              value: 'Enter your text here...',
            ),
          );
          break;
        case SectionType.donationCta:
          section.blocks.add(
            BlockData(
              id: '${section.id}_1',
              type: BlockType.donationButton,
              value: 'Make a Difference Today',
            ),
          );
          break;
        case SectionType.stats:
          section.blocks.add(
            BlockData(id: '${section.id}_1', type: BlockType.impactCounter),
          );
          break;
        case SectionType.campaignList:
          section.blocks.addAll([
            BlockData(
              id: '${section.id}_1',
              type: BlockType.heading,
              value: 'Our Campaigns',
            ),
            BlockData(
              id: '${section.id}_2',
              type: BlockType.campaignCard,
              value: 'Education for All',
            ),
            BlockData(
              id: '${section.id}_3',
              type: BlockType.campaignCard,
              value: 'Clean Water Project',
            ),
          ]);
          break;
        default:
          section.blocks.add(
            BlockData(
              id: '${section.id}_1',
              type: BlockType.paragraph,
              value: 'Section content...',
            ),
          );
      }
      _page.sections.add(section);
      _selectedSection = section;
    });
  }

  void _moveSection(int index, int direction) {
    if (index + direction < 0 || index + direction >= _page.sections.length)
      return;
    setState(() {
      final section = _page.sections.removeAt(index);
      _page.sections.insert(index + direction, section);
    });
  }

  void _duplicateSection(int index) {
    setState(() {
      final original = _page.sections[index];
      final copy = SectionData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: original.type,
        bgColor: original.bgColor,
        padding: original.padding,
        blocks: original.blocks
            .map(
              (b) => BlockData(
                id: '${DateTime.now().millisecondsSinceEpoch}_${b.type.name}',
                type: b.type,
                value: b.value,
                link: b.link,
                color: b.color,
                fontSize: b.fontSize,
                alignment: b.alignment,
              ),
            )
            .toList(),
      );
      _page.sections.insert(index + 1, copy);
    });
  }

  void _deleteSection(int index) {
    setState(() {
      if (_selectedSection == _page.sections[index]) {
        _selectedSection = null;
        _selectedBlock = null;
      }
      _page.sections.removeAt(index);
    });
  }

  void _addBlock(BlockType type) {
    if (_selectedSection == null) return;
    setState(() {
      final block = BlockData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        value: _getDefaultValue(type),
      );
      _selectedSection!.blocks.add(block);
      _selectedBlock = block;
    });
  }

  String _getDefaultValue(BlockType type) {
    switch (type) {
      case BlockType.heading:
        return 'New Heading';
      case BlockType.paragraph:
        return 'Enter your text here...';
      case BlockType.button:
        return 'Click Here';
      case BlockType.campaignCard:
        return 'Campaign Name';
      case BlockType.donationButton:
        return 'Support Our Cause';
      case BlockType.volunteerCta:
        return 'Join Our Team';
      case BlockType.eventCard:
        return 'Upcoming Event';
      default:
        return '';
    }
  }

  void _savePage() {
    _page.updatedAt = DateTime.now();
    widget.onSave?.call(_page);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Page saved successfully!'),
        backgroundColor: Color(0xFF00D494),
      ),
    );
  }

  void _publishPage() {
    setState(() => _page.status = 'published');
    _savePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: Row(
              children: [
                _buildLeftPanel(),
                Expanded(
                  child: _showPreview
                      ? _buildFullPreview()
                      : _buildLivePreview(),
                ),
                _buildRightPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: _page.title),
              style: GoogleFonts.oswald(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Page Title',
              ),
              onChanged: (v) => _page.title = v,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _page.status == 'published'
                  ? const Color(0xFF00D494).withOpacity(0.1)
                  : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _page.status.toUpperCase(),
              style: TextStyle(
                color: _page.status == 'published'
                    ? const Color(0xFF00D494)
                    : Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 20),
          TextButton.icon(
            onPressed: () => setState(() => _showPreview = !_showPreview),
            icon: Icon(_showPreview ? Icons.edit : Icons.visibility),
            label: Text(_showPreview ? 'EDIT' : 'PREVIEW'),
          ),
          const SizedBox(width: 10),
          OutlinedButton(onPressed: _savePage, child: const Text('SAVE DRAFT')),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: _publishPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D494),
              foregroundColor: Colors.white,
            ),
            child: const Text('PUBLISH'),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.code),
            tooltip: 'View JSON',
            onPressed: () => _showJsonDialog(),
          ),
        ],
      ),
    );
  }

  void _showJsonDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Page JSON'),
        content: SizedBox(
          width: 600,
          height: 400,
          child: SingleChildScrollView(
            child: SelectableText(
              const JsonEncoder.withIndent('  ').convert(_page.toJson()),
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
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

  Widget _buildLeftPanel() {
    return Container(
      width: 280,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Add Section',
              style: GoogleFonts.oswald(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                _sectionButton(
                  SectionType.hero,
                  Icons.view_carousel,
                  'Hero Section',
                ),
                _sectionButton(
                  SectionType.text,
                  Icons.text_fields,
                  'Text Section',
                ),
                _sectionButton(SectionType.image, Icons.image, 'Image Section'),
                _sectionButton(
                  SectionType.gallery,
                  Icons.photo_library,
                  'Gallery',
                ),
                _sectionButton(
                  SectionType.campaignList,
                  Icons.campaign,
                  'Campaign List',
                ),
                _sectionButton(
                  SectionType.donationCta,
                  Icons.volunteer_activism,
                  'Donation CTA',
                ),
                _sectionButton(
                  SectionType.stats,
                  Icons.bar_chart,
                  'Impact Stats',
                ),
                _sectionButton(
                  SectionType.contact,
                  Icons.contact_mail,
                  'Contact Form',
                ),
                _sectionButton(
                  SectionType.testimonials,
                  Icons.format_quote,
                  'Testimonials',
                ),
                _sectionButton(SectionType.team, Icons.people, 'Team Section'),
              ],
            ),
          ),
          if (_selectedSection != null) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Add Block',
                style: GoogleFonts.oswald(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  _blockButton(BlockType.heading, Icons.title, 'Heading'),
                  _blockButton(BlockType.paragraph, Icons.notes, 'Paragraph'),
                  _blockButton(BlockType.image, Icons.image, 'Image'),
                  _blockButton(BlockType.button, Icons.smart_button, 'Button'),
                  _blockButton(BlockType.spacer, Icons.space_bar, 'Spacer'),
                  _blockButton(
                    BlockType.divider,
                    Icons.horizontal_rule,
                    'Divider',
                  ),
                  _blockButton(
                    BlockType.campaignCard,
                    Icons.campaign,
                    'Campaign Card',
                  ),
                  _blockButton(
                    BlockType.donationButton,
                    Icons.favorite,
                    'Donation CTA',
                  ),
                  _blockButton(
                    BlockType.impactCounter,
                    Icons.numbers,
                    'Impact Counter',
                  ),
                  _blockButton(
                    BlockType.volunteerCta,
                    Icons.group_add,
                    'Volunteer CTA',
                  ),
                  _blockButton(BlockType.eventCard, Icons.event, 'Event Card'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _sectionButton(SectionType type, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _addSection(type),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF6C5CE7), size: 22),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                const Icon(Icons.add, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _blockButton(BlockType type, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        onTap: () => _addBlock(type),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF6C5CE7).withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF6C5CE7)),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLivePreview() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '/${_page.slug.replaceAll('/', '')}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _page.sections.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: _page.sections.length,
                    itemBuilder: (context, index) => _buildSectionItem(index),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.web, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            'No sections yet',
            style: GoogleFonts.oswald(fontSize: 24, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          const Text('Add a section from the left panel to get started'),
        ],
      ),
    );
  }

  Widget _buildSectionItem(int index) {
    final section = _page.sections[index];
    final isSelected = _selectedSection == section;

    return GestureDetector(
      onTap: () => setState(() {
        _selectedSection = section;
        _selectedBlock = null;
      }),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF6C5CE7) : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            SectionRenderer(section: section),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _actionIcon(
                      Icons.arrow_upward,
                      () => _moveSection(index, -1),
                    ),
                    _actionIcon(
                      Icons.arrow_downward,
                      () => _moveSection(index, 1),
                    ),
                    _actionIcon(Icons.copy, () => _duplicateSection(index)),
                    _actionIcon(
                      Icons.delete,
                      () => _deleteSection(index),
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  section.type.name.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon, VoidCallback onTap, {Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Icon(icon, size: 18, color: color ?? Colors.grey[600]),
      ),
    );
  }

  Widget _buildFullPreview() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20),
        ],
      ),
      child: ListView(
        children: _page.sections
            .map((s) => SectionRenderer(section: s))
            .toList(),
      ),
    );
  }

  Widget _buildRightPanel() {
    return Container(
      width: 300,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: _selectedSection == null
          ? _buildPageSettings()
          : _selectedBlock != null
          ? _buildBlockSettings()
          : _buildSectionSettings(),
    );
  }

  Widget _buildPageSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Page Settings',
          style: GoogleFonts.oswald(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        _settingsField(
          'Page Title',
          _page.title,
          (v) => setState(() => _page.title = v),
        ),
        _settingsField(
          'URL Slug',
          _page.slug,
          (v) => setState(() => _page.slug = v),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Status'),
            DropdownButton<String>(
              value: _page.status,
              items: ['draft', 'published']
                  .map(
                    (s) => DropdownMenuItem(
                      value: s,
                      child: Text(s.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _page.status = v!),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionSettings() {
    if (_selectedSection == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Section Settings',
              style: GoogleFonts.oswald(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() => _selectedSection = null),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Background Color',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: ['#FFFFFF', '#F8F9FA', '#1A1A1A', '#6C5CE7', '#00D494']
              .map(
                (c) => _colorChip(
                  c,
                  _selectedSection!.bgColor == c,
                  (v) => setState(() => _selectedSection!.bgColor = v),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 20),
        const Text('Padding', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Row(
          children: ['small', 'medium', 'large']
              .map(
                (p) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        p.toUpperCase(),
                        style: const TextStyle(fontSize: 11),
                      ),
                      selected: _selectedSection!.padding == p,
                      onSelected: (v) =>
                          setState(() => _selectedSection!.padding = p),
                      selectedColor: const Color(0xFF6C5CE7),
                      labelStyle: TextStyle(
                        color: _selectedSection!.padding == p
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 20),
        SwitchListTile(
          title: const Text('Visible'),
          value: _selectedSection!.isVisible,
          onChanged: (v) => setState(() => _selectedSection!.isVisible = v),
          activeColor: const Color(0xFF00D494),
        ),
        SwitchListTile(
          title: const Text('Show on Mobile'),
          value: _selectedSection!.showOnMobile,
          onChanged: (v) => setState(() => _selectedSection!.showOnMobile = v),
          activeColor: const Color(0xFF00D494),
        ),
        const SizedBox(height: 20),
        const Text('Blocks', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...List.generate(
          _selectedSection!.blocks.length,
          (i) => _blockListItem(i),
        ),
      ],
    );
  }

  Widget _blockListItem(int index) {
    final block = _selectedSection!.blocks[index];
    return InkWell(
      onTap: () => setState(() => _selectedBlock = block),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _selectedBlock == block
              ? const Color(0xFF6C5CE7).withOpacity(0.1)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _selectedBlock == block
                ? const Color(0xFF6C5CE7)
                : Colors.grey[200]!,
          ),
        ),
        child: Row(
          children: [
            Text(block.type.name, style: const TextStyle(fontSize: 13)),
            const Spacer(),
            InkWell(
              onTap: () =>
                  setState(() => _selectedSection!.blocks.removeAt(index)),
              child: const Icon(Icons.close, size: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlockSettings() {
    if (_selectedBlock == null) return const SizedBox();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Block Settings',
                style: GoogleFonts.oswald(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => _selectedBlock = null),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _selectedBlock!.type.name.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF6C5CE7),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          if (_selectedBlock!.type != BlockType.spacer &&
              _selectedBlock!.type != BlockType.divider) ...[
            _settingsField(
              'Content',
              _selectedBlock!.value,
              (v) => setState(() => _selectedBlock!.value = v),
              maxLines: 4,
            ),
            if (_selectedBlock!.type == BlockType.button)
              _settingsField(
                'Link URL',
                _selectedBlock!.link ?? '',
                (v) => setState(() => _selectedBlock!.link = v),
              ),
          ],
          const SizedBox(height: 15),
          const Text(
            'Text Color',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: ['#1A1A1A', '#FFFFFF', '#6C5CE7', '#00D494', '#FF6B6B']
                .map(
                  (c) => _colorChip(
                    c,
                    _selectedBlock!.color == c,
                    (v) => setState(() => _selectedBlock!.color = v),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 15),
          const Text(
            'Font Size',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Row(
            children: ['small', 'medium', 'large']
                .map(
                  (s) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                          s.toUpperCase(),
                          style: const TextStyle(fontSize: 11),
                        ),
                        selected: _selectedBlock!.fontSize == s,
                        onSelected: (v) =>
                            setState(() => _selectedBlock!.fontSize = s),
                        selectedColor: const Color(0xFF6C5CE7),
                        labelStyle: TextStyle(
                          color: _selectedBlock!.fontSize == s
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 15),
          const Text(
            'Alignment',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _alignButton(Icons.format_align_left, 'left'),
              _alignButton(Icons.format_align_center, 'center'),
              _alignButton(Icons.format_align_right, 'right'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _settingsField(
    String label,
    String value,
    Function(String) onChanged, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: TextEditingController(text: value),
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _colorChip(String hex, bool isSelected, Function(String) onTap) {
    Color color;
    try {
      color = Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (e) {
      color = Colors.white;
    }
    return InkWell(
      onTap: () => onTap(hex),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF6C5CE7) : Colors.grey[300]!,
            width: isSelected ? 3 : 1,
          ),
        ),
      ),
    );
  }

  Widget _alignButton(IconData icon, String align) {
    final isSelected = _selectedBlock!.alignment == align;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedBlock!.alignment = align),
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6C5CE7) : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
