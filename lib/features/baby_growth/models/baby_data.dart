class BabyWeekData {
  final int week;
  final String fruitName;
  final String fruitEmoji;
  final double weightGrams;
  final double lengthCm;
  final String description;
  final List<String> milestones;
  final String heartbeat;

  const BabyWeekData({
    required this.week,
    required this.fruitName,
    required this.fruitEmoji,
    required this.weightGrams,
    required this.lengthCm,
    required this.description,
    required this.milestones,
    this.heartbeat = '140-160 bpm',
  });

  String get weightFormatted => weightGrams < 1000
      ? '${weightGrams.toStringAsFixed(0)}g'
      : '${(weightGrams / 1000).toStringAsFixed(2)}kg';

  String get lengthFormatted => '${lengthCm.toStringAsFixed(1)}cm';
}

final List<BabyWeekData> allWeeksData = [
  BabyWeekData(
    week: 1, fruitName: 'Poppy seed', fruitEmoji: '🌱',
    weightGrams: 0, lengthCm: 0.1,
    description: 'Conception occurs. The fertilized egg begins its incredible journey.',
    milestones: ['Fertilization', 'Cell division begins'],
  ),
  BabyWeekData(
    week: 2, fruitName: 'Sesame seed', fruitEmoji: '🌱',
    weightGrams: 0, lengthCm: 0.2,
    description: 'The embryo implants in the uterine wall. Hormonal changes begin.',
    milestones: ['Implantation', 'HCG hormone production'],
  ),
  BabyWeekData(
    week: 3, fruitName: 'Poppy seed', fruitEmoji: '🌿',
    weightGrams: 0, lengthCm: 0.3,
    description: 'Your baby is a tiny ball of cells called a blastocyst. The placenta begins forming.',
    milestones: ['Placenta starts forming', 'Cells differentiating'],
  ),
  BabyWeekData(
    week: 4, fruitName: 'Poppy seed', fruitEmoji: '🫘',
    weightGrams: 0.1, lengthCm: 0.4,
    description: 'The embryo is now implanted. Four distinct layers of cells are forming.',
    milestones: ['Heart tube forms', 'Brain & spinal cord start developing', 'Eyes & ears forming'],
  ),
  BabyWeekData(
    week: 5, fruitName: 'Sesame seed', fruitEmoji: '🫘',
    weightGrams: 0.5, lengthCm: 0.5,
    description: 'Your baby\'s heart begins to beat! Tiny arm and leg buds are forming.',
    milestones: ['Heart starts beating', 'Arm & leg buds appear', 'Neural tube closes'],
  ),
  BabyWeekData(
    week: 6, fruitName: 'Pea', fruitEmoji: '🫛',
    weightGrams: 1, lengthCm: 0.6,
    description: 'The face is taking shape with tiny nostrils, eyes, and ears beginning to form.',
    milestones: ['Facial features forming', 'Fingers beginning to form', 'Kidneys developing'],
  ),
  BabyWeekData(
    week: 7, fruitName: 'Blueberry', fruitEmoji: '🫐',
    weightGrams: 1.5, lengthCm: 1.0,
    description: 'Baby has doubled in size! The brain is growing rapidly — 100 neurons per minute.',
    milestones: ['Brain grows rapidly', 'Eyelids forming', 'Teeth buds appearing'],
  ),
  BabyWeekData(
    week: 8, fruitName: 'Raspberry', fruitEmoji: '🫐',
    weightGrams: 3, lengthCm: 1.6,
    description: 'Baby looks more like a tiny human! All major organs are beginning to form.',
    milestones: ['All major organs forming', 'Fingers & toes visible', 'Tail disappears'],
  ),
  BabyWeekData(
    week: 9, fruitName: 'Grape', fruitEmoji: '🍇',
    weightGrams: 7, lengthCm: 2.3,
    description: 'Your baby is now officially a fetus! Tiny movements begin.',
    milestones: ['Officially a fetus', 'Heart has 4 chambers', 'Baby can move'],
  ),
  BabyWeekData(
    week: 10, fruitName: 'Kumquat', fruitEmoji: '🍊',
    weightGrams: 14, lengthCm: 3.1,
    description: 'Baby\'s vital organs are fully formed and beginning to function!',
    milestones: ['Organs fully formed', 'Fingernails developing', 'Swallowing begins'],
  ),
  BabyWeekData(
    week: 11, fruitName: 'Fig', fruitEmoji: '🍈',
    weightGrams: 28, lengthCm: 4.1,
    description: 'Baby can now open and close fists. Hair follicles are forming.',
    milestones: ['Fists opening & closing', 'Hair follicles forming', 'Taste buds developing'],
  ),
  BabyWeekData(
    week: 12, fruitName: 'Lime', fruitEmoji: '🍋',
    weightGrams: 43, lengthCm: 5.4,
    description: 'End of first trimester! Baby can kick, open fingers, curl toes, and feel touch.',
    milestones: ['Reflexes developing', 'Sex organs forming', 'Bone hardening begins'],
  ),
  BabyWeekData(
    week: 13, fruitName: 'Lemon', fruitEmoji: '🍋',
    weightGrams: 73, lengthCm: 7.4,
    description: 'Welcome to the second trimester! Baby can now make facial expressions.',
    milestones: ['Facial expressions', 'Vocal cords forming', 'Intestines move into abdomen'],
  ),
  BabyWeekData(
    week: 14, fruitName: 'Orange', fruitEmoji: '🍊',
    weightGrams: 110, lengthCm: 8.7,
    description: 'Baby\'s neck is lengthening and the chin lifts off the chest.',
    milestones: ['Squinting & frowning', 'Sucking muscles developing', 'Lanugo hair forming'],
  ),
  BabyWeekData(
    week: 15, fruitName: 'Apple', fruitEmoji: '🍎',
    weightGrams: 140, lengthCm: 10.1,
    description: 'Baby is moving more! You may start feeling flutters called quickening.',
    milestones: ['Hiccupping', 'Responding to light', 'Joints moving freely'],
  ),
  BabyWeekData(
    week: 16, fruitName: 'Avocado', fruitEmoji: '🥑',
    weightGrams: 180, lengthCm: 11.6,
    description: 'Baby can hold their head erect. The heart pumps about 25 quarts of blood daily.',
    milestones: ['Eyes moving', 'Toenails growing', 'Eyebrows forming'],
  ),
  BabyWeekData(
    week: 17, fruitName: 'Pear', fruitEmoji: '🍐',
    weightGrams: 220, lengthCm: 13,
    description: 'Baby is starting to develop fat under the skin for warmth.',
    milestones: ['Fat deposits forming', 'Sweat glands developing', 'Umbilical cord thickening'],
  ),
  BabyWeekData(
    week: 18, fruitName: 'Sweet potato', fruitEmoji: '🍠',
    weightGrams: 270, lengthCm: 14.2,
    description: 'Baby can now hear sounds from outside the womb! Start talking to your baby.',
    milestones: ['Can hear sounds', 'Hiccups audible on ultrasound', 'Unique fingerprints forming'],
  ),
  BabyWeekData(
    week: 19, fruitName: 'Mango', fruitEmoji: '🥭',
    weightGrams: 340, lengthCm: 15.3,
    description: 'Baby is developing a protective coating called vernix caseosa.',
    milestones: ['Vernix caseosa forming', 'Sensory development', 'Legs in proportion now'],
  ),
  BabyWeekData(
    week: 20, fruitName: 'Banana', fruitEmoji: '🍌',
    weightGrams: 400, lengthCm: 25.6,
    description: 'Halfway there! 🎉 Baby is now measured from head to toe.',
    milestones: ['Halfway milestone!', 'Sleep cycles forming', 'Swallowing amniotic fluid'],
  ),
  BabyWeekData(
    week: 21, fruitName: 'Carrot', fruitEmoji: '🥕',
    weightGrams: 450, lengthCm: 26.7,
    description: 'Baby\'s movements are stronger. You should be feeling kicks regularly.',
    milestones: ['Strong kicks felt', 'Taste buds working', 'Bone marrow producing blood cells'],
  ),
  BabyWeekData(
    week: 22, fruitName: 'Papaya', fruitEmoji: '🍈',
    weightGrams: 550, lengthCm: 27.8,
    description: 'Baby looks like a miniature newborn. Eyebrows and lips are distinct.',
    milestones: ['Looks like newborn', 'Eyes fully formed', 'Brain developing rapidly'],
  ),
  BabyWeekData(
    week: 23, fruitName: 'Grapefruit', fruitEmoji: '🍊',
    weightGrams: 680, lengthCm: 28.9,
    description: 'Baby can sense movement — they feel when you dance or exercise!',
    milestones: ['Senses movement', 'Hearing fully developed', 'Lungs developing'],
  ),
  BabyWeekData(
    week: 24, fruitName: 'Corn', fruitEmoji: '🌽',
    weightGrams: 820, lengthCm: 30,
    description: 'Viability milestone! Baby\'s lungs are producing surfactant.',
    milestones: ['Viability milestone!', 'Surfactant production', 'Responds to sound & touch'],
  ),
  BabyWeekData(
    week: 25, fruitName: 'Cauliflower', fruitEmoji: '🥦',
    weightGrams: 950, lengthCm: 34.6,
    description: 'Baby has a good chance of survival if born now. Spine is stronger.',
    milestones: ['Startle reflex developing', 'Nostrils opening', 'Wrinkled skin smoothing'],
  ),
  BabyWeekData(
    week: 26, fruitName: 'Lettuce', fruitEmoji: '🥬',
    weightGrams: 1100, lengthCm: 35.6,
    description: 'Baby\'s eyes open for the first time! They can see light through the womb.',
    milestones: ['Eyes opening!', 'Brain developing fast', 'Immune system strengthening'],
  ),
  BabyWeekData(
    week: 27, fruitName: 'Eggplant', fruitEmoji: '🍆',
    weightGrams: 1300, lengthCm: 36.6,
    description: 'Third trimester begins! Baby sleeps and wakes on a regular schedule.',
    milestones: ['Third trimester!', 'Regular sleep cycles', 'Recognizes your voice'],
  ),
  BabyWeekData(
    week: 28, fruitName: 'Eggplant', fruitEmoji: '🍆',
    weightGrams: 1500, lengthCm: 37.6,
    description: 'Baby can blink! The brain and nervous system are rapidly maturing.',
    milestones: ['Can blink!', 'REM sleep', 'Dreaming may begin'],
  ),
  BabyWeekData(
    week: 29, fruitName: 'Butternut squash', fruitEmoji: '🎃',
    weightGrams: 1700, lengthCm: 38.6,
    description: 'Baby\'s muscles and lungs are maturing. Moving a lot and very active!',
    milestones: ['Very active', 'Bones fully developed', 'Gaining weight rapidly'],
  ),
  BabyWeekData(
    week: 30, fruitName: 'Cabbage', fruitEmoji: '🥬',
    weightGrams: 1900, lengthCm: 39.9,
    description: 'Baby\'s brain is developing billions of neurons. Vision is improving.',
    milestones: ['Brain developing fast', 'Immune system building', 'Eyes focusing'],
  ),
  BabyWeekData(
    week: 31, fruitName: 'Coconut', fruitEmoji: '🥥',
    weightGrams: 2200, lengthCm: 41.1,
    description: 'Baby is putting on fat rapidly. All five senses are now functioning.',
    milestones: ['All 5 senses working', 'Rapid weight gain', 'Turning head-down'],
  ),
  BabyWeekData(
    week: 32, fruitName: 'Jicama', fruitEmoji: '🫙',
    weightGrams: 2400, lengthCm: 42.4,
    description: 'Baby practices breathing movements with amniotic fluid.',
    milestones: ['Practicing breathing', 'Toenails complete', 'Soft skull bones'],
  ),
  BabyWeekData(
    week: 33, fruitName: 'Pineapple', fruitEmoji: '🍍',
    weightGrams: 2600, lengthCm: 43.7,
    description: 'Baby\'s bones are hardening except for the skull, which stays soft for birth.',
    milestones: ['Bones hardening', 'Skull stays flexible', 'Immune system boosting'],
  ),
  BabyWeekData(
    week: 34, fruitName: 'Cantaloupe', fruitEmoji: '🍈',
    weightGrams: 2800, lengthCm: 45,
    description: 'Baby\'s fingernails have reached fingertips. Almost fully developed!',
    milestones: ['Fingernails complete', 'Lungs nearly mature', 'Fat filling in cheeks'],
  ),
  BabyWeekData(
    week: 35, fruitName: 'Honeydew', fruitEmoji: '🍈',
    weightGrams: 3100, lengthCm: 46.2,
    description: 'Baby is running out of room! Movements feel stronger but less frequent.',
    milestones: ['Brain & lungs almost ready', 'Less room to move', 'Head may engage'],
  ),
  BabyWeekData(
    week: 36, fruitName: 'Romaine lettuce', fruitEmoji: '🥬',
    weightGrams: 3400, lengthCm: 47.4,
    description: 'Baby is considered early term. Most babies turn head-down now.',
    milestones: ['Early term!', 'Shedding lanugo', 'Swallowing more amniotic fluid'],
  ),
  BabyWeekData(
    week: 37, fruitName: 'Winter melon', fruitEmoji: '🍈',
    weightGrams: 3500, lengthCm: 48.6,
    description: 'Full term! Baby is fully developed and ready for birth anytime.',
    milestones: ['Full term! 🎉', 'Firm grasp reflex', 'Rooting reflex ready'],
  ),
  BabyWeekData(
    week: 38, fruitName: 'Pumpkin', fruitEmoji: '🎃',
    weightGrams: 3700, lengthCm: 49.8,
    description: 'Baby\'s organs are fully mature. The final weeks of preparation!',
    milestones: ['Fully mature', 'Vernix almost gone', 'Ready for the world!'],
  ),
  BabyWeekData(
    week: 39, fruitName: 'Watermelon', fruitEmoji: '🍉',
    weightGrams: 3800, lengthCm: 50.7,
    description: 'Baby continues to put on weight. Could arrive any day!',
    milestones: ['Could arrive anytime!', 'Brain still growing', 'Strong & healthy'],
  ),
  BabyWeekData(
    week: 40, fruitName: 'Watermelon', fruitEmoji: '🍉',
    weightGrams: 3900, lengthCm: 51.2,
    description: 'Due date week! Your baby is fully ready. Every day now is beautiful anticipation!',
    milestones: ['Due date! 🎉🌸', 'Full term', 'Ready to meet you!'],
    heartbeat: '120-160 bpm',
  ),
];
