import 'package:digital_learning_application/screens/homescreen/student_dashboard.dart';
import 'package:flutter/material.dart';
//import 'package:digital_learning_application/screens/homescreen/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _studentFormKey = GlobalKey<FormState>();
  final _teacherFormKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _studentPhoneController = TextEditingController();
  final TextEditingController _teacherIdController = TextEditingController();
  final TextEditingController _teacherPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _studentNameController.dispose();
    _studentPhoneController.dispose();
    _teacherIdController.dispose();
    _teacherPhoneController.dispose();
    super.dispose();
  }

  void _handleLogin(String userType) {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$userType लॉग इन सफल! / Login successful!'),
        backgroundColor: Colors.green,
      ),
    );
    
    // Navigate to DashboardScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const StudentDashboard(),
      ),
    );
  }

  void _handleStudentLogin() {
    if (_studentFormKey.currentState!.validate()) {
      _handleLogin('student');
    }
  }

  void _handleTeacherLogin() {
    if (_teacherFormKey.currentState!.validate()) {
      _handleLogin('teacher');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hero_learning.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Card(
                  elevation: 20,
                  shadowColor: Colors.black.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).cardColor.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header with mascot
                        Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/owl_logo.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.school,
                                      size: 40,
                                      color: Color(0xFF0F4C75),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ).createShader(bounds),
                              child: const Text(
                                'Nabha Digital Education',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Nabha Digital Learning Platform',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color
                                    ?.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Tabs
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            unselectedLabelColor:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            tabs: const [
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.school, size: 16),
                                    SizedBox(width: 8),
                                    Text('Student'),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.people, size: 16),
                                    SizedBox(width: 8),
                                    Text('Teacher'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Tab Content
                        SizedBox(
                          height: 250,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Student Tab
                              Form(
                                key: _studentFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Name Field
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 16,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Name',
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _studentNameController,
                                      style: const TextStyle(fontSize: 18),
                                      decoration: InputDecoration(
                                        hintText: 'Enter your name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                                        prefixIcon: const Icon(Icons.person),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),

                                    // Phone Number Field
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 16,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Phone Number',
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _studentPhoneController,
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(fontSize: 18),
                                      decoration: InputDecoration(
                                        hintText: 'Enter your phone number',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                                        prefixIcon: const Icon(Icons.phone),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your phone number';
                                        }
                                        if (value.length < 10) {
                                          return 'Please enter a valid phone number';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: _handleStudentLogin,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 4,
                                        ),
                                        child: const Text(
                                          'लॉग इन करें / Login',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Teacher Tab
                              Form(
                                key: _teacherFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.badge,
                                          size: 16,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        const SizedBox(width: 3),
                                        const Text(
                                          'शिक्षक ID / Teacher ID',
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    TextFormField(
                                      controller: _teacherIdController,
                                      decoration: InputDecoration(
                                        hintText: 'शिक्षक ID डालें',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                                        prefixIcon: const Icon(Icons.badge),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'शिक्षक ID डालें';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 16,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'फ़ोन नंबर / Phone Number',
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    TextFormField(
                                      controller: _teacherPhoneController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        hintText: 'अपना फ़ोन नंबर डालें',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                                        prefixIcon: const Icon(Icons.phone),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'फ़ोन नंबर डालें';
                                        }
                                        if (value.length < 10) {
                                          return 'वैध फ़ोन नंबर डालें';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 3),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: _handleTeacherLogin,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 4,
                                        ),
                                        child: const Text(
                                          'लॉग इन करें / Login',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Footer
                        Text(
                          'ऑफ़लाइन मोड उपलब्ध • Offline Mode Available',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.color
                                ?.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}