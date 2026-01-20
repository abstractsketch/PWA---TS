import 'package:flutter/material.dart';
import 'package:projekt_i/ZSections/Bibliothek/Artikelinfo.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveLayout.dart';
import 'package:projekt_i/ZZaware/2%20Layout-Page/ResponsiveWrapper.dart' hide AppColors;
import 'package:projekt_i/ZZaware/4%20Bibliothek/ArticleDetailPage.dart';
import 'package:projekt_i/ZZaware/4%20Bibliothek/ArticlePage.dart';
import 'package:projekt_i/main.dart';

class Bibliothek2 extends StatefulWidget {
  const Bibliothek2({super.key});

  @override
  State<Bibliothek2> createState() => _Bibliothek2State();
}

class _Bibliothek2State extends State<Bibliothek2> {

  // Zustand für Suche und Filter
  String _selectedCategory = 'Alles';
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> categories = [
    'Alles',
    'Achtsamkeit',
    'Dankbarkeit',
    'Selbstreflektion',
    'Journalprompts'
  ];

  // Dummy Daten
  final List<Article> allArticles = [
    Article(
      title: 'Meditation und das Gehirn',
      description: 'Wie regelmäßiges Sitzen in Stille die graue Substanz verändert.',
      category: 'Wissenschaft',
      imageUrl: 'https://images.unsplash.com/photo-1559757175-5700dde675bc?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 5),
      content:
        'Lange Zeit dachte man, das erwachsene Gehirn sei unveränderbar. Heute wissen wir dank der Neuroplastizität: Das Gehirn ist wie ein Muskel.\n\n'
        'MRT-Studien der Harvard University haben gezeigt, dass bereits 8 Wochen Achtsamkeitstraining die Dichte der grauen Substanz im Hippocampus erhöhen – dem Bereich, der für Lernen und Gedächtnis zuständig ist. Gleichzeitig verkleinert sich die Amygdala, unser "Angstzentrum".\n\n'
        'Das bedeutet physikalisch: Wir werden widerstandsfähiger gegen Stress, nicht weil wir ihn ignorieren, sondern weil unser Gehirn strukturell besser darin wird, Emotionen zu regulieren.',
      readTime: '5 Min.',
      highlightQuote: 'Das Gehirn formt sich nach dem, worauf der Geist ruht.',
    ),
    Article(
      title: 'Der Vagus-Nerv: Dein innerer Bremser',
      description: 'Warum tiefes Atmen physiologisch sofortigen Stressabbau bewirkt.',
      category: 'Körper & Geist',
      imageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 8),
      content:
        'Hast du dich je gefragt, warum man sagt "Atme erst mal tief durch"? Der Grund ist der Vagus-Nerv. Er ist der Hauptnerv des Parasympathikus, unseres Ruhe-Nervensystems.\n\n'
        'Wenn wir gestresst sind, atmen wir flach und schnell. Das signalisiert dem Körper "Gefahr". Wenn wir jedoch die Ausatmung bewusst verlängern (z.B. 4 Sekunden ein, 6 Sekunden aus), stimulieren wir den Vagus-Nerv mechanisch über das Zwerchfell.\n\n'
        'Das Ergebnis: Der Herzschlag verlangsamt sich, der Blutdruck sinkt und Muskelspannung lässt nach. Du hackst quasi dein eigenes Nervensystem.',
      readTime: '3 Min.',
      highlightQuote: 'Der Atem ist die Fernbedienung für dein Nervensystem.',
    ),
    Article(
      title: 'Shinrin-yoku: Die Medizin des Waldes',
      description: 'Warum ein Spaziergang im Grünen messbar das Immunsystem stärkt.',
      category: 'Natur',
      imageUrl: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 12),
      content:
        'In Japan ist "Shinrin-yoku" (Waldbaden) eine anerkannte Methode der Gesundheitsvorsorge. Es geht dabei nicht um Wandern oder Sport, sondern um das bloße Dasein unter Bäumen.\n\n'
        'Bäume stoßen ätherische Öle aus, sogenannte Phytonzide, um sich vor Insekten zu schützen. Wenn wir diese einatmen, steigt die Anzahl unserer natürlichen Killerzellen (NK-Zellen) im Blut an, die Viren und Tumore bekämpfen.\n\n'
        'Gleichzeitig sinkt der Cortisolspiegel signifikant stärker als bei einem Spaziergang in der Stadt. Die Natur ist also nicht nur Kulisse, sondern Medizin.',
      readTime: '4 Min.',
      highlightQuote: 'In der Natur ist nichts perfekt und doch ist alles vollkommen.',
    ),
    Article(
      title: 'Selbstmitgefühl statt Selbstkritik',
      description: 'Wie wir lernen, unser eigener bester Freund zu sein.',
      category: 'Selbstliebe',
      imageUrl: 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 15),
      content:
        'Viele von uns haben einen inneren Kritiker, der uns bei Fehlern hart verurteilt. Wir glauben oft, diese Härte sei notwendig, um voranzukommen. Die Forschung von Dr. Kristin Neff zeigt das Gegenteil.\n\n'
        'Selbstkritik aktiviert das Bedrohungssystem des Körpers (Kampf-oder-Flucht). Selbstmitgefühl hingegen setzt Oxytocin frei, das Hormon für Bindung und Sicherheit.\n\n'
        'Menschen mit höherem Selbstmitgefühl sind emotional stabiler, weniger anfällig für Depressionen und – überraschenderweise – motivierter, nach Fehlern weiterzumachen, da sie keine Angst vor dem Scheitern haben müssen.',
      readTime: '5 Min.',
      highlightQuote: 'Sei du selbst die Person, die du am meisten brauchst.',
    ),
    Article(
      title: 'Digital Detox und Dopamin',
      description: 'Warum ständige Erreichbarkeit uns unglücklich macht und wie wir den Fokus zurückgewinnen.',
      category: 'Fokus',
      imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 18),
      content:
        'Jedes "Ping" auf dem Smartphone löst einen kleinen Dopamin-Kick aus. Wir sind programmiert, auf neue Reize zu reagieren. Das Problem: Unser Gehirn kommt nie in den Ruhemodus (Default Mode Network).\n\n'
        'Ständige Unterbrechungen erhöhen den kognitiven "Switching Cost". Wir werden müder und machen mehr Fehler. Ein bewusster Umgang mit Technologie – z.B. das Handy eine Stunde vor dem Schlafengehen weglegen – kann Wunder wirken.\n\n'
        'Langeweile ist nichts Schlechtes. Sie ist oft der Geburtsort von Kreativität und echter Erholung.',
      readTime: '4 Min.',
      highlightQuote: 'Wohin die Aufmerksamkeit geht, dahin fließt die Energie.',
    ),
    Article(
      title: 'Der Body Scan: Raus aus dem Kopf',
      description: 'Eine Reise durch den Körper, um emotionale Blockaden zu lösen.',
      category: 'Meditation',
      imageUrl: 'https://images.unsplash.com/photo-1506252374453-ef5237291d83?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 21),
      content:
        'Wir leben oft nur in unserem Kopf und spüren unseren Körper erst, wenn er schmerzt. Der Body Scan ist eine Achtsamkeitsübung, bei der wir mental jeden Körperteil "abwandern".\n\n'
        'Emotionen manifestieren sich oft körperlich: Stress sitzt im Nacken, Angst im Magen, Trauer in der Brust. Durch das bewusste Spüren dieser Bereiche (Interozeption) können wir Spannungen loslassen.\n\n'
        'Es geht nicht darum, etwas zu verändern oder zu entspannen, sondern nur darum, wahrzunehmen, was gerade da ist. Paradoxerweise tritt genau dann oft die Entspannung ein.',
      readTime: '6 Min.',
      highlightQuote: 'Der Körper ist der Übersetzer der Seele ins Sichtbare.',
    ),
    Article(
      title: 'Achtsames Essen',
      description: 'Warum "Wie" wir essen genauso wichtig ist wie "Was" wir essen.',
      category: 'Gesundheit',
      imageUrl: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 25),
      content:
        'In unserer schnellen Welt essen wir oft nebenbei: vor dem Fernseher, beim Arbeiten oder Scrollen. Das Gehirn registriert dabei oft gar nicht, dass wir satt sind.\n\n'
        'Verdauung beginnt im Kopf (die sogenannte cephale Phase). Wenn wir das Essen riechen und bewusst kauen, bereitet sich der Magen optimal vor. Achtsames Essen hilft nicht nur beim Abnehmen, sondern steigert vor allem den Genuss.\n\n'
        'Versuche einmal, die erste Minute deiner Mahlzeit in völliger Stille zu verbringen und dich nur auf Geschmack und Textur zu konzentrieren.',
      readTime: '3 Min.',
      highlightQuote: 'Wenn du isst, dann iss. Wenn du gehst, dann geh.',
    ),
    Article(
      title: 'Der Flow-Zustand',
      description: 'Das Geheimnis völliger Vertiefung und wie wir es erreichen.',
      category: 'Psychologie',
      imageUrl: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 28),
      content:
        'Kennst du Momente, in denen du Zeit und Raum vergisst? Der Psychologe Mihály Csíkszentmihályi nannte dies den "Flow".\n\n'
        'Im Flow verstummt der innere Kritiker. Das Gehirn schaltet in einen energieeffizienten Modus, und wir fühlen uns tief befriedigt. Flow entsteht, wenn die Herausforderung einer Aufgabe genau unseren Fähigkeiten entspricht – nicht zu schwer (Angst), nicht zu leicht (Langeweile).\n\n'
        'Achtsamkeitstraining hilft uns, diesen Zustand öfter zu erreichen, da es unsere Konzentrationsfähigkeit schärft und Ablenkungen minimiert.',
      readTime: '5 Min.',
      highlightQuote: 'Glück ist das Nebenprodukt von Hingabe.',
    ),
    Article(
      title: 'Kälte als Energiequelle',
      description: 'Warum eine kalte Dusche mehr bewirkt als nur wach zu machen.',
      category: 'Biohacking',
      imageUrl: 'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 7, 20),
      content:
        'Sich freiwillig Kälte auszusetzen, klingt erst einmal unangenehm. Doch Methoden wie das Eisbaden oder kalte Duschen (Hydrotherapie) haben messbare Effekte auf unsere Biochemie.\n\n'
        'Kälte sorgt für einen massiven Ausstoß von Noradrenalin und kann den Dopaminspiegel um bis zu 250% steigern – ähnlich stark wie Nikotin, aber ohne die negativen Nebenwirkungen. Dieser Effekt hält oft Stunden an und sorgt für Fokus und gute Laune.\n\n'
        'Zudem ist es ein mentales Training: Wer morgens die Überwindung aufbringt, den Hahn auf "Kalt" zu drehen, stärkt seine Willenskraft für andere Herausforderungen des Tages.',
      readTime: '4 Min.',
      highlightQuote: 'Wer die Kälte umarmt, findet Wärme in sich selbst.',
    ),
    Article(
      title: 'Die Macht der kleinen Schritte',
      description: 'Warum 1% Verbesserung jeden Tag besser ist als radikale Veränderungen.',
      category: 'Gewohnheiten',
      imageUrl: 'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 7, 5),
      content:
        'Wir überschätzen oft, was wir an einem Tag erreichen können, und unterschätzen völlig, was wir in einem Jahr schaffen können. Das Geheimnis liegt im "Compound Effect" (Zinseszinseffekt).\n\n'
        'Wenn du dich jeden Tag nur um 1% verbesserst, bist du am Ende des Jahres 37-mal besser als zu Beginn. Wenn du versuchst, dein Leben über Nacht komplett umzukrempeln, scheiterst du meist an der Überforderung.\n\n'
        'Starte winzig: Statt "Ich meditiere 30 Minuten", beginne mit "Ich atme einmal bewusst, bevor ich den Kaffee trinke".',
      readTime: '3 Min.',
      highlightQuote: 'Erfolg ist die Summe kleiner Anstrengungen, die sich jeden Tag wiederholen.',
    ),
    Article(
      title: 'Stille in einer lauten Welt',
      description: 'Lärm ist unsichtbarer Stress. Wie Stille unsere Gehirnzellen regeneriert.',
      category: 'Ruhe',
      imageUrl: 'https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 7, 9),
      content:
        'Unsere Welt ist laut geworden. Verkehr, Benachrichtigungen, Musik, Podcasts. Unser Gehirn muss diese Reize ständig verarbeiten. Studien an Mäusen haben gezeigt, dass täglich zwei Stunden Stille das Wachstum neuer Zellen im Hippocampus fördern.\n\n'
        'Stille ist kein leerer Raum, sondern ein Raum voller Möglichkeiten für das Gehirn, in den "Default Mode" zu schalten und Erlebtes zu integrieren.\n\n'
        'Versuche "Silent Commuting": Fahre zur Arbeit oder gehe einkaufen, ohne Kopfhörer und ohne Radio. Einfach nur wahrnehmen.',
      readTime: '4 Min.',
      highlightQuote: 'Die Stille ist nicht leer, sie ist voller Antworten.',
    ),
    Article(
      title: 'Die Kunst des Vergebens',
      description: 'Vergebung ist kein Geschenk an andere, sondern Heilung für dich selbst.',
      category: 'Emotionen',
      imageUrl: 'https://images.unsplash.com/photo-1470116892389-0de5d9770b2c?auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 7, 12),
      content:
        'Groll und Wut festzuhalten ist wie glühende Kohlen in die Hand zu nehmen, um sie nach jemand anderem zu werfen – man verbrennt sich dabei nur selbst.\n\n'
        'Chronischer Groll hält den Körper im Stressmodus (hoher Blutdruck, geschwächtes Immunsystem). Vergebung bedeutet nicht, gutzuheißen, was passiert ist. Es bedeutet, die emotionale Bindung an das Ereignis zu lösen, damit es keine Macht mehr über deine Gegenwart hat.\n\n'
        'Es ist ein Prozess des Loslassens, um wieder Platz für Freude zu schaffen.',
      readTime: '5 Min.',
      highlightQuote: 'Vergebung ändert nicht die Vergangenheit, aber sie erweitert die Zukunft.',
    ),
    Article(
      title: 'Stille: Warum sie uns gut tut',
      description: 'Völlige Ruhe - heutzutage selten',
      category: 'Achtsamkeit',
      imageUrl: 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60', // Hände/Sonne
      date: DateTime(2024, 6, 1),
      content: 
        'In unserer modernen Welt ist echte Stille ein rares Gut geworden. Wir sind umgeben von ständiem Lärm: Verkehr, Baustellen, Musik in Geschäften und vor allem das digitale Rauschen von Benachrichtigungen. Unser Gehirn ist im Dauerzustand der Reizverarbeitung.\n\n'
        'Dabei ist Stille kein leerer Raum, sondern eine biologische Notwendigkeit. Studien zeigen, dass bereits zwei Stunden Stille pro Tag die Entwicklung neuer Zellen im Hippocampus fördern können - der Region im Gehirn, die für das Gedächtnis und Emotionen zuständig ist.\n\n'
        'Wenn die äußeren Geräusche verstummen, geschieht etwas Faszinierendes: Wir beginnen, uns selbst wieder zu hören. Viele Menschen fürchten diesen Moment, weil dann auch verdrängte Gedanken hochkommen können. Doch genau hier liegt das Potenzial zur Heilung. Stille zwingt uns, ehrlich zu uns selbst zu sein.\n\n'
        'Versuche, "Stille-Inseln" in deinen Tag einzubauen. Das muss keine stundenlange Meditation sein. Es reicht oft schon, das Radio im Auto auszuschalten oder den Morgenkaffee ohne Smartphone zu trinken. In der Stille finden wir oft die Antworten, die im Lärm des Alltags untergehen.',
      readTime: '3 Min.',
      highlightQuote: 'Stille ist nicht leer, sie ist voller Antworten.',
    ),
    Article(
      title: 'Die Kraft der Dankbarkeit',
      description: 'Was bewirkt das tägliche Kultivieren von Dankbarkeit in Menschen?',
      category: 'Dankbarkeit',
      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 2),
      content: 
        'Dankbarkeit ist weit mehr als nur eine höfliche Geste. Die Neurowissenschaft zeigt, dass das aktive Praktizieren von Dankbarkeit die Struktur unseres Gehirns nachhaltig verändern kann (Neuroplastizität).\n\n'
        'Wenn wir uns auf das konzentrieren, was wir haben, anstatt auf das, was uns fehlt, schüttet unser Gehirn Dopamin und Serotonin aus. Es geht nicht darum, Probleme zu ignorieren ("Toxic Positivity"), sondern den Fokus zu weiten. Auch an schlechten Tagen gibt es den warmen Kaffee oder ein Dach über dem Kopf.\n\n'
        'Eine effektive Übung: Schreibe jeden Abend drei Dinge auf, für die du heute dankbar bist. Nach 21 Tagen wirst du bemerken, dass du automatisch anfängst, den Tag über nach diesen "Goldstücken" zu scannen. Dein Gehirn lernt, das Positive schneller wahrzunehmen.',
      readTime: '4 Min.',
      highlightQuote: 'Nicht die Glücklichen sind dankbar. Es sind die Dankbaren, die glücklich sind.',
    ),
    Article(
      title: 'Journaling für Anfänger',
      description: 'Wie du Journalprompts effektiv nutzt, um Gedanken zu ordnen.',
      category: 'Journalprompts',
      imageUrl: 'https://images.unsplash.com/photo-1517842645767-c639042777db?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 5),
      content: 
        'Papier ist geduldig – und genau das macht Journaling zu einem so mächtigen Werkzeug für unsere mentale Gesundheit. Viele Anfänger stehen vor der leeren Seite und wissen nicht, wie sie beginnen sollen. Hier helfen "Prompts" (Impulsfragen).\n\n'
        'Fragen wie "Was hat mir heute Energie gegeben und was hat sie mir geraubt?" können tiefgreifende Muster in deinem Alltag aufdecken. Eine weitere Methode ist der "Brain Dump": Schreibe morgens alles auf, was dir durch den Kopf geht, ohne auf Grammatik zu achten.\n\n'
        'Indem wir unsere Sorgen aufschreiben, externalisieren wir sie. Sie wirken auf dem Papier oft kleiner und handhabbarer als in unserem Kopf, wo sie als diffuse Ängste herumgeistern. Journaling schafft Distanz zwischen dir und deinen Gedanken.',
      readTime: '5 Min.',
      highlightQuote: 'Schreiben ist das Gespräch, das du mit deiner Seele führst.',
    ),
    Article(
      title: 'Meditation am Morgen',
      description: 'Warum ein achtsamer Start den ganzen Tag verändert.',
      category: 'Achtsamkeit',
      imageUrl: 'https://images.unsplash.com/photo-1593811167562-9cef47bfc4d7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
      date: DateTime(2024, 6, 10),
      content: 
        'Wie startest du in den Tag? Für viele ist der erste Griff am Morgen der zum Smartphone. Bevor wir überhaupt richtig wach sind, ist unser Gehirn bereits im Reaktionsmodus auf Nachrichten und News.\n\n'
        'Eine morgendliche Meditation setzt einen völlig anderen Ton. Indem wir uns 10 Minuten Zeit nehmen, um unseren Atem zu spüren, aktivieren wir den Parasympathikus – unseren Ruhenerv. Wir agieren, statt nur zu reagieren.\n\n'
        'Du musst dafür kein Zen-Meister sein. Setze dich einfach aufrecht hin, schließe die Augen und frage dich: "Mit welcher Intention möchte ich heute durch den Tag gehen?" Vielleicht ist es Gelassenheit, vielleicht Fokus. Dieser innere Kompass hilft dir später, wenn der Stresspegel steigt.',
      readTime: '6 Min.',
      highlightQuote: 'Der Morgen hat Gold im Mund, aber nur, wenn er dir gehört.',
    ),
    
  ];

  @override
  Widget build(BuildContext context) {
    // 1. FILTER LOGIK
    final filteredArticles = allArticles.where((article) {
      final matchCategory = _selectedCategory == 'Alles' || article.category == _selectedCategory;
      final matchSearch = article.title.toLowerCase().contains(_searchText.toLowerCase()) || 
                          article.description.toLowerCase().contains(_searchText.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();

    // Responsive Spaltenanzahl berechnen
    double width = MediaQuery.of(context).size.width;
    int gridCount = width > 1100 ? 4 : (width > 600 ? 2 : 1);

    return Scaffold(
      backgroundColor: AppColors.bgLight,

      body: SingleChildScrollView( 
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bibliothek',
                      style: TextStyle(
                          color: AppColors.tealDark,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.1),
                    ),
                const SizedBox(height: 25),

                  // SUCHLEISTE
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Suchen...',
                        border: InputBorder.none,
                        prefixIcon: SizedBox(width: 20), // Platzhalter links
                        suffixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 20.0),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // KATEGORIE FILTER CHIPS
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: categories.map((cat) {
                        final isSelected = _selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = cat;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.tealDark : AppColors.tealPrimary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                cat,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  const SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _selectedCategory == 'Alles' 
                            ? (_searchText.isEmpty ? 'Alle Artikel' : 'Suchergebnisse') 
                            : _selectedCategory,
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          color: AppColors.text,
                          fontFamily: 'Serif' 
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // GRID VIEW
                  filteredArticles.isEmpty 
                  ? const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Text("Keine Artikel gefunden.", style: TextStyle(color: Colors.grey)),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Scrollt mit der Seite mit
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCount,
                        childAspectRatio: 0.75, // Verhältnis Höhe/Breite der Karte
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: filteredArticles.length,
                      itemBuilder: (context, index) {
                        return LibraryCard(
                          article: filteredArticles[index],
                          tagColor: AppColors.orangeEnd,
                        );
                      },
                    ),
                    
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
        ),
      ),
      );
  }
}

class LibraryCard extends StatelessWidget {
  final Article article;
  final Color tagColor;

  const LibraryCard({super.key, required this.article, required this.tagColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigation zur Detailseite
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(article: article),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias, // Damit das Bild die Ecken nicht überlappt
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BILD BEREICH (Groß, wie im Design)
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.blueGrey[100], // Platzhalterfarbe, falls Bild lädt
                width: double.infinity,
                child: Image.network(
                  article.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
              ),
            ),
            
            // TEXT BEREICH
            Expanded(
              flex: 3, // Verhältnis Bild zu Text anpassen
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategorie Tag
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        article.category,
                        style: const TextStyle(
                          color: Colors.white, 
                          fontSize: 12, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Titel
                    Text(
                      article.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Beschreibung (klein im Rahmen)
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                         article.description,
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                         style: const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
