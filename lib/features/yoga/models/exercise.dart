import 'package:flutter/material.dart';

enum YogaCategory { breathing, stretching, pelvicFloor, prenatalYoga }
enum Trimester { first, second, third, all }

class Exercise {
  final String name;
  final String description;
  final String emoji;
  final YogaCategory category;
  final List<Trimester> trimesters;
  final String duration;
  final String difficulty;
  final List<String> steps;
  final String benefits;

  const Exercise({
    required this.name,
    required this.description,
    required this.emoji,
    required this.category,
    required this.trimesters,
    required this.duration,
    required this.difficulty,
    required this.steps,
    required this.benefits,
  });
}

final List<Exercise> allExercises = [
  // ─── Breathing ───────────────────────────────────────────────────────────
  Exercise(
    name: 'Deep Belly Breathing',
    description: 'Diaphragmatic breathing to reduce stress and improve oxygen flow to baby.',
    emoji: '🌬️',
    category: YogaCategory.breathing,
    trimesters: [Trimester.first, Trimester.second, Trimester.third],
    duration: '5-10 min',
    difficulty: 'Easy',
    steps: [
      'Sit comfortably or lie on your left side',
      'Place one hand on chest, one on belly',
      'Inhale slowly through your nose for 4 counts',
      'Feel your belly rise, not your chest',
      'Exhale through your mouth for 6 counts',
      'Repeat 10-15 times',
    ],
    benefits: 'Reduces anxiety, lowers blood pressure, improves oxygen for baby',
  ),
  Exercise(
    name: '4-7-8 Breathing',
    description: 'A calming technique for sleep and anxiety relief during pregnancy.',
    emoji: '😮‍💨',
    category: YogaCategory.breathing,
    trimesters: [Trimester.first, Trimester.second, Trimester.third],
    duration: '3-5 min',
    difficulty: 'Easy',
    steps: [
      'Sit comfortably with back straight',
      'Exhale completely through your mouth',
      'Close mouth and inhale for 4 counts',
      'Hold breath for 7 counts',
      'Exhale completely for 8 counts',
      'Repeat 4 times maximum',
    ],
    benefits: 'Excellent for sleep, reduces anxiety and stress hormones',
  ),
  Exercise(
    name: 'Lamaze Breathing',
    description: 'The classic labor breathing technique to manage contractions naturally.',
    emoji: '💨',
    category: YogaCategory.breathing,
    trimesters: [Trimester.third],
    duration: '10-15 min',
    difficulty: 'Medium',
    steps: [
      'Start with a cleansing breath (deep inhale, slow exhale)',
      'Light breathing: hee-hee-hoo pattern',
      'Breathe in through nose, out through mouth',
      'Keep rhythm steady and focused',
      'Practice with a contraction timer',
      'End each set with a cleansing breath',
    ],
    benefits: 'Prepares for natural labor, reduces pain perception during contractions',
  ),

  // ─── Stretching ──────────────────────────────────────────────────────────
  Exercise(
    name: 'Cat-Cow Stretch',
    description: 'Gentle spine mobilization to relieve back pain common in pregnancy.',
    emoji: '🐱',
    category: YogaCategory.stretching,
    trimesters: [Trimester.first, Trimester.second, Trimester.third],
    duration: '5-8 min',
    difficulty: 'Easy',
    steps: [
      'Start on hands and knees, wrists under shoulders',
      'Inhale: drop belly down, lift head and tailbone (Cow)',
      'Exhale: round spine to ceiling, tuck chin (Cat)',
      'Move slowly and with breath',
      'Repeat 10-15 times',
      'Rest in Child\'s Pose when done',
    ],
    benefits: 'Relieves back pain, improves spinal flexibility, calms the nervous system',
  ),
  Exercise(
    name: 'Seated Side Stretch',
    description: 'Opens the rib cage and relieves shortness of breath as baby grows.',
    emoji: '🧘',
    category: YogaCategory.stretching,
    trimesters: [Trimester.second, Trimester.third],
    duration: '5 min',
    difficulty: 'Easy',
    steps: [
      'Sit cross-legged or on a chair',
      'Place right hand on floor, left arm overhead',
      'Lean gently to the right, opening left side',
      'Breathe into the stretch for 5 breaths',
      'Slowly return to center',
      'Repeat on the other side',
    ],
    benefits: 'Relieves rib pain, creates space for breathing, stretches sides',
  ),
  Exercise(
    name: 'Hip Flexor Stretch',
    description: 'Releases tight hip flexors and prepares the pelvis for birth.',
    emoji: '🦵',
    category: YogaCategory.stretching,
    trimesters: [Trimester.second, Trimester.third],
    duration: '8 min',
    difficulty: 'Medium',
    steps: [
      'Kneel on soft mat with one knee down',
      'Place other foot forward in a lunge position',
      'Keep back straight and core gently engaged',
      'Shift weight forward gently until you feel a stretch',
      'Hold for 30 seconds, breathing normally',
      'Switch sides and repeat 3 times each',
    ],
    benefits: 'Opens hips, relieves pelvic pressure, prepares for labor positioning',
  ),
  Exercise(
    name: 'Butterfly Pose',
    description: 'Gentle inner thigh and hip opener ideal throughout pregnancy.',
    emoji: '🦋',
    category: YogaCategory.stretching,
    trimesters: [Trimester.first, Trimester.second, Trimester.third],
    duration: '5-10 min',
    difficulty: 'Easy',
    steps: [
      'Sit on a folded blanket for support',
      'Bring soles of feet together, knees out to sides',
      'Hold ankles gently',
      'Sit tall and breathe deeply',
      'Gently flutter knees up and down (optional)',
      'Hold for 1-3 minutes',
    ],
    benefits: 'Opens hips, improves circulation, reduces leg cramps',
  ),

  // ─── Pelvic Floor ────────────────────────────────────────────────────────
  Exercise(
    name: 'Kegel Exercises',
    description: 'The essential exercise for pelvic floor strength during and after pregnancy.',
    emoji: '💪',
    category: YogaCategory.pelvicFloor,
    trimesters: [Trimester.first, Trimester.second, Trimester.third],
    duration: '5-10 min',
    difficulty: 'Easy',
    steps: [
      'Identify pelvic floor muscles (as if stopping urine flow)',
      'Tighten those muscles and hold for 5 seconds',
      'Relax completely for 5 seconds',
      'Repeat 10 times per set',
      'Do 3 sets per day',
      'Breathe normally throughout — don\'t hold breath',
    ],
    benefits: 'Prevents incontinence, supports baby weight, speeds postpartum recovery',
  ),
  Exercise(
    name: 'Pelvic Tilts',
    description: 'Strengthens core and pelvic floor while relieving lower back pain.',
    emoji: '🔄',
    category: YogaCategory.pelvicFloor,
    trimesters: [Trimester.first, Trimester.second],
    duration: '8 min',
    difficulty: 'Easy',
    steps: [
      'Lie on back with knees bent, feet flat (1st trimester only)',
      'Or stand with back against wall',
      'Flatten lower back by engaging abs gently',
      'Tilt pelvis slightly forward and hold 5 seconds',
      'Release and return to neutral',
      'Repeat 10-15 times',
    ],
    benefits: 'Strengthens core safely, reduces back pain, prepares for delivery',
  ),
  Exercise(
    name: 'Squats (Pregnancy Modified)',
    description: 'Modified squats to strengthen the entire lower body and open the pelvis.',
    emoji: '🏋️',
    category: YogaCategory.pelvicFloor,
    trimesters: [Trimester.second, Trimester.third],
    duration: '10 min',
    difficulty: 'Medium',
    steps: [
      'Stand with feet shoulder-width apart, toes out',
      'Hold a chair or wall for balance if needed',
      'Slowly lower into squat position',
      'Keep chest up and weight in heels',
      'Hold for 10-30 seconds',
      'Rise slowly, repeat 10 times',
    ],
    benefits: 'Opens pelvis, strengthens legs, helps baby descend for birth',
  ),

  // ─── Prenatal Yoga ───────────────────────────────────────────────────────
  Exercise(
    name: 'Child\'s Pose',
    description: 'Restorative pose for rest and stress relief throughout all trimesters.',
    emoji: '🌙',
    category: YogaCategory.prenatalYoga,
    trimesters: [Trimester.first, Trimester.second, Trimester.third],
    duration: '3-5 min',
    difficulty: 'Easy',
    steps: [
      'Kneel with knees wide apart to accommodate belly',
      'Sink hips back towards heels',
      'Walk hands forward on mat',
      'Rest forehead on mat or a pillow',
      'Breathe deeply and relax',
      'Hold for 1-5 minutes',
    ],
    benefits: 'Deep relaxation, relieves back tension, calms nervous system',
  ),
  Exercise(
    name: 'Warrior II (Modified)',
    description: 'A grounding standing pose that builds strength and confidence.',
    emoji: '⚔️',
    category: YogaCategory.prenatalYoga,
    trimesters: [Trimester.first, Trimester.second],
    duration: '8-10 min',
    difficulty: 'Medium',
    steps: [
      'Step feet 3-4 feet apart on mat',
      'Turn right foot out 90°, left foot in slightly',
      'Bend right knee over ankle',
      'Extend arms parallel to floor',
      'Gaze over right hand',
      'Hold 30 seconds, switch sides',
    ],
    benefits: 'Builds leg strength, improves stamina, boosts confidence',
  ),
];
