import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Notizen/Reflektion.dart';

// --- MAIN (Nur zum Testen, in deiner echten App ist das in main.dart) ---
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StartPage(),
  ));
}

// --- HAUPTSEITE (Alles in einer Struktur) ---
class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  // Controller für das neue Material 3 Carousel
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Bildschirmhöhe für relative Größen
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white, // Sauberer Hintergrund
      body: ListView(
        padding: const EdgeInsets.only(bottom: 40), // Platz unten
        children: <Widget>[
          
          // 1. Das große Header-Karussell
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: screenHeight * 0.45), // Max 45% der Höhe
            child: CarouselView.weighted(
              controller: controller,
              itemSnapping: true,
              flexWeights: const <int>[1, 7, 1],
              // Wir nutzen das umbenannte Enum 'AppContentData'
              children: AppContentData.values.map((AppContentData data) {
                return HeroLayoutCard(contentData: data);
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),

          // 2. Platzhalter für DailyQuoteBox (Dein Widget)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: PlaceholderQuoteBox(), 
          ),

          const SizedBox(height: 20),

          // 3. Kategorien Überschrift
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'Kategorien',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // 4. Kleines Farb-Karussell
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 60),
            child: CarouselView.weighted(
              flexWeights: const <int>[1, 2, 3, 2, 1],
              consumeMaxWeight: false,
              children: List<Widget>.generate(10, (int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 20),

          // 5. Reflektion Überschrift
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'Reflektion:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // 6. Die zwei großen Buttons (Morgen & Abend)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildReflectionCard(
                  context,
                  title: "Morgenreflektion",
                  color: Colors.blue,
                  onTap: () => _navigateToOverview(context),
                ),
                const SizedBox(width: 16), // Abstand zwischen den Cards
                _buildReflectionCard(
                  context,
                  title: "Abendreflektion",
                  color: const Color.fromARGB(255, 0, 174, 47),
                  onTap: () => _navigateToOverview(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hilfsmethode um Code-Duplizierung bei den Buttons zu vermeiden
  Widget _buildReflectionCard(BuildContext context, {required String title, required Color color, required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 180, // Feste Höhe für die Kacheln
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white, 
                fontSize: 16, 
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToOverview(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Reflektion()),
    );
  }
}

// --- WIDGETS ---

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.contentData});

  final AppContentData contentData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // Füllt den gesamten verfügbaren Platz im Carousel
      children: <Widget>[
        Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/material/${contentData.url}',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
        ),
        // Verlauf damit Text lesbar ist
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              stops: const [0.6, 1.0],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                contentData.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 4),
              Text(
                contentData.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
            ],
          ),
        ),
      ],
    );
  }
}

// --- DUMMY PLACEHOLDERS (Ersatz für deine fehlenden Imports) ---

