import 'package:flutter/material.dart';
import 'package:projekt_i/main.dart';

class JournalPromptSlider extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;

  const JournalPromptSlider({
    Key? key,
    required this.dataList,
  }) : super(key: key);

  @override
  State<JournalPromptSlider> createState() => _JournalPromptSliderState();
}

class _JournalPromptSliderState extends State<JournalPromptSlider> {
  final ScrollController _scrollController = ScrollController();

  bool _showLeftButton = false;
  bool _showRightButton = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollListener());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;
    final offset = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;
    const tolerance = 5.0;

    // Falls Liste zu kurz ist und gar nicht scrollt
    if (maxScroll <= 0) {
      if (_showLeftButton || _showRightButton) {
        setState(() {
          _showLeftButton = false;
          _showRightButton = false;
        });
      }
      return;
    }

    final showLeft = offset > tolerance;
    final showRight = offset < (maxScroll - tolerance);

    if (showLeft != _showLeftButton || showRight != _showRightButton) {
      setState(() {
        _showLeftButton = showLeft;
        _showRightButton = showRight;
      });
    }
  }

  void _scrollNext() {
    if (_scrollController.hasClients) {
      // Scrolle genau eine Kartenbreite (280) + Padding (16) weiter
      final double scrollAmount = 296; 
      _scrollController.animateTo(
        _scrollController.offset + scrollAmount,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _scrollPrev() {
    if (_scrollController.hasClients) {
      final double scrollAmount = 296;
      _scrollController.animateTo(
        _scrollController.offset - scrollAmount,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. KOPFZEILE: TITEL LINKS, BUTTONS RECHTS
        Padding(
          padding: const EdgeInsets.only(bottom: 15, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TITEL
              const Text(
                "Journalprompts",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tealDark,
                ),
              ),

              // BUTTON GRUPPE
              Row(
                children: [
                  // LINKER BUTTON
                  Visibility(
                    visible: _showLeftButton,
                    child: _buildArrowButton(
                      icon: Icons.arrow_back_ios_new,
                      onTap: _scrollPrev,
                    ),
                  ),
                  
                  SizedBox(width: _showLeftButton && _showRightButton ? 10 : 0),

                  // RECHTER BUTTON
                  Visibility(
                    visible: _showRightButton,
                    child: _buildArrowButton(
                      icon: Icons.arrow_forward_ios,
                      onTap: _scrollNext,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // 2. SLIDER BEREICH
        SizedBox(
          height: 320, // Höhe angepasst an das Kartendesign
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.dataList.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(right: 20), // Padding am Ende der Liste
            itemBuilder: (context, index) {
              final item = widget.dataList[index];
              
              return Padding(
                padding: const EdgeInsets.only(right: 16), // Abstand zwischen Karten
                child: JournalCard(
                  title: item['title'] ?? 'Titel',
                  description: item['desc'] ?? 'Beschreibung',
                  tag: item['tag'] ?? 'GROWTH',
                  onTap: () {
                     // Navigations-Logik hier
                     if (item['targetPage'] != null) {
                       Navigator.push(
                         context, 
                         MaterialPageRoute(builder: (context) => item['targetPage'])
                       );
                     }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Hilfswidget für die runden Pfeil-Buttons
  Widget _buildArrowButton({required IconData icon, required VoidCallback onTap}) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.tealPrimary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 18,
        icon: Icon(icon, color: AppColors.tealPrimary),
        onPressed: onTap,
      ),
    );
  }
}

class JournalCard extends StatelessWidget {
  final String title;
  final String description;
  final String tag;
  final VoidCallback onTap;

  const JournalCard({
    Key? key,
    required this.title,
    required this.description,
    required this.tag,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, 
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6, 
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // Hier nutzen wir AppColors für den Verlauf
                      colors: [
                        AppColors.tealPrimary, // Helleres Teal oben links
                        AppColors.tealDark,    // Dunkles Teal unten rechts
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Haupttitel (Weiß)
                      Text(
                        title,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 4, 
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTag(tag),
                      Text(
                        description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.orangeStart.withOpacity(1),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
        fontSize: 10),
      ),

    );
  }
}