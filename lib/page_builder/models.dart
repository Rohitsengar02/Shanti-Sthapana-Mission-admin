// Page Builder Models - JSON-based structure

class PageData {
  String id;
  String title;
  String slug;
  String status; // draft, published
  List<SectionData> sections;
  DateTime createdAt;
  DateTime updatedAt;

  PageData({
    required this.id,
    required this.title,
    required this.slug,
    this.status = 'draft',
    List<SectionData>? sections,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : sections = sections ?? [],
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slug': slug,
    'status': status,
    'sections': sections.map((s) => s.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory PageData.fromJson(Map<String, dynamic> json) => PageData(
    id: json['id'],
    title: json['title'],
    slug: json['slug'],
    status: json['status'] ?? 'draft',
    sections:
        (json['sections'] as List?)
            ?.map((s) => SectionData.fromJson(s))
            .toList() ??
        [],
    createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
    updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
  );
}

enum SectionType {
  hero,
  text,
  image,
  gallery,
  campaignList,
  donationCta,
  contact,
  stats,
  testimonials,
  team,
}

class SectionData {
  String id;
  SectionType type;
  String bgColor;
  String padding; // small, medium, large
  bool isVisible;
  bool showOnMobile;
  List<BlockData> blocks;

  SectionData({
    required this.id,
    required this.type,
    this.bgColor = '#FFFFFF',
    this.padding = 'medium',
    this.isVisible = true,
    this.showOnMobile = true,
    List<BlockData>? blocks,
  }) : blocks = blocks ?? [];

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'bgColor': bgColor,
    'padding': padding,
    'isVisible': isVisible,
    'showOnMobile': showOnMobile,
    'blocks': blocks.map((b) => b.toJson()).toList(),
  };

  factory SectionData.fromJson(Map<String, dynamic> json) => SectionData(
    id: json['id'],
    type: SectionType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => SectionType.text,
    ),
    bgColor: json['bgColor'] ?? '#FFFFFF',
    padding: json['padding'] ?? 'medium',
    isVisible: json['isVisible'] ?? true,
    showOnMobile: json['showOnMobile'] ?? true,
    blocks:
        (json['blocks'] as List?)?.map((b) => BlockData.fromJson(b)).toList() ??
        [],
  );
}

enum BlockType {
  heading,
  paragraph,
  image,
  button,
  spacer,
  divider,
  campaignCard,
  donationButton,
  impactCounter,
  volunteerCta,
  eventCard,
}

class BlockData {
  String id;
  BlockType type;
  String value;
  String? link;
  String color;
  String fontSize; // small, medium, large
  String alignment; // left, center, right

  BlockData({
    required this.id,
    required this.type,
    this.value = '',
    this.link,
    this.color = '#1A1A1A',
    this.fontSize = 'medium',
    this.alignment = 'left',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'value': value,
    'link': link,
    'color': color,
    'fontSize': fontSize,
    'alignment': alignment,
  };

  factory BlockData.fromJson(Map<String, dynamic> json) => BlockData(
    id: json['id'],
    type: BlockType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => BlockType.paragraph,
    ),
    value: json['value'] ?? '',
    link: json['link'],
    color: json['color'] ?? '#1A1A1A',
    fontSize: json['fontSize'] ?? 'medium',
    alignment: json['alignment'] ?? 'left',
  );
}
