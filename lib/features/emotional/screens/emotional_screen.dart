import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../../../shared/widgets/nitara_card.dart';

class EmotionalScreen extends StatefulWidget {
  const EmotionalScreen({super.key});

  @override
  State<EmotionalScreen> createState() => _EmotionalScreenState();
}

class _EmotionalScreenState extends State<EmotionalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? NitaraColors.backgroundDark : NitaraColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Self Care 💆',
                    style: GoogleFonts.nunito(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : NitaraColors.textDark,
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                  Text(
                    'Nurture your mind, body & spirit',
                    style: GoogleFonts.nunito(fontSize: 14, color: NitaraColors.textLight),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: isDark ? NitaraColors.surfaceDark : NitaraColors.lavenderPastel,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: NitaraColors.textMedium,
                  indicator: BoxDecoration(
                    gradient: NitaraColors.emotionalGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelStyle: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700),
                  tabs: const [
                    Tab(text: 'Quotes'),
                    Tab(text: 'Affirm'),
                    Tab(text: 'Relax'),
                    Tab(text: 'Partner'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _QuotesTab(),
                  _AffirmationsTab(),
                  _RelaxationTab(),
                  _PartnerTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuotesTab extends StatefulWidget {
  const _QuotesTab();

  @override
  State<_QuotesTab> createState() => _QuotesTabState();
}

class _QuotesTabState extends State<_QuotesTab> {
  int _currentQuoteIndex = 0;

  static const List<Map<String, String>> _quotes = [
    {'quote': '"A mother\'s love for her child is like nothing else in the world."', 'author': 'Agatha Christie'},
    {'quote': '"Making the decision to have a child is to decide forever to have your heart go walking around outside your body."', 'author': 'Elizabeth Stone'},
    {'quote': '"Birth is not only about making babies. Birth is about making mothers — strong, competent, capable mothers."', 'author': 'Barbara Katz Rothman'},
    {'quote': '"You are braver than you believe, stronger than you seem, and smarter than you think."', 'author': 'A.A. Milne'},
    {'quote': '"The moment a child is born, the mother is also born."', 'author': 'Rajneesh'},
    {'quote': '"Giving birth is an ecstatic jubilant adventure not available to males. It is a woman\'s crowning creative experience."', 'author': 'John Stevenson'},
    {'quote': '"You are not just growing a baby. You are growing as a woman."', 'author': 'Unknown'},
    {'quote': '"Every day that I carry you inside me is a day I am already your mother."', 'author': 'Unknown'},
    {'quote': '"Trust your body. It knows exactly what to do."', 'author': 'Unknown'},
    {'quote': '"You are growing a human being. Give yourself grace."', 'author': 'Unknown'},
  ];

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().day;
    final dailyIndex = today % _quotes.length;
    final quote = _quotes[_currentQuoteIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          // Daily quote card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: NitaraColors.emotionalGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: NitaraColors.lavender.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              children: [
                const Text('💕', style: TextStyle(fontSize: 32)),
                const SizedBox(height: 16),
                Text(
                  quote['quote']!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.7,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '— ${quote['author']}',
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.95, 0.95)),

          const SizedBox(height: 16),

          // Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => setState(() =>
                    _currentQuoteIndex = (_currentQuoteIndex - 1 + _quotes.length) % _quotes.length),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: NitaraColors.lavender,
              ),
              Text(
                '${_currentQuoteIndex + 1} / ${_quotes.length}',
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  color: NitaraColors.textLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () => setState(() =>
                    _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length),
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                color: NitaraColors.lavender,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // More quotes list
          NitaraSectionHeader(title: 'All Quotes'),
          const SizedBox(height: 12),
          ..._quotes.asMap().entries.skip(1).map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () => setState(() => _currentQuoteIndex = e.key),
                  child: NitaraCard(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.value['quote']!,
                          style: GoogleFonts.nunito(
                            fontSize: 13,
                            color: NitaraColors.textMedium,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '— ${e.value['author']}',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: NitaraColors.lavender,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _AffirmationsTab extends StatelessWidget {
  const _AffirmationsTab();

  static const List<Map<String, String>> _affirmations = [
    {'text': 'I am strong, capable, and ready to be a mother.', 'emoji': '💪'},
    {'text': 'My body knows exactly how to grow and nurture my baby.', 'emoji': '🌟'},
    {'text': 'I trust the process of pregnancy and birth.', 'emoji': '🌿'},
    {'text': 'I am surrounded by love and support.', 'emoji': '💕'},
    {'text': 'Every day, my baby and I grow stronger together.', 'emoji': '🌱'},
    {'text': 'I breathe in calm, and breathe out fear.', 'emoji': '✨'},
    {'text': 'I am exactly the mother my baby needs.', 'emoji': '🌸'},
    {'text': 'My instincts are powerful and my love is infinite.', 'emoji': '❤️'},
    {'text': 'I embrace all the changes in my body with gratitude.', 'emoji': '🦋'},
    {'text': 'Birth is a natural process. My body was made for this.', 'emoji': '🌙'},
    {'text': 'I am calm, centered, and prepared for birth.', 'emoji': '🕊️'},
    {'text': 'My baby feels my love and joy every day.', 'emoji': '👶'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: _affirmations.length,
      itemBuilder: (_, i) {
        final a = _affirmations[i];
        final colors = [
          NitaraColors.emotionalGradient,
          NitaraColors.babyGradient,
          NitaraColors.yogaGradient,
          NitaraColors.primaryGradient,
        ];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: colors[i % colors.length],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(a['emoji']!, style: const TextStyle(fontSize: 28)),
              const SizedBox(height: 10),
              Text(
                a['text']!,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ).animate(delay: Duration(milliseconds: i * 60)).fadeIn(duration: 400.ms).scale(begin: const Offset(0.9, 0.9));
      },
    );
  }
}

class _RelaxationTab extends StatelessWidget {
  const _RelaxationTab();

  static const List<Map<String, dynamic>> _techniques = [
    {
      'emoji': '🧘',
      'title': 'Body Scan Meditation',
      'duration': '10 min',
      'description': 'A gentle guided meditation to release tension from each part of your body, promoting deep relaxation.',
      'steps': [
        'Lie comfortably on your left side',
        'Close your eyes and take 3 deep breaths',
        'Focus attention on your feet and relax them',
        'Slowly move attention up through each body part',
        'When you reach your belly, visualize your baby',
        'Send love to your baby with each breath',
        'Rest in stillness for 2-3 minutes',
      ],
    },
    {
      'emoji': '🌊',
      'title': 'Ocean Wave Visualization',
      'duration': '8 min',
      'description': 'Visualize peaceful waves to calm your mind and prepare your body for birth.',
      'steps': [
        'Sit or lie comfortably',
        'Close your eyes and breathe slowly',
        'Imagine you are on a calm, peaceful beach',
        'Watch the ocean waves gently rolling in',
        'With each inhale, let the wave come in',
        'With each exhale, let the wave go out',
        'Stay with this image for 5-8 minutes',
      ],
    },
    {
      'emoji': '🌸',
      'title': 'Progressive Muscle Relaxation',
      'duration': '15 min',
      'description': 'Systematically tense and relax muscle groups to reduce physical tension and anxiety.',
      'steps': [
        'Lie comfortably on your left side',
        'Start with your feet — curl toes tightly for 5 seconds',
        'Release and notice the relaxation',
        'Move to calves, then thighs',
        'Continue with belly (very gently), hands, arms, shoulders',
        'Finish with facial muscles',
        'Rest quietly for 5 minutes',
      ],
    },
    {
      'emoji': '🎶',
      'title': 'Music & Humming',
      'duration': '10 min',
      'description': 'Humming or listening to soothing music creates healing vibrations that both you and baby can feel.',
      'steps': [
        'Choose calming music or nature sounds',
        'Sit comfortably and close your eyes',
        'Begin to hum softly along with the music',
        'Feel the vibrations in your chest and belly',
        'Your baby can feel these soothing vibrations',
        'Let thoughts pass without engaging them',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      itemCount: _techniques.length,
      itemBuilder: (_, i) {
        final t = _techniques[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: () => _showDetail(context, t),
            child: NitaraCard(
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: NitaraColors.emotionalGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(child: Text(t['emoji'], style: const TextStyle(fontSize: 26))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t['title'],
                            style: GoogleFonts.nunito(
                                fontSize: 15, fontWeight: FontWeight.w700, color: NitaraColors.textDark)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined, size: 12, color: NitaraColors.lavender),
                            const SizedBox(width: 4),
                            Text(t['duration'],
                                style: GoogleFonts.nunito(
                                    fontSize: 12, color: NitaraColors.lavender, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(t['description'],
                            maxLines: 2, overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(fontSize: 12, color: NitaraColors.textLight, height: 1.4)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: NitaraColors.textLight),
                ],
              ),
            ),
          ).animate(delay: Duration(milliseconds: i * 80)).fadeIn(duration: 400.ms),
        );
      },
    );
  }

  void _showDetail(BuildContext context, Map t) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(t['emoji'], style: const TextStyle(fontSize: 44))),
              const SizedBox(height: 12),
              Text(t['title'],
                  style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w800, color: NitaraColors.textDark)),
              Text(t['duration'], style: GoogleFonts.nunito(fontSize: 14, color: NitaraColors.lavender, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text(t['description'],
                  style: GoogleFonts.nunito(fontSize: 14, color: NitaraColors.textMedium, height: 1.6)),
              const SizedBox(height: 20),
              Text('How to Do It', style: GoogleFonts.nunito(fontSize: 17, fontWeight: FontWeight.w700, color: NitaraColors.textDark)),
              const SizedBox(height: 12),
              ...((t['steps'] as List).asMap().entries.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(shape: BoxShape.circle, gradient: NitaraColors.emotionalGradient),
                          child: Center(child: Text('${e.key + 1}',
                              style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white))),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(e.value,
                              style: GoogleFonts.nunito(fontSize: 14, color: NitaraColors.textMedium, height: 1.5)),
                        )),
                      ],
                    ),
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}

class _PartnerTab extends StatelessWidget {
  const _PartnerTab();

  static const List<Map<String, String>> _tips = [
    {'emoji': '🤗', 'title': 'Physical Support', 'tip': 'Offer back massages, foot rubs, and gentle hugs. Physical touch reduces anxiety and builds connection.'},
    {'emoji': '🍳', 'title': 'Help with Meals', 'tip': 'Take over cooking when she\'s tired or experiencing nausea. Surprise her with her favorite healthy foods.'},
    {'emoji': '👂', 'title': 'Listen Actively', 'tip': 'Pregnancy brings many emotions. Listen without judgment or trying to fix everything. Sometimes just being present is enough.'},
    {'emoji': '🏥', 'title': 'Attend Appointments', 'tip': 'Try to attend prenatal appointments. Hearing the heartbeat together strengthens your bond as parents.'},
    {'emoji': '📚', 'title': 'Learn Together', 'tip': 'Read about pregnancy and birth. Take a childbirth class together. Being informed helps both partners feel prepared.'},
    {'emoji': '🌙', 'title': 'Night Support', 'tip': 'Help her get comfortable at night. Support her with extra pillows, and be patient with frequent bathroom trips.'},
    {'emoji': '🛍️', 'title': 'Prepare Together', 'tip': 'Set up the nursery together, shop for baby items, and discuss parenting approaches as a team.'},
    {'emoji': '💬', 'title': 'Talk to Baby', 'tip': 'Sing, read, or talk to the baby through her belly. Babies recognize voices! This helps you bond before birth.'},
    {'emoji': '❤️', 'title': 'Express Your Love', 'tip': 'Tell her she\'s beautiful and incredible. Pregnancy can be hard — remind her how amazing and strong she is.'},
    {'emoji': '🧘', 'title': 'Support Self-Care', 'tip': 'Encourage her yoga, rest, and relaxation. Protect her time for self-care without guilt.'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      itemCount: _tips.length,
      itemBuilder: (_, i) {
        final t = _tips[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: NitaraCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t['emoji']!, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t['title']!,
                          style: GoogleFonts.nunito(
                              fontSize: 15, fontWeight: FontWeight.w700, color: NitaraColors.textDark)),
                      const SizedBox(height: 6),
                      Text(t['tip']!,
                          style: GoogleFonts.nunito(
                              fontSize: 13, color: NitaraColors.textMedium, height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
          ).animate(delay: Duration(milliseconds: i * 50)).fadeIn(duration: 400.ms),
        );
      },
    );
  }
}