class PlaceholderQuoteBox extends StatelessWidget {
  const PlaceholderQuoteBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: const Column(
        children: [
          Icon(Icons.format_quote, color: Colors.orange),
          SizedBox(height: 8),
          Text("Hier steht dein tägliches Zitat.", textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// --- DATEN MODELLE (ENUMS) ---

// WICHTIG: Umbenannt von ImageInfo zu AppContentData, da ImageInfo bereits in Flutter existiert
enum AppContentData {
  flow('Flow', 'Atemübungen um in den Moment zu kommen', 'content_based_color_scheme_1.png'),
  entspannung('Entspannung', 'Kurze Meditationen für zwischendurch', 'content_based_color_scheme_2.png'),
  achtsamkeit('Achtsamkeit', 'Geführte Übungen zur Aufmerksamkeit', 'content_based_color_scheme_3.png'),
  beats('Binaurale Beats', 'Klänge zur Entspannung', 'content_based_color_scheme_4.png'),
  journal('Journal', 'Ein persönliches Tagebuch', 'content_based_color_scheme_5.png'),
  dankbarkeit('Dankbarkeit', 'Tägliche Übungen', 'content_based_color_scheme_6.png');

  const AppContentData(this.title, this.subtitle, this.url);
  final String title;
  final String subtitle;
  final String url;
}

/*
import 'package:flutter/material.dart';
import 'package:projekt_i/Login%202/Widgets/DailyQuoteBox.dart';
import 'package:projekt_i/Login%202/Seiten%203/Dankbarkeit_Kat.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: 
        const CarouselExample(),
      ),
    );
  }
}

class CarouselExample extends StatefulWidget {
  const CarouselExample({super.key});

  @override
  State<CarouselExample> createState() => _CarouselExampleState();
}

class _CarouselExampleState extends State<CarouselExample> {
  final CarouselController controller = CarouselController(initialItem: 1);
  final Map<String, int> _ratings = {
    'Schlaf': 0,
    'Stresslevel': 0,
    'Ernährung': 0,
    'Stimmung': 0,
  };

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    return ListView(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height / 2),
          child: CarouselView.weighted(
            controller: controller,
            itemSnapping: true,
            flexWeights: const <int>[1, 7, 1],
            children: ImageInfo.values.map((ImageInfo image) {
              return HeroLayoutCard(imageInfo: image);
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
        DailyQuoteBox(),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
          child: Text('Kategorien'),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 50),
          child: CarouselView.weighted(
            flexWeights: const <int>[1, 2, 3, 2, 1],
            consumeMaxWeight: false,
            children: List<Widget>.generate(20, (int index) {
              return ColoredBox(
                color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.8),
                child: const SizedBox.expand(),
              );
            }),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
          child: Text('Reflektion:'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0), 
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UebersichtSeite(), 
                      ),
                    );
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "Morgenreflektion",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UebersichtSeite(),
                      ),
                    );  
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 174, 47),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "Abendreflektion",
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              
            ],
          ),
        ),  
      ],
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.imageInfo});

  final ImageInfo imageInfo;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        ClipRect(
          child: OverflowBox(
            maxWidth: width * 7 / 8,
            minWidth: width * 7 / 8,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/material/${imageInfo.url}',
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                imageInfo.title,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                imageInfo.subtitle,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({super.key, required this.index, required this.label});

  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.5),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          overflow: TextOverflow.clip,
          softWrap: false,
        ),
      ),
    );
  }
}

enum CardInfo {
  camera('Cameras', Icons.video_call, Color(0xff2354C7), Color(0xffECEFFD)),
  lighting('Lighting', Icons.lightbulb, Color(0xff806C2A), Color(0xffFAEEDF)),
  climate('Climate', Icons.thermostat, Color(0xffA44D2A), Color(0xffFAEDE7)),
  wifi('Wifi', Icons.wifi, Color(0xff417345), Color(0xffE5F4E0)),
  media('Media', Icons.library_music, Color(0xff2556C8), Color(0xffECEFFD)),
  security('Security', Icons.crisis_alert, Color(0xff794C01), Color(0xffFAEEDF)),
  safety('Safety', Icons.medical_services, Color(0xff2251C5), Color(0xffECEFFD)),
  more('', Icons.add, Color(0xff201D1C), Color(0xffE3DFD8));

  const CardInfo(this.label, this.icon, this.color, this.backgroundColor);
  final String label;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
}

enum ImageInfo {
  image0('Flow', 'Atemübungenum in den Moment zu kommen', 'content_based_color_scheme_1.png'),
  image1(
    'Entspannung',
    'kurze Meditationen für zwischendurch',
    'content_based_color_scheme_2.png',
  ),
  image2('Achtsamkeit', 'Geführte Übungen zur Steigerung der Aufmerksamkeit', 'content_based_color_scheme_3.png'),
  image3('Binaurale Beats', 'Klänge zur Entspannung und Konzentration', 'content_based_color_scheme_4.png'),
  image4('Journal', 'Ein persönliches Tagebuch für Gedanken und Gefühle', 'content_based_color_scheme_5.png'),
  image5('Dankbarkeit', 'Tägliche Übungen zur Förderung positiver Gedanken', 'content_based_color_scheme_6.png');

  const ImageInfo(this.title, this.subtitle, this.url);
  final String title;
  final String subtitle;
  final String url;
}
*/ 