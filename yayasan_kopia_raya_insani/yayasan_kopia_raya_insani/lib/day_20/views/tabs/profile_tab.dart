import 'package:flutter/material.dart';
import '../../constans/app_colors.dart';
import '../../constans/app_styles.dart';
import '../../utils/preference_handler.dart';
import '../login_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String _userName = 'Sahabat Kopia';
  String _userEmail = 'sahabat@kopia.or.id';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await PreferenceHandler.getUserName();
    final email = await PreferenceHandler.getUserEmail();
    setState(() {
      _userName = name;
      _userEmail = email;
    });
  }

  Future<void> _handleLogout() async {
    await PreferenceHandler.clearSession();
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header User Card
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.splashGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBeNu1b1qSTsmQQ0u7U1sI3FawR_4y_aGOAYPPxfuJzVx_smowB1n_8XuThaBWt41qbXOhI3A-LmMmi2HwJM2ZMSrROsqtwOuspko26sxxbNM2L9hTwCuk-uIDws8au5Cv5LpJwj1x05ivkFVLLPyWUy2LuT4NSa2aQzANfbBXOTme0aNfxjD6KTbtEdSK0tqtXsA7AWZ7qHmkO_NL8cod56UJ3mz1HFcbDWfrTDq7jyLSUbkpDDaHLABdlgUHer0Dm4YM',
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person_rounded,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _userName,
                  style: AppStyles.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userEmail,
                  style: AppStyles.bodyMedium.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryFixed,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Donatur Aktif Yayasan',
                    style: AppStyles.labelSmall.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // About Foundation Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tentang Kami',
                  style: AppStyles.headlineMedium.copyWith(
                    fontSize: 20,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.surfaceVariant),
                    boxShadow: AppStyles.cardShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.foundation_rounded,
                              color: AppColors.primary, size: 28),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Yayasan Kopia Raya Insani',
                              style: AppStyles.headlineMedium.copyWith(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Yayasan Kopia Raya Insani adalah lembaga sosial & keagamaan yang berdedikasi membangun masyarakat yang madani melalui pengelolaan Zakat, Infaq, Sedekah, Qurban, serta pelatihan ketrampilan masyarakat.',
                        style: AppStyles.bodyMedium.copyWith(
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Visi & Misi Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.surfaceVariant),
                    boxShadow: AppStyles.cardShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Visi & Misi',
                        style: AppStyles.headlineMedium.copyWith(
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildBulletItem(
                          'Visi: Menjadi lembaga filantropi terpercaya dalam mewujudkan insan yang mandiri dan berakhlak madani.'),
                      const SizedBox(height: 8),
                      _buildBulletItem(
                          'Misi: Mengoptimalkan penghimpunan dan penyaluran dana ZISWAF secara transparan & profesional.'),
                      const SizedBox(height: 8),
                      _buildBulletItem(
                          'Misi: Memberikan program pendidikan, pelatihan kerja digital, dan bantuan kemanusiaan.'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Contact & Address Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.surfaceVariant),
                    boxShadow: AppStyles.cardShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kontak & Layanan Hubungan',
                        style: AppStyles.headlineMedium.copyWith(
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildContactRow(
                        icon: Icons.location_on_outlined,
                        title: 'Alamat',
                        subtitle: 'Jl. Raya Insani No. 88, Jakarta Selatan',
                      ),
                      const SizedBox(height: 12),
                      _buildContactRow(
                        icon: Icons.phone_outlined,
                        title: 'Telepon / WhatsApp',
                        subtitle: '+62 812-3456-7890',
                      ),
                      const SizedBox(height: 12),
                      _buildContactRow(
                        icon: Icons.email_outlined,
                        title: 'Email',
                        subtitle: 'info@kopiarayainsani.or.id',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: _handleLogout,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout_rounded, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Keluar dari Akun',
                          style: AppStyles.labelMedium.copyWith(
                            color: AppColors.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primary)),
        Expanded(
          child: Text(
            text,
            style: AppStyles.bodyMedium.copyWith(fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.labelSmall),
              Text(
                subtitle,
                style: AppStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
