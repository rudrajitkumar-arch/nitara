import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/colors.dart';
import '../../../shared/widgets/nitara_card.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                    'Nutrition Guide',
                    style: GoogleFonts.nunito(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : NitaraColors.textDark,
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                  Text(
                    'Eat well for you and your baby',
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
                  color: isDark ? NitaraColors.surfaceDark : NitaraColors.pinkPastel,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: NitaraColors.textMedium,
                  indicator: BoxDecoration(
                    gradient: NitaraColors.nutritionGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelStyle: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700),
                  tabs: const [Tab(text: 'Safe'), Tab(text: 'Avoid'), Tab(text: 'Recipes')],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [_SafeFoodsTab(), _AvoidFoodsTab(), _RecipesTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SafeFoodsTab extends StatelessWidget {
  const _SafeFoodsTab();

  static const List<Map<String, dynamic>> _foods = [
    {'emoji': '🥬', 'name': 'Dark Leafy Greens', 'benefit': 'Folate, iron, calcium', 'color': 0xFF66BB6A},
    {'emoji': '🫐', 'name': 'Berries', 'benefit': 'Antioxidants, vitamin C', 'color': 0xFF7E57C2},
    {'emoji': '🐟', 'name': 'Salmon', 'benefit': 'Omega-3, DHA for brain', 'color': 0xFF42A5F5},
    {'emoji': '🥚', 'name': 'Eggs', 'benefit': 'Protein, choline, DHA', 'color': 0xFFFFCA28},
    {'emoji': '🫘', 'name': 'Lentils & Legumes', 'benefit': 'Iron, folate, protein', 'color': 0xFFFF7043},
    {'emoji': '🥑', 'name': 'Avocado', 'benefit': 'Healthy fats, folate, K2', 'color': 0xFF26A69A},
    {'emoji': '🥕', 'name': 'Carrots', 'benefit': 'Beta-carotene, vitamin A', 'color': 0xFFFF7043},
    {'emoji': '🍊', 'name': 'Citrus Fruits', 'benefit': 'Vitamin C, folate', 'color': 0xFFFF9800},
    {'emoji': '🥜', 'name': 'Nuts & Seeds', 'benefit': 'Healthy fats, magnesium', 'color': 0xFF8D6E63},
    {'emoji': '🧀', 'name': 'Dairy (Pasteurized)', 'benefit': 'Calcium, protein, B12', 'color': 0xFFFFCC02},
    {'emoji': '🍠', 'name': 'Sweet Potato', 'benefit': 'Vitamin A, fiber, potassium', 'color': 0xFFFF5722},
    {'emoji': '🌾', 'name': 'Whole Grains', 'benefit': 'Fiber, B vitamins, iron', 'color': 0xFF8BC34A},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: _foods.length,
      itemBuilder: (_, i) {
        final food = _foods[i];
        final color = Color(food['color'] as int);
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: NitaraCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(child: Text(food['emoji'], style: const TextStyle(fontSize: 24))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(food['name'],
                          style: GoogleFonts.nunito(
                              fontSize: 15, fontWeight: FontWeight.w700, color: NitaraColors.textDark)),
                      const SizedBox(height: 2),
                      Text(food['benefit'],
                          style: GoogleFonts.nunito(
                              fontSize: 12, color: NitaraColors.textLight, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('✓ Safe',
                      style: GoogleFonts.nunito(
                          fontSize: 11, fontWeight: FontWeight.w700, color: color)),
                ),
              ],
            ),
          ).animate(delay: Duration(milliseconds: i * 50)).fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),
        );
      },
    );
  }
}

class _AvoidFoodsTab extends StatelessWidget {
  const _AvoidFoodsTab();

  static const List<Map<String, String>> _avoidFoods = [
    {'emoji': '🐟', 'name': 'High-Mercury Fish', 'reason': 'Swordfish, king mackerel — harm nervous system', 'level': 'Avoid'},
    {'emoji': '🥩', 'name': 'Raw/Undercooked Meat', 'reason': 'Risk of toxoplasmosis & salmonella', 'level': 'Avoid'},
    {'emoji': '🍣', 'name': 'Raw Sushi & Shellfish', 'reason': 'Risk of listeria and harmful bacteria', 'level': 'Avoid'},
    {'emoji': '🧀', 'name': 'Unpasteurized Cheese', 'reason': 'Soft cheeses like brie — listeria risk', 'level': 'Avoid'},
    {'emoji': '☕', 'name': 'Excess Caffeine', 'reason': 'Limit to < 200mg/day. Can cross placenta', 'level': 'Limit'},
    {'emoji': '🍷', 'name': 'Alcohol', 'reason': 'No safe amount — fetal alcohol syndrome risk', 'level': 'Avoid'},
    {'emoji': '🌿', 'name': 'Unwashed Produce', 'reason': 'Toxoplasmosis risk from soil bacteria', 'level': 'Wash Well'},
    {'emoji': '🥜', 'name': 'Excessive Vitamin A', 'reason': 'High-dose supplements can cause birth defects', 'level': 'Limit'},
    {'emoji': '🌶️', 'name': 'Very Spicy Foods', 'reason': 'Can worsen heartburn and acid reflux', 'level': 'Limit'},
    {'emoji': '🥤', 'name': 'Unpasteurized Juice', 'reason': 'Risk of E.coli and other bacteria', 'level': 'Avoid'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: _avoidFoods.length,
      itemBuilder: (_, i) {
        final food = _avoidFoods[i];
        final isAvoid = food['level'] == 'Avoid';
        final color = isAvoid ? Colors.redAccent : Colors.orange;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: NitaraCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(child: Text(food['emoji']!, style: const TextStyle(fontSize: 24))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(food['name']!,
                          style: GoogleFonts.nunito(
                              fontSize: 15, fontWeight: FontWeight.w700, color: NitaraColors.textDark)),
                      const SizedBox(height: 2),
                      Text(food['reason']!,
                          style: GoogleFonts.nunito(
                              fontSize: 12, color: NitaraColors.textLight, height: 1.4)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(food['level']!,
                      style: GoogleFonts.nunito(
                          fontSize: 10, fontWeight: FontWeight.w700, color: color)),
                ),
              ],
            ),
          ).animate(delay: Duration(milliseconds: i * 50)).fadeIn(duration: 300.ms),
        );
      },
    );
  }
}

