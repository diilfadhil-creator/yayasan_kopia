import 'package:flutter/material.dart';
import '../../constans/app_colors.dart';
import '../../constans/app_styles.dart';
import '../../models/program_model.dart';
import '../../utils/preference_handler.dart';

class HomeTab extends StatefulWidget {
  final Function(int) onTabSwitch;

  const HomeTab({super.key, required this.onTabSwitch});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String _userName = 'Sahabat Kopia';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await PreferenceHandler.getUserName();
    setState(() {
      _userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Banner Section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.splashGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: User Greeting & Notifications
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person_rounded,
                              color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Assalamualaikum,',
                              style: AppStyles.labelSmall.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              _userName,
                              style: AppStyles.labelMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none_rounded,
                          color: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tidak ada notifikasi baru'),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Hero Card Banner
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.tertiaryFixed,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Program Utama',
                                style: AppStyles.labelSmall.copyWith(
                                  color: AppColors.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Sedekah Subuh Berkah',
                              style: AppStyles.headlineMedium.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Menebar kebahagiaan & manfaat untuk sesama',
                              style: AppStyles.bodyMedium.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => widget.onTabSwitch(1), // Switch to Program tab
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                        ),
                        child: const Text(
                          'Donasi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Quick Action Menu Category Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Layanan Utama',
                  style: AppStyles.headlineMedium.copyWith(
                    fontSize: 18,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryItem(
                      context,
                      icon: Icons.volunteer_activism_rounded,
                      label: 'Zakat',
                      color: const Color(0xFFE1F5FE),
                      iconColor: AppColors.primary,
                      onTap: () => widget.onTabSwitch(2), // Zakat Tab
                    ),
                    _buildCategoryItem(
                      context,
                      icon: Icons.favorite_rounded,
                      label: 'Infaq',
                      color: const Color(0xFFF1F8E9),
                      iconColor: const Color(0xFF558B2F),
                      onTap: () => widget.onTabSwitch(1), // Program Tab
                    ),
                    _buildCategoryItem(
                      context,
                      icon: Icons.pets_rounded,
                      label: 'Qurban',
                      color: const Color(0xFFFFF3E0),
                      iconColor: const Color(0xFFE65100),
                      onTap: () => widget.onTabSwitch(1),
                    ),
                    _buildCategoryItem(
                      context,
                      icon: Icons.info_outline_rounded,
                      label: 'Tentang',
                      color: const Color(0xFFEDE7F6),
                      iconColor: const Color(0xFF512DA8),
                      onTap: () => widget.onTabSwitch(3), // Profile Tab
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Program Highlight Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Program Pilihan',
                  style: AppStyles.headlineMedium.copyWith(
                    fontSize: 18,
                    color: AppColors.onSurface,
                  ),
                ),
                TextButton(
                  onPressed: () => widget.onTabSwitch(1),
                  child: Text(
                    'Lihat Semua',
                    style: AppStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Program Cards List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: samplePrograms.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final program = samplePrograms[index];
              return _buildProgramCard(context, program);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppStyles.labelMedium.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramCard(BuildContext context, ProgramModel program) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceVariant),
        boxShadow: AppStyles.cardShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          program.imageUrl.startsWith('http')
              ? Image.network(
                  program.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 150,
                    color: AppColors.secondaryContainer,
                    child: const Center(
                      child: Icon(Icons.image_not_supported_rounded,
                          size: 48, color: AppColors.secondary),
                    ),
                  ),
                )
              : Image.asset(
                  program.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 150,
                    color: AppColors.secondaryContainer,
                    child: const Center(
                      child: Icon(Icons.image_not_supported_rounded,
                          size: 48, color: AppColors.secondary),
                    ),
                  ),
                ),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    program.category,
                    style: AppStyles.labelSmall.copyWith(
                      color: AppColors.onSecondaryContainer,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Title
                Text(
                  program.title,
                  style: AppStyles.headlineMedium.copyWith(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 12),

                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: program.progressPercentage,
                    minHeight: 8,
                    backgroundColor: AppColors.surfaceContainer,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primaryContainer,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Raised & Target Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terkumpul',
                          style: AppStyles.labelSmall,
                        ),
                        Text(
                          'Rp ${_formatRupiah(program.collectedAmount)}',
                          style: AppStyles.labelMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Sisa Hari',
                          style: AppStyles.labelSmall,
                        ),
                        Text(
                          '${program.daysRemaining} Hari',
                          style: AppStyles.labelMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatRupiah(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
}
