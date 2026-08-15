import 'package:flutter/material.dart';
import '../constans/app_colors.dart';
import '../constans/app_styles.dart';
import '../models/certificate_model.dart';
import '../utils/preference_handler.dart';

class DonationCertificateScreen extends StatefulWidget {
  const DonationCertificateScreen({super.key});

  @override
  State<DonationCertificateScreen> createState() =>
      _DonationCertificateScreenState();
}

class _DonationCertificateScreenState
    extends State<DonationCertificateScreen> {
  String _userName = 'Sahabat Kopia';
  String _selectedCategory = 'Semua';
  List<CertificateModel> _certificates = [];

  final List<String> _categories = [
    'Semua',
    'Zakat',
    'Infak',
    'Wakaf',
    'Pendidikan',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserCertificates();
  }

  Future<void> _loadUserCertificates() async {
    final name = await PreferenceHandler.getUserName();
    if (!mounted) return;
    setState(() {
      _userName = name.isNotEmpty && name != 'Sahabat Kopia'
          ? name
          : 'Ahmad Fulan';
      _certificates = CertificateModel.getDummyCertificates(_userName);
    });
  }

  List<CertificateModel> get _filteredCertificates {
    if (_selectedCategory == 'Semua') return _certificates;
    return _certificates
        .where((cert) => cert.category == _selectedCategory)
        .toList();
  }

  String _formatCurrency(double amount) {
    final intVal = amount.toInt();
    final str = intVal.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return 'Rp $buffer';
  }


  void _showCertificatePreview(CertificateModel cert) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        clipBehavior: Clip.antiAlias,
        backgroundColor: AppColors.surfaceContainerLowest,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFCFCF9), // Elegant off-white paper feel
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFD4AF37), width: 2.5), // Gold border
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Modal Close Bar
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, size: 22),
                    onPressed: () => Navigator.pop(context),
                    color: AppColors.onSurfaceVariant,
                    splashRadius: 20,
                  ),
                ),

                // Certificate Frame Content
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      // Header Logo & Institution Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.foundation_rounded,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'YAYASAN KOPIA RAYA INSANI',
                                style: AppStyles.headlineMedium.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                'Lembaga Amil Zakat & Wakaf Produktif',
                                style: AppStyles.labelSmall.copyWith(
                                  fontSize: 10,
                                  color: AppColors.outline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFD4AF37), thickness: 1.5),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        'SERTIFIKAT PENGHARGAAN',
                        textAlign: TextAlign.center,
                        style: AppStyles.headlineLargeMobile.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E3A2B), // Deep emerald
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'No: ${cert.certificateNumber}',
                        style: AppStyles.labelSmall.copyWith(
                          color: AppColors.outline,
                          fontSize: 11,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Diberikan Kepada:',
                        style: AppStyles.bodyMedium.copyWith(
                          fontSize: 12,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Donor Name
                      Text(
                        cert.donorName,
                        textAlign: TextAlign.center,
                        style: AppStyles.headlineLargeMobile.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Appreciation Text
                      Text(
                        cert.description,
                        textAlign: TextAlign.center,
                        style: AppStyles.bodyMedium.copyWith(
                          fontSize: 12,
                          height: 1.5,
                          color: AppColors.onSurface,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Donation Details Container
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceBright.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.surfaceVariant),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nominal Kontribusi',
                                  style: AppStyles.labelSmall.copyWith(
                                    color: AppColors.outline,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _formatCurrency(cert.amount),
                                  style: AppStyles.headlineMedium.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Tanggal Penerbitan',
                                  style: AppStyles.labelSmall.copyWith(
                                    color: AppColors.outline,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  cert.date,
                                  style: AppStyles.bodyMedium.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Stamp & Signature Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Digital QR Seal
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppColors.surfaceVariant),
                                ),
                                child: const Icon(
                                  Icons.qr_code_2_rounded,
                                  size: 44,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Terverifikasi Digital',
                                style: AppStyles.labelSmall.copyWith(
                                  fontSize: 9,
                                  color: AppColors.outline,
                                ),
                              ),
                            ],
                          ),

                          // Signature & Stamp
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Signature graphic mockup
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.verified_rounded,
                                    size: 40,
                                    color: AppColors.primary
                                        .withValues(alpha: 0.15),
                                  ),
                                  Text(
                                    'Ahmad Ridwan',
                                    style: TextStyle(
                                      fontFamily: 'serif',
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                cert.signatoryName,
                                style: AppStyles.bodyMedium.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                cert.signatoryRole,
                                style: AppStyles.labelSmall.copyWith(
                                  fontSize: 10,
                                  color: AppColors.outline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Action Buttons Footer
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Membuka opsi bagikan sertifikat donasi...'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.share_rounded, size: 18),
                        label: const Text('Bagikan'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Mengunduh Sertifikat ${cert.certificateNumber} (PDF)...'),
                              backgroundColor: AppColors.primary,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.download_rounded, size: 18),
                        label: const Text('Unduh PDF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCertificates;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Sertifikat Donasi',
          style: AppStyles.headlineMedium.copyWith(
            color: AppColors.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.onSurface,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Impact Card
          Container(
            margin: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.military_tech_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Apresiasi & Keabsahan',
                        style: AppStyles.labelSmall.copyWith(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${_certificates.length} Sertifikat Terbit',
                        style: AppStyles.headlineMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Terima kasih atas kepedulian Anda',
                        style: AppStyles.bodyMedium.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Filter Categories Horizontal Bar
          SizedBox(
            height: 46,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surfaceContainerLowest,
                  labelStyle: AppStyles.labelMedium.copyWith(
                    color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.surfaceVariant,
                    ),
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    }
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Certificate List View
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          size: 56,
                          color: AppColors.outline.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tidak ada sertifikat dalam kategori ini',
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.outline,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final cert = filtered[index];
                      return _buildCertificateCard(cert);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(CertificateModel cert) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceVariant),
        boxShadow: AppStyles.ambientShadow,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  cert.category,
                  style: AppStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                cert.date,
                style: AppStyles.labelSmall.copyWith(
                  color: AppColors.outline,
                  fontSize: 11,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Title
          Text(
            cert.title,
            style: AppStyles.headlineMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),

          const SizedBox(height: 4),

          // Reg No
          Text(
            'No: ${cert.certificateNumber}',
            style: AppStyles.labelSmall.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.surfaceVariant),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nominal Terverifikasi',
                    style: AppStyles.labelSmall.copyWith(
                      color: AppColors.outline,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatCurrency(cert.amount),
                    style: AppStyles.headlineMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => _showCertificatePreview(cert),
                icon: const Icon(Icons.remove_red_eye_outlined, size: 16),
                label: const Text('Lihat Sertifikat'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
