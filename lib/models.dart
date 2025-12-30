import 'package:uuid/uuid.dart';

enum SectionType {
  hero,
  about,
  stats,
  cta,
  gallery,
  testimonials,
  faq,
  textOnly,
}

class SectionModel {
  final String id;
  SectionType type;
  Map<String, dynamic> data;

  SectionModel({String? id, required this.type, required this.data})
    : id = id ?? const Uuid().v4();

  SectionModel copyWith({SectionType? type, Map<String, dynamic>? data}) {
    return SectionModel(
      id: id,
      type: type ?? this.type,
      data: data ?? Map<String, dynamic>.from(this.data),
    );
  }
}

class PageModel {
  final String id;
  String title;
  String path;
  List<SectionModel> sections;
  bool isPublished;

  PageModel({
    String? id,
    required this.title,
    required this.path,
    List<SectionModel>? sections,
    this.isPublished = false,
  }) : id = id ?? const Uuid().v4(),
       sections = sections ?? [];
}
