import 'dart:typed_data';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const CvdAiApp());
}

class CvdAiApp extends StatelessWidget {
  const CvdAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CVD.AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF007C89)),
        scaffoldBackgroundColor: const Color(0xFFF7FAFC),
      ),
      builder: (context, child) {
        return MobileAppFrame(child: child ?? const SizedBox.shrink());
      },
      home: const HomeScreen(),
    );
  }
}

class MobileAppFrame extends StatelessWidget {
  final Widget child;

  const MobileAppFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 520) {
          return child;
        }

        final frameHeight = math.min(constraints.maxHeight - 32, 900.0);

        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8F4F5), Color(0xFFF7FAFC)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Container(
              width: 430,
              height: frameHeight,
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAFC),
                borderRadius: BorderRadius.circular(34),
                border: Border.all(color: Colors.white, width: 7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 34,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(27),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ================= HOME SCREEN =================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void goToUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UserWelcomeScreen()),
    );
  }

  void goToAdmin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF7FCFD), Color(0xFFE9F7F8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.all(26),
                    child: Column(
                      children: [
                        SizedBox(height: constraints.maxHeight < 650 ? 18 : 56),
                        Container(
                          width: 142,
                          height: 142,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF5A52), Color(0xFFE53935)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFFE53935,
                                ).withValues(alpha: 0.30),
                                blurRadius: 34,
                                offset: const Offset(0, 18),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.favorite_rounded,
                            size: 76,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'CVD.AI',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0,
                            color: Color(0xFF172126),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'AI-powered ECG risk monitoring',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.35,
                            color: Color(0xFF6B7378),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: const [
                            HomePill(
                              icon: Icons.monitor_heart,
                              label: 'Live ECG',
                            ),
                            HomePill(
                              icon: Icons.bolt_rounded,
                              label: 'AI Score',
                            ),
                            HomePill(
                              icon: Icons.picture_as_pdf,
                              label: 'PDF Report',
                            ),
                          ],
                        ),
                        const SizedBox(height: 42),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF007C89),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () => goToUser(context),
                            icon: const Icon(Icons.person_rounded),
                            label: const Text(
                              'Continue as User',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF007C89),
                              side: const BorderSide(
                                color: Color(0xFF007C89),
                                width: 1.2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () => goToAdmin(context),
                            icon: const Icon(
                              Icons.admin_panel_settings_rounded,
                            ),
                            label: const Text(
                              'Continue as Admin',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight < 650 ? 24 : 58),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.70),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: const Color(0xFFDDECEF)),
                          ),
                          child: const Text(
                            'by PulseGuard AI',
                            style: TextStyle(
                              color: Color(0xFF7A858A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HomePill extends StatelessWidget {
  final IconData icon;
  final String label;

  const HomePill({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFDDECEF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF007C89)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xFF334047),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= USER WELCOME SCREEN =================

class UserWelcomeScreen extends StatelessWidget {
  const UserWelcomeScreen({super.key});

  void goToProfileForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UserProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        title: const Text('User Assessment'),
        backgroundColor: const Color(0xFFF7FAFC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: ListView(
          children: [
            const Text(
              'Your heart monitoring journey',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'CVD.AI combines smartwatch ECG analysis with medical risk factors to generate an early risk alert.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            const InfoCard(
              number: '1',
              title: 'Enter Profile',
              subtitle: 'Name, age, gender, phone, and emergency contact.',
            ),
            const InfoCard(
              number: '2',
              title: 'Add Medical Factors',
              subtitle:
                  'Smoking, diabetes, blood pressure, family history, and more.',
            ),
            const InfoCard(
              number: '3',
              title: 'Select Symptoms',
              subtitle:
                  'Chest pain, dizziness, shortness of breath, and palpitations.',
            ),
            const InfoCard(
              number: '4',
              title: 'Analyze ECG',
              subtitle:
                  'The ECG has the highest impact on the final risk score.',
            ),
            const InfoCard(
              number: '5',
              title: 'View Risk Result',
              subtitle: 'See Low, Medium, or High early risk alert.',
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7F8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                'Risk formula: 70% ECG AI score + 30% medical profile score.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF007C89),
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryActionButton(
              label: 'Start Assessment',
              icon: Icons.play_arrow_rounded,
              onPressed: () => goToProfileForm(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= USER PROFILE FORM SCREEN =================

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emergencyNameController = TextEditingController();
  final TextEditingController emergencyPhoneController =
      TextEditingController();

  String? selectedGender;

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    emergencyNameController.dispose();
    emergencyPhoneController.dispose();
    super.dispose();
  }

  void submitProfile() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MedicalFactorsComingNextScreen(
            userName: nameController.text,
            age: ageController.text,
            gender: selectedGender ?? '',
            phone: phoneController.text,
            emergencyName: emergencyNameController.text,
            emergencyPhone: emergencyPhoneController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        title: const Text('Personal Information'),
        backgroundColor: const Color(0xFFF7FAFC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Step 1 of 4',
                style: TextStyle(
                  color: Color(0xFF007C89),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const LinearProgressIndicator(
                value: 0.25,
                color: Color(0xFF007C89),
                backgroundColor: Color(0xFFE2E8F0),
              ),
              const SizedBox(height: 24),
              const Text(
                'Personal Information',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'This information helps prepare emergency alerts if needed.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full name is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Age is required';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0 || age > 120) {
                    return 'Enter a valid age';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.wc),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Gender is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone number is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              const Text(
                'Emergency Contact',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: emergencyNameController,
                decoration: const InputDecoration(
                  labelText: 'Emergency Contact Name',
                  prefixIcon: Icon(Icons.contact_emergency),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Emergency contact name is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: emergencyPhoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Emergency Contact Phone',
                  prefixIcon: Icon(Icons.call),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Emergency contact phone is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              PrimaryActionButton(
                label: 'Next: Medical Factors',
                icon: Icons.arrow_forward_rounded,
                onPressed: submitProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= MEDICAL FACTORS SCREEN =================

class MedicalFactorsComingNextScreen extends StatefulWidget {
  final String userName;
  final String age;
  final String gender;
  final String phone;
  final String emergencyName;
  final String emergencyPhone;

  const MedicalFactorsComingNextScreen({
    super.key,
    required this.userName,
    required this.age,
    required this.gender,
    required this.phone,
    required this.emergencyName,
    required this.emergencyPhone,
  });

  @override
  State<MedicalFactorsComingNextScreen> createState() =>
      _MedicalFactorsComingNextScreenState();
}

class _MedicalFactorsComingNextScreenState
    extends State<MedicalFactorsComingNextScreen> {
  final Map<String, bool> selectedFactors = {
    'Family history of heart disease': false,
    'Smoking': false,
    'Diabetes': false,
    'High blood pressure': false,
    'Previous heart disease': false,
    'High cholesterol': false,
    'Obesity': false,
    'Chronic stress': false,
    'Low physical activity': false,
    'Age above 60': false,
  };

  int calculateMedicalFactorScore() {
    int score = 0;

    if (selectedFactors['Family history of heart disease'] == true) score += 8;
    if (selectedFactors['Smoking'] == true) score += 8;
    if (selectedFactors['Diabetes'] == true) score += 10;
    if (selectedFactors['High blood pressure'] == true) score += 10;
    if (selectedFactors['Previous heart disease'] == true) score += 12;
    if (selectedFactors['High cholesterol'] == true) score += 7;
    if (selectedFactors['Obesity'] == true) score += 5;
    if (selectedFactors['Chronic stress'] == true) score += 5;
    if (selectedFactors['Low physical activity'] == true) score += 5;
    if (selectedFactors['Age above 60'] == true) score += 10;

    final int userAge = int.tryParse(widget.age) ?? 0;
    if (userAge >= 60 && selectedFactors['Age above 60'] == false) {
      score += 10;
    }

    if (score > 100) return 100;
    return score;
  }

  void goToSymptomsScreen() {
    final selectedList = selectedFactors.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    final factorScore = calculateMedicalFactorScore();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SymptomsComingNextScreen(
          userName: widget.userName,
          age: widget.age,
          gender: widget.gender,
          medicalFactors: selectedList,
          medicalFactorScore: factorScore,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final score = calculateMedicalFactorScore();

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        title: const Text('Medical Risk Factors'),
        backgroundColor: const Color(0xFFF7FAFC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: ListView(
          children: [
            const Text(
              'Step 2 of 4',
              style: TextStyle(
                color: Color(0xFF007C89),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const LinearProgressIndicator(
              value: 0.50,
              color: Color(0xFF007C89),
              backgroundColor: Color(0xFFE2E8F0),
            ),
            const SizedBox(height: 24),

            Text(
              'Hi ${widget.userName}',
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),

            const SizedBox(height: 8),

            const Text(
              'Select your medical risk factors',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'These factors represent 30% of the final risk score. The ECG AI result will still have the highest importance at 70%.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7F8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(Icons.monitor_heart, color: Color(0xFF007C89)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Current medical profile score: $score / 100',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007C89),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ...selectedFactors.keys.map((factor) {
              return MedicalFactorTile(
                title: factor,
                subtitle: getFactorDescription(factor),
                selected: selectedFactors[factor]!,
                onChanged: (value) {
                  setState(() {
                    selectedFactors[factor] = value ?? false;
                  });
                },
              );
            }),

            const SizedBox(height: 24),

            PrimaryActionButton(
              label: 'Next: Symptoms',
              icon: Icons.arrow_forward_rounded,
              onPressed: goToSymptomsScreen,
            ),
          ],
        ),
      ),
    );
  }

  String getFactorDescription(String factor) {
    switch (factor) {
      case 'Family history of heart disease':
        return 'Heart disease in close family members may increase risk.';
      case 'Smoking':
        return 'Smoking is associated with higher cardiovascular risk.';
      case 'Diabetes':
        return 'Diabetes can increase risk of heart disease.';
      case 'High blood pressure':
        return 'Hypertension puts extra strain on the heart.';
      case 'Previous heart disease':
        return 'Past heart conditions are important for risk estimation.';
      case 'High cholesterol':
        return 'High cholesterol may contribute to artery blockage.';
      case 'Obesity':
        return 'Excess weight can increase cardiovascular load.';
      case 'Chronic stress':
        return 'Long-term stress may affect heart health.';
      case 'Low physical activity':
        return 'Low activity may increase cardiovascular risk.';
      case 'Age above 60':
        return 'Age is an important cardiovascular risk factor.';
      default:
        return '';
    }
  }
}

// ================= MEDICAL FACTOR TILE =================

class MedicalFactorTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final ValueChanged<bool?> onChanged;

  const MedicalFactorTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: CheckboxListTile(
        value: selected,
        onChanged: onChanged,
        activeColor: const Color(0xFF007C89),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        secondary: Icon(
          selected ? Icons.check_circle : Icons.circle_outlined,
          color: selected ? const Color(0xFF007C89) : Colors.black38,
        ),
      ),
    );
  }
}
// ================= SYMPTOMS SCREEN =================

class SymptomsComingNextScreen extends StatefulWidget {
  final String userName;
  final String age;
  final String gender;
  final List<String> medicalFactors;
  final int medicalFactorScore;

  const SymptomsComingNextScreen({
    super.key,
    required this.userName,
    required this.age,
    required this.gender,
    required this.medicalFactors,
    required this.medicalFactorScore,
  });

  @override
  State<SymptomsComingNextScreen> createState() =>
      _SymptomsComingNextScreenState();
}

class _SymptomsComingNextScreenState extends State<SymptomsComingNextScreen> {
  final Map<String, bool> selectedSymptoms = {
    'Chest pain': false,
    'Shortness of breath': false,
    'Dizziness': false,
    'Fatigue': false,
    'Nausea': false,
    'Sweating': false,
    'Palpitations': false,
    'No symptoms': false,
  };

  int calculateSymptomsScore() {
    int score = 0;

    if (selectedSymptoms['Chest pain'] == true) score += 20;
    if (selectedSymptoms['Shortness of breath'] == true) score += 15;
    if (selectedSymptoms['Palpitations'] == true) score += 12;
    if (selectedSymptoms['Sweating'] == true) score += 8;
    if (selectedSymptoms['Dizziness'] == true) score += 8;
    if (selectedSymptoms['Fatigue'] == true) score += 5;
    if (selectedSymptoms['Nausea'] == true) score += 5;

    if (score > 100) return 100;
    return score;
  }

  int calculateUserInfoScore() {
    final total = widget.medicalFactorScore + calculateSymptomsScore();
    return total > 100 ? 100 : total;
  }

  void toggleSymptom(String symptom, bool value) {
    setState(() {
      if (symptom == 'No symptoms' && value == true) {
        selectedSymptoms.updateAll((key, value) => false);
        selectedSymptoms['No symptoms'] = true;
      } else {
        selectedSymptoms['No symptoms'] = false;
        selectedSymptoms[symptom] = value;
      }
    });
  }

  void goToEcgScreen() {
    final selectedList = selectedSymptoms.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EcgComingNextScreen(
          userName: widget.userName,
          age: widget.age,
          gender: widget.gender,
          medicalFactors: widget.medicalFactors,
          symptoms: selectedList,
          medicalFactorScore: widget.medicalFactorScore,
          symptomsScore: calculateSymptomsScore(),
          userInfoScore: calculateUserInfoScore(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final symptomsScore = calculateSymptomsScore();
    final userInfoScore = calculateUserInfoScore();

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        title: const Text('Symptoms'),
        backgroundColor: const Color(0xFFF7FAFC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: ListView(
          children: [
            const Text(
              'Step 3 of 4',
              style: TextStyle(
                color: Color(0xFF007C89),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const LinearProgressIndicator(
              value: 0.75,
              color: Color(0xFF007C89),
              backgroundColor: Color(0xFFE2E8F0),
            ),
            const SizedBox(height: 24),

            const Text(
              'Current Symptoms',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Select any symptoms you are currently experiencing. These support the ECG result but do not replace medical diagnosis.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7F8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Information Score',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007C89),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Medical factors score: ${widget.medicalFactorScore} / 100',
                  ),
                  Text('Symptoms score: $symptomsScore / 100'),
                  Text(
                    'Combined profile score: $userInfoScore / 100',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This whole profile score represents only 30% of the final result. ECG will represent 70%.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ...selectedSymptoms.keys.map((symptom) {
              return SymptomTile(
                title: symptom,
                subtitle: getSymptomDescription(symptom),
                selected: selectedSymptoms[symptom]!,
                onChanged: (value) {
                  toggleSymptom(symptom, value ?? false);
                },
              );
            }),

            const SizedBox(height: 24),

            PrimaryActionButton(
              label: 'Next: ECG Analysis',
              icon: Icons.arrow_forward_rounded,
              onPressed: goToEcgScreen,
            ),
          ],
        ),
      ),
    );
  }

  String getSymptomDescription(String symptom) {
    switch (symptom) {
      case 'Chest pain':
        return 'Important symptom that may require urgent medical review.';
      case 'Shortness of breath':
        return 'Can be associated with heart or respiratory problems.';
      case 'Dizziness':
        return 'May indicate circulation or rhythm-related issues.';
      case 'Fatigue':
        return 'General symptom that can support risk estimation.';
      case 'Nausea':
        return 'Can sometimes appear with cardiovascular stress.';
      case 'Sweating':
        return 'May be important when combined with chest discomfort.';
      case 'Palpitations':
        return 'Feeling abnormal or fast heartbeats.';
      case 'No symptoms':
        return 'Select this only if you do not feel any symptoms.';
      default:
        return '';
    }
  }
}

// ================= SYMPTOM TILE =================

class SymptomTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final ValueChanged<bool?> onChanged;

  const SymptomTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isImportant =
        title == 'Chest pain' || title == 'Shortness of breath';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: CheckboxListTile(
        value: selected,
        onChanged: onChanged,
        activeColor: isImportant ? Colors.red : const Color(0xFF007C89),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isImportant && selected ? Colors.red : Colors.black,
          ),
        ),
        subtitle: Text(subtitle),
        secondary: Icon(
          selected ? Icons.check_circle : Icons.circle_outlined,
          color: selected
              ? (isImportant ? Colors.red : const Color(0xFF007C89))
              : Colors.black38,
        ),
      ),
    );
  }
}

// ================= ECG SIMULATOR =================

class EcgSimulationResult {
  final int ecgAiScore;
  final int heartRate;
  final String predictionLabel;
  final String rhythmStatus;
  final String signalQuality;
  final List<double> waveform;

  const EcgSimulationResult({
    required this.ecgAiScore,
    required this.heartRate,
    required this.predictionLabel,
    required this.rhythmStatus,
    required this.signalQuality,
    required this.waveform,
  });
}

class EcgSimulator {
  static final math.Random _random = math.Random();

  static EcgSimulationResult generate() {
    final roll = _random.nextDouble();

    if (roll < 0.45) {
      return EcgSimulationResult(
        ecgAiScore: _randomInt(12, 30),
        heartRate: _randomInt(65, 86),
        predictionLabel: 'Normal ECG',
        rhythmStatus: 'Regular',
        signalQuality: _signalQuality(),
        waveform: _buildWaveform(pattern: _EcgPattern.normal),
      );
    }

    if (roll < 0.78) {
      return EcgSimulationResult(
        ecgAiScore: _randomInt(45, 66),
        heartRate: _randomInt(88, 112),
        predictionLabel: 'Irregular ECG',
        rhythmStatus: 'Irregular',
        signalQuality: _signalQuality(),
        waveform: _buildWaveform(pattern: _EcgPattern.irregular),
      );
    }

    return EcgSimulationResult(
      ecgAiScore: _randomInt(75, 94),
      heartRate: _randomInt(108, 132),
      predictionLabel: 'High Risk ECG',
      rhythmStatus: 'Irregular',
      signalQuality: _signalQuality(),
      waveform: _buildWaveform(pattern: _EcgPattern.highRisk),
    );
  }

  static List<double> _buildWaveform({required _EcgPattern pattern}) {
    const length = 140;
    final centers = <double>[];
    double center = pattern == _EcgPattern.highRisk ? 18 : 20;

    while (center < length + 12) {
      centers.add(center);

      final baseSpacing = switch (pattern) {
        _EcgPattern.normal => _randomDouble(37, 43),
        _EcgPattern.irregular => _randomDouble(28, 46),
        _EcgPattern.highRisk => _randomDouble(25, 36),
      };

      center += baseSpacing;
    }

    return List<double>.generate(length, (i) {
      final x = i.toDouble();
      final baseline = 0.04 * math.sin((2 * math.pi * x) / length);
      final noise = _randomDouble(-0.035, 0.035);
      var value = baseline + noise;

      for (final c in centers) {
        final rAmp = switch (pattern) {
          _EcgPattern.normal => _randomDouble(0.9, 1.12),
          _EcgPattern.irregular => _randomDouble(0.85, 1.25),
          _EcgPattern.highRisk => _randomDouble(1.18, 1.55),
        };

        final sAmp = pattern == _EcgPattern.highRisk
            ? _randomDouble(-0.95, -0.65)
            : _randomDouble(-0.55, -0.35);
        final tAmp = pattern == _EcgPattern.highRisk
            ? _randomDouble(0.42, 0.68)
            : _randomDouble(0.18, 0.34);

        value += _pulse(x, c - 13, _randomDouble(0.08, 0.15), 3.2);
        value += _pulse(x, c - 3, _randomDouble(-0.28, -0.16), 1.25);
        value += _pulse(x, c, rAmp, 1.05);
        value += _pulse(x, c + 3, sAmp, 1.45);
        value += _pulse(x, c + 15, tAmp, 5.0);

        if (pattern == _EcgPattern.highRisk) {
          value += _pulse(x, c + 8, _randomDouble(0.12, 0.22), 4.8);
        }
      }

      if (pattern == _EcgPattern.irregular) {
        value += 0.06 * math.sin((2 * math.pi * x) / _randomDouble(17, 23));
      }

      return value.clamp(-1.4, 1.7).toDouble();
    });
  }

  static double _pulse(
    double x,
    double center,
    double amplitude,
    double width,
  ) {
    final distance = x - center;
    return amplitude * math.exp(-(distance * distance) / (2 * width * width));
  }

  static int _randomInt(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }

  static double _randomDouble(double min, double max) {
    return min + (_random.nextDouble() * (max - min));
  }

  static String _signalQuality() {
    return _random.nextDouble() < 0.75 ? 'Good' : 'Excellent';
  }
}

enum _EcgPattern { normal, irregular, highRisk }

// ================= ECG ANALYSIS SCREEN =================

class EcgComingNextScreen extends StatefulWidget {
  final String userName;
  final String age;
  final String gender;
  final List<String> medicalFactors;
  final List<String> symptoms;
  final int medicalFactorScore;
  final int symptomsScore;
  final int userInfoScore;

  const EcgComingNextScreen({
    super.key,
    required this.userName,
    required this.age,
    required this.gender,
    required this.medicalFactors,
    required this.symptoms,
    required this.medicalFactorScore,
    required this.symptomsScore,
    required this.userInfoScore,
  });

  @override
  State<EcgComingNextScreen> createState() => _EcgComingNextScreenState();
}

class _EcgComingNextScreenState extends State<EcgComingNextScreen> {
  late EcgSimulationResult simulatedEcg;

  @override
  void initState() {
    super.initState();
    simulatedEcg = EcgSimulator.generate();
  }

  void analyzeEcg() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EcgAnalysisLoadingScreen(
          userName: widget.userName,
          age: widget.age,
          gender: widget.gender,
          medicalFactors: widget.medicalFactors,
          symptoms: widget.symptoms,
          userInfoScore: widget.userInfoScore,
          ecgAiScore: simulatedEcg.ecgAiScore,
          heartRate: simulatedEcg.heartRate,
          predictionLabel: simulatedEcg.predictionLabel,
          rhythmStatus: simulatedEcg.rhythmStatus,
          signalQuality: simulatedEcg.signalQuality,
          waveform: simulatedEcg.waveform,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        title: const Text('ECG Analysis'),
        backgroundColor: const Color(0xFFF7FAFC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: ListView(
          children: [
            const Text(
              'Step 4 of 4',
              style: TextStyle(
                color: Color(0xFF007C89),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const LinearProgressIndicator(
              value: 1.0,
              color: Color(0xFF007C89),
              backgroundColor: Color(0xFFE2E8F0),
            ),
            const SizedBox(height: 24),

            const Text(
              'Smartwatch ECG Analysis',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'A simulated ECG sample is generated automatically for this assessment using the same normal, irregular, and high-risk patterns used in the AI demo.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ECG Preview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 150,
                      child: EcgChartWidget(data: simulatedEcg.waveform),
                    ),

                    const SizedBox(height: 16),

                    Text('Prediction Preview: ${simulatedEcg.predictionLabel}'),
                    Text('Heart Rate: ${simulatedEcg.heartRate} bpm'),
                    Text('Rhythm: ${simulatedEcg.rhythmStatus}'),
                    Text('Signal Quality: ${simulatedEcg.signalQuality}'),
                    Text(
                      'ECG AI Score: ${simulatedEcg.ecgAiScore} / 100',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007C89),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7F8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Your profile score is ${widget.userInfoScore}/100. It will represent 30% of the final result. ECG will represent 70%.',
                style: const TextStyle(
                  color: Color(0xFF007C89),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            PrimaryActionButton(
              label: 'Analyze ECG',
              icon: Icons.monitor_heart_rounded,
              onPressed: analyzeEcg,
            ),
          ],
        ),
      ),
    );
  }
}

// ================= ECG ANALYSIS LOADING SCREEN =================

class EcgAnalysisLoadingScreen extends StatefulWidget {
  final String userName;
  final String age;
  final String gender;
  final List<String> medicalFactors;
  final List<String> symptoms;
  final int userInfoScore;
  final int ecgAiScore;
  final int heartRate;
  final String predictionLabel;
  final String rhythmStatus;
  final String signalQuality;
  final List<double> waveform;

  const EcgAnalysisLoadingScreen({
    super.key,
    required this.userName,
    required this.age,
    required this.gender,
    required this.medicalFactors,
    required this.symptoms,
    required this.userInfoScore,
    required this.ecgAiScore,
    required this.heartRate,
    required this.predictionLabel,
    required this.rhythmStatus,
    required this.signalQuality,
    required this.waveform,
  });

  @override
  State<EcgAnalysisLoadingScreen> createState() =>
      _EcgAnalysisLoadingScreenState();
}

class _EcgAnalysisLoadingScreenState extends State<EcgAnalysisLoadingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RiskResultScreen(
            userName: widget.userName,
            age: widget.age,
            gender: widget.gender,
            medicalFactors: widget.medicalFactors,
            symptoms: widget.symptoms,
            userInfoScore: widget.userInfoScore,
            ecgAiScore: widget.ecgAiScore,
            heartRate: widget.heartRate,
            predictionLabel: widget.predictionLabel,
            rhythmStatus: widget.rhythmStatus,
            signalQuality: widget.signalQuality,
            waveform: widget.waveform,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.monitor_heart, size: 90, color: Color(0xFF007C89)),
              SizedBox(height: 24),
              Text(
                'Analyzing ECG...',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Receiving smartwatch ECG signal\nCleaning noise\nExtracting rhythm features\nRunning AI model\nCalculating final risk score',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 32),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= RISK RESULT SCREEN =================

class RiskResultScreen extends StatelessWidget {
  final String userName;
  final String age;
  final String gender;
  final List<String> medicalFactors;
  final List<String> symptoms;
  final int userInfoScore;
  final int ecgAiScore;
  final int heartRate;
  final String predictionLabel;
  final String rhythmStatus;
  final String signalQuality;
  final List<double> waveform;

  const RiskResultScreen({
    super.key,
    required this.userName,
    required this.age,
    required this.gender,
    required this.medicalFactors,
    required this.symptoms,
    required this.userInfoScore,
    required this.ecgAiScore,
    required this.heartRate,
    required this.predictionLabel,
    required this.rhythmStatus,
    required this.signalQuality,
    required this.waveform,
  });

  double getFinalRiskScore() {
    return (ecgAiScore * 0.70) + (userInfoScore * 0.30);
  }

  String getRiskLevel() {
    final score = getFinalRiskScore();

    if (score <= 30) return 'Low Risk';
    if (score <= 60) return 'Medium Risk';
    return 'High Risk';
  }

  Color getRiskColor() {
    final level = getRiskLevel();

    if (level == 'Low Risk') return Colors.green;
    if (level == 'Medium Risk') return Colors.orange;
    return Colors.red;
  }

  String getRecommendation() {
    final level = getRiskLevel();

    if (level == 'Low Risk') {
      return 'No major abnormal pattern was detected in this ECG sample. Continue monitoring and repeat assessment if symptoms appear.';
    }

    if (level == 'Medium Risk') {
      return 'Some risk indicators were detected. Medical review is recommended, especially if symptoms continue.';
    }

    return 'High-risk ECG pattern and/or symptoms were detected. Urgent medical review is recommended.';
  }

  Future<void> exportPdfReport(BuildContext context) async {
    final bytes = await buildPdfReport();
    final fileName = 'cvd_ai_report_${safeFileName(userName)}.pdf';

    await Printing.sharePdf(bytes: bytes, filename: fileName);

    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('PDF report is ready.')));
  }

  Future<Uint8List> buildPdfReport() async {
    final report = pw.Document();
    final finalScore = getFinalRiskScore();
    final riskLevel = getRiskLevel();
    final generatedAt = DateTime.now();

    report.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return [
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: const pw.BoxDecoration(color: PdfColors.teal900),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Row(
                    children: [
                      pw.Container(
                        width: 42,
                        height: 42,
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          borderRadius: pw.BorderRadius.circular(21),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            'ECG',
                            style: pw.TextStyle(
                              color: PdfColors.red600,
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 12),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'PulseGuard Cardiac Screening Unit',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 17,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            'CVD.AI Clinical ECG Assessment Report',
                            style: const pw.TextStyle(
                              color: PdfColors.teal50,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'REPORT ID',
                        style: const pw.TextStyle(
                          color: PdfColors.teal100,
                          fontSize: 8,
                        ),
                      ),
                      pw.Text(
                        reportId(generatedAt),
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        formatDateTime(generatedAt),
                        style: const pw.TextStyle(
                          color: PdfColors.teal50,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 14),
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey50,
                border: pw.Border.all(color: PdfColors.grey400),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'CLINICAL RISK CLASSIFICATION',
                        style: const pw.TextStyle(
                          fontSize: 9,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        riskLevel,
                        style: pw.TextStyle(
                          fontSize: 24,
                          color: riskPdfColor(riskLevel),
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'FINAL SCORE',
                        style: const pw.TextStyle(
                          fontSize: 9,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        '${finalScore.toStringAsFixed(1)} / 100',
                        style: pw.TextStyle(
                          fontSize: 28,
                          color: riskPdfColor(riskLevel),
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 14),
            sectionTitle('Patient Details'),
            infoGrid([
              ['Name', userName],
              ['Age', age],
              ['Gender', gender],
              ['Exam Type', 'Simulated single-lead ECG screening'],
            ]),
            pw.SizedBox(height: 14),
            sectionTitle('Clinical Summary'),
            infoGrid([
              ['Prediction', predictionLabel],
              ['Heart Rate', '$heartRate bpm'],
              ['Rhythm', rhythmStatus],
              ['Signal Quality', signalQuality],
              ['ECG AI Score', '$ecgAiScore / 100'],
              ['Profile Score', '$userInfoScore / 100'],
            ]),
            pw.SizedBox(height: 14),
            sectionTitle('ECG Image'),
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                color: PdfColors.white,
                border: pw.Border.all(color: PdfColors.grey700, width: 0.8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Lead I rhythm strip - generated ECG waveform',
                    style: const pw.TextStyle(
                      fontSize: 9,
                      color: PdfColors.grey700,
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  pw.CustomPaint(
                    size: const PdfPoint(500, 150),
                    painter: drawPdfEcg,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 14),
            sectionTitle('Medical Profile'),
            infoGrid([
              [
                'Medical Factors',
                medicalFactors.isEmpty
                    ? 'None reported'
                    : medicalFactors.join(', '),
              ],
              [
                'Symptoms',
                symptoms.isEmpty ? 'None reported' : symptoms.join(', '),
              ],
            ]),
            pw.SizedBox(height: 14),
            sectionTitle('Clinical Recommendation'),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey100,
                border: pw.Border.all(color: riskPdfColor(riskLevel), width: 1),
              ),
              child: pw.Text(
                getRecommendation(),
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey900,
                  fontWeight: pw.FontWeight.bold,
                  lineSpacing: 4,
                ),
              ),
            ),
            pw.SizedBox(height: 14),
            pw.Text(
              'Physician note: This document is generated for demonstration and screening support only. It is not a medical diagnosis and does not replace evaluation by a licensed healthcare professional.',
              style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
            ),
          ];
        },
      ),
    );

    return report.save();
  }

  pw.Widget sectionTitle(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 13,
          color: PdfColors.teal900,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget reportSection({
    required String title,
    String? subtitle,
    required pw.Widget child,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        borderRadius: pw.BorderRadius.circular(14),
        border: pw.Border.all(color: PdfColors.grey300, width: 0.7),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.grey900,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                width: 34,
                height: 3,
                decoration: pw.BoxDecoration(
                  color: PdfColors.teal600,
                  borderRadius: pw.BorderRadius.circular(999),
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              subtitle,
              style: const pw.TextStyle(
                fontSize: 9.5,
                color: PdfColors.grey600,
              ),
            ),
          ],
          pw.SizedBox(height: 11),
          child,
        ],
      ),
    );
  }

  pw.Widget metricCard(String label, String value, PdfColor color) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(13),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey50,
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(color: PdfColors.grey300, width: 0.6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label.toUpperCase(),
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            value,
            maxLines: 1,
            style: pw.TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget detailCard(String label, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(11),
      decoration: pw.BoxDecoration(
        color: PdfColors.teal50,
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 11.5,
              color: PdfColors.teal900,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget chipList(String title, List<String> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 10.5, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 7),
        pw.Wrap(
          spacing: 6,
          runSpacing: 6,
          children: items.map(reportChip).toList(),
        ),
      ],
    );
  }

  pw.Widget reportChip(String label) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(999),
        border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
      ),
      child: pw.Text(
        label,
        style: const pw.TextStyle(fontSize: 9.2, color: PdfColors.grey800),
      ),
    );
  }

  pw.Widget infoGrid(List<List<String>> rows) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      columnWidths: const {
        0: pw.FlexColumnWidth(1.2),
        1: pw.FlexColumnWidth(2),
      },
      children: rows.map((row) {
        return pw.TableRow(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(8),
              color: PdfColors.grey100,
              child: pw.Text(
                row[0],
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(row[1]),
            ),
          ],
        );
      }).toList(),
    );
  }

  pw.Widget bulletList(String title, List<String> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 4),
        ...items.map((item) => pw.Text('- $item')),
      ],
    );
  }

  void drawPdfEcg(PdfGraphics canvas, PdfPoint size) {
    canvas
      ..setFillColor(PdfColors.white)
      ..drawRect(0, 0, size.x, size.y)
      ..fillPath();

    canvas
      ..setStrokeColor(const PdfColor.fromInt(0xffffd6d6))
      ..setLineWidth(0.25);

    for (double y = 0; y <= size.y; y += 10) {
      canvas.drawLine(0, y, size.x, y);
    }

    for (double x = 0; x <= size.x; x += 10) {
      canvas.drawLine(x, 0, x, size.y);
    }

    canvas.strokePath();

    canvas
      ..setStrokeColor(const PdfColor.fromInt(0xffff9b9b))
      ..setLineWidth(0.55);

    for (double y = 0; y <= size.y; y += 50) {
      canvas.drawLine(0, y, size.x, y);
    }

    for (double x = 0; x <= size.x; x += 50) {
      canvas.drawLine(x, 0, x, size.y);
    }

    canvas.strokePath();

    if (waveform.length < 2) return;

    canvas
      ..setStrokeColor(PdfColors.red700)
      ..setLineWidth(2.0);

    for (int i = 0; i < waveform.length; i++) {
      final x = size.x * i / (waveform.length - 1);
      final y = (size.y / 2) - waveform[i] * size.y * 0.25;

      if (i == 0) {
        canvas.moveTo(x, y);
      } else {
        canvas.lineTo(x, y);
      }
    }

    canvas.strokePath();
  }

  String reportId(DateTime value) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');

    return 'CVD-${value.year}${twoDigits(value.month)}${twoDigits(value.day)}'
        '-${twoDigits(value.hour)}${twoDigits(value.minute)}';
  }

  PdfColor riskPdfColor(String riskLevel) {
    if (riskLevel == 'Low Risk') return PdfColors.green700;
    if (riskLevel == 'Medium Risk') return PdfColors.orange700;
    return PdfColors.red700;
  }

  String formatDateTime(DateTime value) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');

    return '${value.year}-${twoDigits(value.month)}-${twoDigits(value.day)} '
        '${twoDigits(value.hour)}:${twoDigits(value.minute)}';
  }

  String safeFileName(String value) {
    final safe = value.trim().replaceAll(RegExp(r'[^A-Za-z0-9_-]+'), '_');
    if (safe.isEmpty) return 'user';
    return safe.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final finalScore = getFinalRiskScore();
    final riskLevel = getRiskLevel();
    final riskColor = getRiskColor();

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        title: const Text('Risk Result'),
        backgroundColor: const Color(0xFFF7FAFC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: riskColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: riskColor.withValues(alpha: 0.4)),
              ),
              child: Column(
                children: [
                  Icon(
                    riskLevel == 'High Risk' ? Icons.warning : Icons.favorite,
                    size: 70,
                    color: riskColor,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    riskLevel,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${finalScore.toStringAsFixed(1)} / 100',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ECG Analysis',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 150,
                      child: EcgChartWidget(data: waveform),
                    ),

                    const SizedBox(height: 16),

                    Text('Prediction: $predictionLabel'),
                    Text('Heart Rate: $heartRate bpm'),
                    Text('Rhythm: $rhythmStatus'),
                    Text('Signal Quality: $signalQuality'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ImpactSummaryCard(
              rhythmStatus: rhythmStatus,
              predictionLabel: predictionLabel,
              medicalFactors: medicalFactors,
              symptoms: symptoms,
              riskColor: riskColor,
            ),

            const SizedBox(height: 20),

            RecommendationCard(
              riskLevel: riskLevel,
              riskColor: riskColor,
              recommendation: getRecommendation(),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () => exportPdfReport(context),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Download PDF Report'),
            ),

            const SizedBox(height: 12),

            if (riskLevel == 'High Risk')
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Caregiver alert sent successfully.'),
                    ),
                  );
                },
                icon: const Icon(Icons.emergency),
                label: const Text('Notify Caregiver'),
              ),

            const SizedBox(height: 16),

            const Text(
              'This result is not a medical diagnosis. Please consult a healthcare professional.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class ImpactSummaryCard extends StatelessWidget {
  final String rhythmStatus;
  final String predictionLabel;
  final List<String> medicalFactors;
  final List<String> symptoms;
  final Color riskColor;

  const ImpactSummaryCard({
    super.key,
    required this.rhythmStatus,
    required this.predictionLabel,
    required this.medicalFactors,
    required this.symptoms,
    required this.riskColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.insights_rounded, color: riskColor),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Result Drivers',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ImpactItem(
              icon: Icons.monitor_heart_rounded,
              title: 'ECG prediction',
              value: predictionLabel,
              subtitle: 'This carries the highest weight in the final score.',
              color: riskColor,
            ),
            const SizedBox(height: 10),
            ImpactItem(
              icon: Icons.timeline_rounded,
              title: 'Rhythm status',
              value: rhythmStatus,
              subtitle: rhythmStatus == 'Regular'
                  ? 'No irregular rhythm pattern was detected.'
                  : 'Irregular rhythm contributed to the risk signal.',
              color: const Color(0xFF007C89),
            ),
            if (medicalFactors.isNotEmpty || symptoms.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Profile context',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...medicalFactors.map(
                    (factor) => ResultChip(
                      label: factor,
                      icon: Icons.medical_information_rounded,
                    ),
                  ),
                  ...symptoms.map(
                    (symptom) => ResultChip(
                      label: symptom,
                      icon: Icons.warning_amber_rounded,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ImpactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const ImpactItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResultChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const ResultChip({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF7F8),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFD5EAED)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF007C89)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF233238),
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final String riskLevel;
  final Color riskColor;
  final String recommendation;

  const RecommendationCard({
    super.key,
    required this.riskLevel,
    required this.riskColor,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {
    final icon = riskLevel == 'High Risk'
        ? Icons.priority_high_rounded
        : riskLevel == 'Medium Risk'
        ? Icons.health_and_safety_rounded
        : Icons.check_circle_rounded;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: riskColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: riskColor.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: riskColor.withValues(alpha: 0.16),
            child: Icon(icon, color: riskColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$riskLevel Recommendation',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: riskColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  recommendation,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.45,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D2A30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= ECG CHART WIDGET =================

class EcgChartWidget extends StatefulWidget {
  final List<double> data;

  const EcgChartWidget({super.key, required this.data});

  @override
  State<EcgChartWidget> createState() => _EcgChartWidgetState();
}

class _EcgChartWidgetState extends State<EcgChartWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: EcgChartPainter(widget.data, progress: _controller.value),
          child: Container(),
        );
      },
    );
  }
}

class EcgChartPainter extends CustomPainter {
  final List<double> data;
  final double progress;

  EcgChartPainter(this.data, {required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2 || size.isEmpty) return;

    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.18)
      ..strokeWidth = 1;

    final glowPaint = Paint()
      ..color = const Color(0xFFE53935).withValues(alpha: 0.24)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final linePaint = Paint()
      ..color = const Color(0xFFE53935)
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final sweepPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFE53935).withValues(alpha: 0),
          const Color(0xFFE53935).withValues(alpha: 0.55),
          const Color(0xFFE53935).withValues(alpha: 0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 6; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (int i = 0; i < 8; i++) {
      final x = size.width * i / 7;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    final path = Path();
    final visibleSamples = data.length;
    final phase = progress * visibleSamples;

    for (int i = 0; i < visibleSamples; i++) {
      final x = size.width * i / (visibleSamples - 1);
      final y = size.height / 2 - _sampleAt(i + phase) * size.height * 0.28;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, linePaint);

    final sweepX = size.width * 0.86;
    canvas.drawLine(
      Offset(sweepX, 8),
      Offset(sweepX, size.height - 8),
      sweepPaint,
    );
    canvas.drawCircle(
      Offset(sweepX, size.height / 2),
      4.5,
      Paint()..color = const Color(0xFFE53935).withValues(alpha: 0.55),
    );
  }

  double _sampleAt(double index) {
    final length = data.length;
    final wrapped = index % length;
    final left = wrapped.floor();
    final right = (left + 1) % length;
    final t = wrapped - left;
    return data[left] + ((data[right] - data[left]) * t);
  }

  @override
  bool shouldRepaint(covariant EcgChartPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.data != data;
  }
}
// ================= ADMIN DASHBOARD =================

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFFF7FAFC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: ListView(
          children: [
            const Text(
              'PulseGuard AI Overview',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Monitor users, risk rates, ECG results, and high-risk alerts.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Row(
              children: const [
                Expanded(
                  child: DashboardCard(
                    title: 'Total Users',
                    value: '8',
                    color: Color(0xFF007C89),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DashboardCard(
                    title: 'High Risk',
                    value: '3',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: DashboardCard(
                    title: 'Medium Risk',
                    value: '3',
                    color: Colors.orange,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DashboardCard(
                    title: 'Low Risk',
                    value: '2',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text(
              'Latest High-Risk Alerts',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const AlertCard(
              name: 'Ahmad Saleh',
              reason: 'High ECG score + chest pain',
              risk: '83/100',
            ),
            const AlertCard(
              name: 'Mariam Nasser',
              reason: 'Irregular rhythm + previous heart disease',
              risk: '87/100',
            ),
            const AlertCard(
              name: 'Khaled Amro',
              reason: 'High ECG score + diabetes',
              risk: '78/100',
            ),
          ],
        ),
      ),
    );
  }
}

// ================= REUSABLE WIDGETS =================

class PrimaryActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<PrimaryActionButton> createState() => _PrimaryActionButtonState();
}

class _PrimaryActionButtonState extends State<PrimaryActionButton> {
  bool isPressed = false;

  void setPressed(bool value) {
    if (isPressed == value) return;
    setState(() {
      isPressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isPressed ? 0.97 : 1,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00A6A6), Color(0xFF007C89), Color(0xFF045D75)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF007C89).withValues(alpha: 0.26),
              blurRadius: isPressed ? 10 : 18,
              offset: Offset(0, isPressed ? 5 : 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            onHighlightChanged: setPressed,
            borderRadius: BorderRadius.circular(16),
            splashColor: Colors.white.withValues(alpha: 0.16),
            highlightColor: Colors.white.withValues(alpha: 0.08),
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, color: Colors.white, size: 23),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
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

class InfoCard extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;

  const InfoCard({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF007C89),
              child: Text(number, style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertCard extends StatelessWidget {
  final String name;
  final String reason;
  final String risk;

  const AlertCard({
    super.key,
    required this.name,
    required this.reason,
    required this.risk,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFFFEBEE),
          child: Icon(Icons.warning, color: Colors.red),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(reason),
        trailing: Text(
          risk,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
