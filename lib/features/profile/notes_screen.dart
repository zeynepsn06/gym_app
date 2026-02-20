
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_colors.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, String>> _notes = [
    {
      "date": "18.01.2026",
      "title": "Bacak Antrenmanı",
      "content": "Bugün bacak antrenmanında ağırlıkları 5kg artırdım. Squat formum daha iyiydi.",
      "tag": "Gelişim"
    },
    {
      "date": "16.01.2026",
      "title": "Kardiyo Günü",
      "content": "Kardiyo zorladı ama 45 dakikayı tamamladım. Enerjim düşüktü.",
      "tag": "Performans"
    },
    {
      "date": "14.01.2026",
      "title": "Sırt Hissiyatı",
      "content": "Lat Pulldown'da sırtımı çok iyi hissettim. Drop set denedim.",
      "tag": "Not"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notlarım",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          // Global Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/background/app_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withAlpha(153),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                _buildHeaderInfo(),
                Expanded(
                  child: _notes.isEmpty
                      ? _buildEmptyState()
                      : _buildNotesList(),
                ),
              ],
            ),
          ),
          
          // Floating Action Button
          Positioned(
            bottom: 30, 
            right: 20,
            child: FloatingActionButton(
              onPressed: _showAddNoteDialog,
              backgroundColor: AppColors.primary,
              elevation: 4,
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            "Toplam ${_notes.length} Not",
            style: TextStyle(color: Colors.white.withAlpha(128), fontSize: 14),
          ),
          const Spacer(),
          Icon(Icons.sort_rounded, color: Colors.white.withAlpha(128), size: 20),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(13),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.note_alt_outlined, size: 60, color: Colors.white.withAlpha(51)),
          ),
          const SizedBox(height: 16),
          Text(
            "Henüz not eklemediniz.",
            style: TextStyle(color: Colors.white.withAlpha(128), fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        final note = _notes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) => _showDeleteConfirmation(index),
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.redAccent.withAlpha(204),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 30),
                  Text("Sil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
            ),
            child: InkWell(
              onTap: () => _showViewNoteDialog(note),
              borderRadius: BorderRadius.circular(25),
              child: _buildNoteCard(note, index),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoteCard(Map<String, String> note, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(13),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white.withAlpha(26)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNoteHeader(note, index),
              const SizedBox(height: 16),
              Text(
                note["title"] ?? "Başlıksız Not",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                note["content"]!,
                style: TextStyle(
                  color: Colors.white.withAlpha(179),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteHeader(Map<String, String> note, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(26),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                note["tag"] ?? "Genel",
                style: const TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              note["date"]!,
              style: TextStyle(color: Colors.white.withAlpha(102), fontSize: 12),
            ),
          ],
        ),
        _buildDeleteButton(index),
      ],
    );
  }

  Widget _buildDeleteButton(int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showDeleteConfirmation(index),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.redAccent.withAlpha(26),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.redAccent.withAlpha(26)),
          ),
          child: const Icon(
            Icons.delete_outline_rounded,
            color: Colors.redAccent,
            size: 18,
          ),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(int index) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => Center(
        child: SingleChildScrollView(
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B).withAlpha(230),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withAlpha(26)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(128),
                        blurRadius: 30,
                        spreadRadius: -10,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated Icon with Pulse Effect
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withAlpha(26),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withAlpha(51),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.delete_sweep_rounded,
                              color: Colors.redAccent,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Silmek İstediğinize Emin misiniz?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Bu not geri alınamaz şekilde kütüphanenizden kaldırılacak.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withAlpha(128),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                "Ä°ptal",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(179),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.redAccent.withAlpha(77),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _notes.removeAt(index);
                                  });
                                  Navigator.pop(context, true);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: const [
                                          Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                                          SizedBox(width: 12),
                                          Text("Not başarıyla temizlendi"),
                                        ],
                                      ),
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Text(
                                  "Sil",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddNoteDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String selectedTag = "Gelişim";
    final tags = ["Gelişim", "Performans", "Beslenme", "Genel"];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1F2B).withAlpha(242),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white.withAlpha(26)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Yeni Not",
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField("Başlık", titleController, icon: Icons.title_rounded),
                      const SizedBox(height: 16),
                      _buildTextField("Notunuz", contentController, maxLines: 4, icon: Icons.notes_rounded),
                      const SizedBox(height: 20),
                      const Text(
                        "Kategori",
                        style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: tags.map((tag) => GestureDetector(
                          onTap: () => setDialogState(() => selectedTag = tag),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: selectedTag == tag ? AppColors.primary : Colors.white.withAlpha(13),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedTag == tag ? AppColors.primary : Colors.white.withAlpha(26),
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: selectedTag == tag ? Colors.white : Colors.white60,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Ä°ptal", style: TextStyle(color: Colors.white.withAlpha(153))),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (contentController.text.isNotEmpty && titleController.text.isNotEmpty) {
                                  setState(() {
                                    _notes.insert(0, {
                                      "date": "21.01.2026",
                                      "title": titleController.text,
                                      "content": contentController.text,
                                      "tag": selectedTag,
                                    });
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              ),
                              child: const Text("Kaydet", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {int maxLines = 1, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withAlpha(26)),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.white30, size: 20),
          hintStyle: const TextStyle(color: Colors.white30),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  void _showViewNoteDialog(Map<String, String> note) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1F2B).withAlpha(242),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withAlpha(26)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(26),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          note["tag"] ?? "Genel",
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        note["date"]!,
                        style: TextStyle(
                          color: Colors.white.withAlpha(102),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    note["title"] ?? "Başlıksız Not",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Text(
                        note["content"]!,
                        style: TextStyle(
                          color: Colors.white.withAlpha(204),
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withAlpha(13),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(color: Colors.white.withAlpha(26)),
                      ),
                      child: const Text(
                        "Kapat",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