class _RecipesTab extends StatelessWidget {
  const _RecipesTab();

  static const List<Map<String, dynamic>> _recipes = [
    {
      'emoji': '🥣',
      'name': 'Iron-Rich Spinach Smoothie',
      'time': '5 min',
      'trimester': '1st & 2nd',
      'ingredients': ['2 cups fresh spinach', '1 banana', '1 cup orange juice', '1 tbsp chia seeds', 'Ice cubes'],
      'steps': ['Add all ingredients to blender', 'Blend until smooth', 'Serve immediately for maximum nutrition'],
      'color': 0xFF66BB6A,
    },
    {
      'emoji': '🍲',
      'name': 'Lentil Vegetable Soup',
      'time': '30 min',
      'trimester': 'All Trimesters',
      'ingredients': ['1 cup red lentils', '2 carrots diced', '1 onion', '3 cloves garlic', 'Vegetable broth', 'Cumin & turmeric'],
      'steps': ['Sauté onion and garlic', 'Add vegetables and lentils', 'Pour broth and simmer 20 mins', 'Season and serve'],
      'color': 0xFFFF7043,
    },
    {
      'emoji': '🥗',
      'name': 'Avocado Egg Salad',
      'time': '15 min',
      'trimester': '2nd & 3rd',
      'ingredients': ['2 hard-boiled eggs', '1 ripe avocado', 'Lemon juice', 'Salt & pepper', 'Whole grain toast'],
      'steps': ['Mash avocado with lemon', 'Chop eggs and mix', 'Season well', 'Serve on toast'],
      'color': 0xFF26A69A,
    },
    {
      'emoji': '🍱',
      'name': 'Salmon & Quinoa Bowl',
      'time': '25 min',
      'trimester': '2nd & 3rd',
      'ingredients': ['150g cooked salmon', '½ cup quinoa', 'Steamed broccoli', 'Lemon & olive oil', 'Fresh herbs'],
      'steps': ['Cook quinoa per package', 'Pan-sear salmon 3-4 mins each side', 'Steam broccoli', 'Assemble bowl and drizzle with lemon oil'],
      'color': 0xFF42A5F5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: _recipes.length,
      itemBuilder: (_, i) {
        final r = _recipes[i];
        final color = Color(r['color'] as int);
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: GestureDetector(
            onTap: () => _showRecipe(context, r),
            child: NitaraCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(child: Text(r['emoji'], style: const TextStyle(fontSize: 28))),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r['name'],
                                style: GoogleFonts.nunito(
                                    fontSize: 15, fontWeight: FontWeight.w700, color: NitaraColors.textDark)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                _Chip('⏱ ${r["time"]}', color),
                                const SizedBox(width: 6),
                                _Chip(r['trimester'], NitaraColors.lavender),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: NitaraColors.textLight),
                    ],
                  ),
                ],
              ),
            ),
          ).animate(delay: Duration(milliseconds: i * 80)).fadeIn(duration: 400.ms),
        );
      },
    );
  }

  Widget _Chip(String label, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label,
            style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.w700, color: color)),
      );

  void _showRecipe(BuildContext context, Map r) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RecipeSheet(recipe: r),
    );
  }
}

class _RecipeSheet extends StatelessWidget {
  final Map recipe;
  const _RecipeSheet({required this.recipe});

  @override
  Widget build(BuildContext context) {
    final color = Color(recipe['color'] as int);
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text(recipe['emoji'], style: const TextStyle(fontSize: 48))),
            const SizedBox(height: 12),
            Text(recipe['name'],
                style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.w800, color: NitaraColors.textDark)),
            const SizedBox(height: 16),
            Text('Ingredients', style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 8),
            for (final i in recipe['ingredients'] as List)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(children: [
                  Icon(Icons.fiber_manual_record, size: 8, color: color),
                  const SizedBox(width: 8),
                  Text(i, style: GoogleFonts.nunito(fontSize: 14, color: NitaraColors.textMedium)),
                ]),
              ),
            const SizedBox(height: 16),
            Text('Instructions', style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 8),
            for (var i = 0; i < (recipe['steps'] as List).length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    width: 22, height: 22,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.15)),
                    child: Center(child: Text('${i+1}', style: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w700, color: color))),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text((recipe['steps'] as List)[i],
                      style: GoogleFonts.nunito(fontSize: 14, color: NitaraColors.textMedium, height: 1.4))),
                ]),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
