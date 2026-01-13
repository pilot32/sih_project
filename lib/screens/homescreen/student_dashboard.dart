import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int selectedSubject = 0;
  int selectedLesson = 0;

  // Mock data
  final List<Map<String, dynamic>> subjects = [
    {
      'name': 'हिंदी',
      'englishName': 'Hindi Language',
      'progress': 75,
      'completed': 15,
      'total': 20,
      'timeSpent': 15,
      'daysLeft': 7,
      'color': Colors.orange,
      'icon': Icons.menu_book,
    },
    {
      'name': 'अंग्रेजी',
      'englishName': 'English Language',
      'progress': 60,
      'completed': 11,
      'total': 18,
      'timeSpent': 15,
      'daysLeft': 3,
      'color': Colors.blue,
      'icon': Icons.language,
    },
    {
      'name': 'गणित',
      'englishName': 'Mathematics',
      'progress': 45,
      'completed': 11,
      'total': 25,
      'timeSpent': 15,
      'daysLeft': 5,
      'color': Colors.green,
      'icon': Icons.calculate,
    },
  ];

  final List<Map<String, dynamic>> preparationSubjects = [
    {
      'name': 'विज्ञान',
      'englishName': 'Science',
      'progress': 0,
      'completed': 0,
      'total': 30,
      'color': Color(0xFF9C64F6),
      'icon': Icons.science,
    },
    {
      'name': 'सामाजिक विज्ञान',
      'englishName': 'Social Science',
      'progress': 0,
      'completed': 0,
      'total': 22,
      'color': Color(0xFFF59E0B),
      'icon': Icons.public,
    },
    {
      'name': 'वाणिज्य',
      'englishName': 'Commerce',
      'progress': 0,
      'completed': 0,
      'total': 18,
      'color': Color(0xFF10B981),
      'icon': Icons.attach_money,
    },
    {
      'name': 'कंप्यूटर',
      'englishName': 'Computer Basics',
      'progress': 0,
      'completed': 0,
      'total': 15,
      'color': Color(0xFF6B7280),
      'icon': Icons.computer,
    },
  ];

  void onLogout() {
    // Navigate to login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage2(), // Make sure to import this
      ),
    );
  }

  void onSettings() {
    // Implement settings functionality
    print("Settings pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 24),
              
              // Stats Cards
              _buildStatsCards(),
              const SizedBox(height: 32),
              
              // Main Subjects Section
              _buildMainSubjectsSection(),
              const SizedBox(height: 32),
              
              // Preparation Section
              _buildPreparationSection(),
              const SizedBox(height: 32),
              
              // Current Tasks Section
              _buildCurrentTasksSection(),
              const SizedBox(height: 100), // Space for bottom navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Avatar
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.orange.shade100,
            // image: DecorationImage(
            //   image: AssetImage('assets/mascotOwl.png'), // Add this asset to pubspec.yaml
            //   fit: BoxFit.cover,
            // ),
          ),
          child: Icon(Icons.person, color: Colors.orange, size: 24),
        ),
        const SizedBox(width: 12),
        
        // Greeting
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'नमस्ते, छात्र 771!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'आज भी कुछ नया सीखते हैं',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        
        // Action buttons
        IconButton(
          onPressed: onSettings,
          icon: Icon(Icons.settings, color: Colors.grey[600]),
        ),
        IconButton(
          onPressed: onLogout,
          icon: Icon(Icons.logout, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[300]!,
            Colors.grey[200]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildStatItem('60%', 'कुल प्रगति', Colors.blue),
          _buildStatItem('15', 'दिन की लकीर', Colors.green),
          _buildStatItem('127', 'कुल तारे', Colors.orange),
          _buildStatItem('5', 'बैज अर्जित', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    IconData icon;
    switch (color) {
      case Colors.green:
        icon = Icons.trending_up;
        break;
      case Colors.orange:
        icon = Icons.star;
        break;
      case Colors.purple:
        icon = Icons.emoji_events;
        break;
      default:
        icon = Icons.show_chart;
    }

    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMainSubjectsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'मुख्य विषय',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'सक्रियता पाठ्यक्रम',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Subject cards grid
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.2 : 3,
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            return _buildSubjectCard(subjects[index]);
          },
        ),
      ],
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Background Image Implementation - Using Network Images
        image: DecorationImage(
          image: NetworkImage(_getSubjectBackgroundImage(subject['name'])),
          fit: BoxFit.cover,
          opacity: 0.3, // Adjust transparency (0.0 to 1.0)
          onError: (exception, stackTrace) {
            // Fallback if network image fails
            print('Failed to load image: $exception');
          },
        ),
        
        // Fallback color if image doesn't load
        color: subject['color'].withOpacity(0.1),
        
        // Alternative Options (comment out image above to use these):
        
        // Option 1: No background image, just solid color
        // color: subject['color'].withOpacity(0.1),
        
        // Option 2: Gradient background
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     subject['color'].withOpacity(0.2),
        //     subject['color'].withOpacity(0.05),
        //   ],
        // ),
        
        // Option 3: Custom gradient per subject
        // gradient: _getSubjectGradient(subject['name']),
        
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and days left
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: subject['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  subject['icon'],
                  color: subject['color'],
                  size: 20,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, color: Colors.white, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      '${subject['daysLeft']} दिन',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Subject name
          Text(
            subject['name'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            subject['englishName'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          
          // Progress section
          Row(
            children: [
              Icon(Icons.menu_book_outlined, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '${subject['completed']}/${subject['total']} पाठ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              Text(
                '${subject['progress']}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: subject['color'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Progress bar
          LinearProgressIndicator(
            value: subject['progress'] / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(subject['color']),
            minHeight: 6,
          ),
          const SizedBox(height: 12),
          
          // Time spent and continue button
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                'आगला पाठ: ${subject['timeSpent']} मिनट',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Handle continue lesson
                },
                child: Text(
                  'जारी रखें →',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreparationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'उच्च शिक्षा के लिए तैयारी',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle view all
              },
              child: Text(
                'जल्द ही उपलब्ध',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: preparationSubjects.length,
          itemBuilder: (context, index) {
            return _buildPreparationCard(preparationSubjects[index]);
          },
        ),
      ],
    );
  }

  Widget _buildPreparationCard(Map<String, dynamic> subject) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Background Image Implementation - Using Network Images
        image: DecorationImage(
          image: NetworkImage(_getPreparationBackgroundImage(subject['name'])),
          fit: BoxFit.cover,
          opacity: 0.2, // Lighter opacity for preparation cards
          onError: (exception, stackTrace) {
            // Fallback if network image fails
            print('Failed to load image: $exception');
          },
        ),
        
        // Fallback color if image doesn't load
        color: subject['color'].withOpacity(0.08),
        
        // Alternative Options (comment out image above to use these):
        
        // Option 1: No background image, just solid color
        // color: subject['color'].withOpacity(0.08),
        
        // Option 2: Gradient background
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     subject['color'].withOpacity(0.1),
        //     subject['color'].withOpacity(0.03),
        //   ],
        // ),
        
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: subject['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  subject['icon'],
                  color: subject['color'],
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subject['name'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            subject['englishName'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Icon(Icons.menu_book_outlined, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '${subject['completed']}/${subject['total']} पाठ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              Text(
                '${subject['progress']}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentTasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'वर्तमान कार्य',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'कोई वर्तमान कार्य नहीं',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(Icons.menu_book, 'आज का पाठ', true),
          _buildBottomNavItem(Icons.quiz, 'अभ्यास प्रश्न', false),
          _buildBottomNavItem(Icons.star_outline, 'पुरस्कार देखें', false),
          _buildBottomNavItem(Icons.settings, 'सेटिंग', false),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.blue : Colors.grey[600],
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.blue : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Helper method to get custom gradients for each subject
  LinearGradient _getSubjectGradient(String subjectName) {
    switch (subjectName) {
      case 'हिंदी':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.withOpacity(0.2),
            Colors.red.withOpacity(0.1),
          ],
        );
      case 'अंग्रेजी':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.2),
            Colors.cyan.withOpacity(0.1),
          ],
        );
      case 'गणित':
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.withOpacity(0.2),
            Colors.teal.withOpacity(0.1),
          ],
        );
      default:
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.withOpacity(0.1),
            Colors.grey.withOpacity(0.05),
          ],
        );
    }
  }

  // Helper method to get background images for main subjects
  String _getSubjectBackgroundImage(String subjectName) {
    // Using placeholder network images - replace with your local assets later
    switch (subjectName) {
      case 'हिंदी':
        return 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=500&h=300&fit=crop'; // Books/Literature
      case 'अंग्रेजी':
        return 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=500&h=300&fit=crop'; // English/Writing
      case 'गणित':
        return 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=500&h=300&fit=crop'; // Mathematics
      default:
        return 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=500&h=300&fit=crop'; // Books
    }
  }

  // Helper method to get background images for preparation subjects
  String _getPreparationBackgroundImage(String subjectName) {
    // Using placeholder network images - replace with your local assets later
    switch (subjectName) {
      case 'विज्ञान':
        return 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=500&h=300&fit=crop'; // Science
      case 'सामाजिक विज्ञान':
        return 'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?w=500&h=300&fit=crop'; // Social Studies
      case 'वाणिज्य':
        return 'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?w=500&h=300&fit=crop'; // Commerce
      case 'कंप्यूटर':
        return 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=500&h=300&fit=crop'; // Computer
      default:
        return 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=500&h=300&fit=crop'; // Books
    }
  }
}

// Mock LoginPage2 class - replace with your actual login page import
class LoginPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}