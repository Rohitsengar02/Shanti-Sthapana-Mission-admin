import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 30),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFolders(),
              const SizedBox(width: 30),
              Expanded(flex: 3, child: _buildMediaGrid()),
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
              'Media Library',
              style: GoogleFonts.oswald(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Manage images, documents, and files',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.create_new_folder),
              label: const Text('NEW FOLDER'),
            ),
            const SizedBox(width: 15),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload),
              label: const Text('UPLOAD FILES'),
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

  Widget _buildFolders() {
    final folders = [
      {'name': 'All Files', 'count': 256, 'icon': Icons.folder},
      {'name': 'Images', 'count': 180, 'icon': Icons.image},
      {'name': 'Documents', 'count': 45, 'icon': Icons.description},
      {'name': 'Videos', 'count': 12, 'icon': Icons.video_library},
      {'name': 'Receipts', 'count': 89, 'icon': Icons.receipt},
      {'name': 'Reports', 'count': 23, 'icon': Icons.assessment},
    ];

    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
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
            'Folders',
            style: GoogleFonts.oswald(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...folders.map(
            (folder) => _folderItem(
              folder['name'] as String,
              folder['count'] as int,
              folder['icon'] as IconData,
              folder['name'] == 'All Files',
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Storage Used',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: const LinearProgressIndicator(
                    value: 0.65,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(Color(0xFF6C5CE7)),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '6.5 GB of 10 GB used',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _folderItem(String name, int count, IconData icon, bool isActive) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF6C5CE7).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFF6C5CE7) : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? const Color(0xFF6C5CE7) : Colors.black87,
                ),
              ),
            ),
            Text(
              '$count',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaGrid() {
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
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search files...',
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
              IconButton(icon: const Icon(Icons.grid_view), onPressed: () {}),
              IconButton(icon: const Icon(Icons.list), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.9,
              ),
              itemCount: 15,
              itemBuilder: (context, index) => _mediaItem(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mediaItem(int index) {
    final types = ['image', 'pdf', 'image', 'video', 'doc'];
    final type = types[index % 5];
    final icons = {
      'image': Icons.image,
      'pdf': Icons.picture_as_pdf,
      'video': Icons.video_file,
      'doc': Icons.description,
    };
    final colors = {
      'image': const Color(0xFF6C5CE7),
      'pdf': const Color(0xFFFF6B6B),
      'video': const Color(0xFF00D494),
      'doc': const Color(0xFFFFB800),
    };

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colors[type]!.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
              ),
              child: Center(
                child: Icon(icons[type], size: 40, color: colors[type]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'File ${index + 1}.${type == 'image' ? 'jpg' : type}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${(index + 1) * 125} KB',
                  style: TextStyle(color: Colors.grey[500], fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
