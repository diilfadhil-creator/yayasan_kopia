import 'package:flutter/material.dart';
import '../constans/app_colors.dart';
import '../constans/app_styles.dart';
import '../utils/preference_handler.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedCategory = 'Donasi & Zakat';
  bool _isSending = false;

  final List<String> _categories = [
    'Donasi & Zakat',
    'Konfirmasi Pembayaran',
    'Beasiswa & Bantuan',
    'Kemitraan & Kerjasama',
    'Lainnya',
  ];

  final List<Map<String, String>> _faqs = [
    {
      'question': 'Bagaimana cara konfirmasi pembayaran zakat/donasi?',
      'answer':
          'Pembayaran via Virtual Account dan QRIS akan terverifikasi secara otomatis. Jika Anda menggunakan metode transfer manual, Anda dapat mengunggah bukti di menu Riwayat Transaksi atau hubungi WhatsApp Customer Service.',
    },
    {
      'question': 'Apakah donasi saya mendapatkan sertifikat resmi?',
      'answer':
          'Ya, setiap donasi yang telah terverifikasi akan secara otomatis menerbitkan Sertifikat Donasi Digital yang dapat diunduh di menu Sertifikat Donasi pada halaman profil.',
    },
    {
      'question': 'Berapa besaran nisab zakat maal tahun 2026?',
      'answer':
          'Nisab Zakat Maal adalah setara dengan 85 gram emas murni. Anda dapat menggunakan Kalkulator Zakat pada aplikasi kami untuk menghitung kewajiban zakat secara akurat.',
    },
    {
      'question': 'Bagaimana cara mendaftar penerima manfaat beasiswa?',
      'answer':
          'Pendaftaran program Beasiswa Insani dibuka berkala setiap semester. Informasi syarat dan formulir pendaftaran dapat dilihat di tab Program atau tanyakan langsung via WhatsApp.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final name = await PreferenceHandler.getUserName();
    final email = await PreferenceHandler.getUserEmail();
    if (!mounted) return;
    setState(() {
      _nameController.text = name.isNotEmpty && name != 'Sahabat Kopia'
          ? name
          : '';
      _emailController.text = email.isNotEmpty && email != 'sahabat@kopia.or.id'
          ? email
          : '';
    });
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSending = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    ); // Simulate network request

    if (!mounted) return;
    setState(() {
      _isSending = false;
      _messageController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Pesan Anda telah berhasil dikirim! Tim kami akan merespons melalui email.',
        ),
        backgroundColor: AppColors.primary,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showContactActionSnackbar(String channel, String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Menghubungkan ke $channel ($value)...'),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Hubungi Kami',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Support Banner
            _buildHeroBanner(),

            const SizedBox(height: 20),

            // Quick Contact Grid
            Text(
              'Saluran Kontak Cepat',
              style: AppStyles.headlineMedium.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),

            const SizedBox(height: 12),

            _buildContactGrid(),

            const SizedBox(height: 24),

            // Form Send Message
            _buildSendMessageForm(),

            const SizedBox(height: 24),

            // FAQ Accordion Section
            _buildFaqSection(),

            const SizedBox(height: 24),

            // Office Address Card
            _buildOfficeAddressCard(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryContainer],
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
              Icons.support_agent_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Layanan Muzakki & Donatur',
                  style: AppStyles.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Kami siap membantu Anda setiap hari:',
                  style: AppStyles.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Senin - Jumat (08.00 - 17.00 WIB)',
                  style: AppStyles.labelSmall.copyWith(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildContactCard(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'WhatsApp Cs',
                value: '+62 812-1002-0774',
                color: const Color(0xFF25D366),
                onTap: () =>
                    _showContactActionSnackbar('WhatsApp', '+62 812-1002-0774'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildContactCard(
                icon: Icons.phone_in_talk_outlined,
                title: 'Call Center',
                value: '(021) 8899-7766',
                color: AppColors.secondary,
                onTap: () =>
                    _showContactActionSnackbar('Telepon', '(021) 8899-7766'),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12, height: 12),
        Row(
          children: [
            Expanded(
              child: _buildContactCard(
                icon: Icons.email_outlined,
                title: 'Email Support',
                value: 'kopiafoundation22@gmail.com',
                color: AppColors.primary,
                onTap: () => _showContactActionSnackbar(
                  'Email',
                  'kopiafoundation22@gmail.com',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildContactCard(
                icon: Icons.language_rounded,
                title: 'Website Resmi',
                value: 'kopia.id',
                color: AppColors.tertiary,
                onTap: () => _showContactActionSnackbar('Website', 'kopia.id'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceVariant),
          boxShadow: AppStyles.ambientShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: AppStyles.labelSmall.copyWith(
                color: AppColors.outline,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: AppStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: AppColors.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendMessageForm() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceVariant),
        boxShadow: AppStyles.ambientShadow,
      ),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Kirim Pesan / Pertanyaan',
                  style: AppStyles.headlineMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1, color: AppColors.surfaceVariant),
            const SizedBox(height: 16),

            // Dropdown Kategori
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Kategori Topik',
                labelStyle: AppStyles.bodyMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 13,
                ),
                prefixIcon: const Icon(
                  Icons.category_outlined,
                  size: 20,
                  color: AppColors.onSurfaceVariant,
                ),
                filled: true,
                fillColor: AppColors.surfaceBright.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.surfaceVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.surfaceVariant),
                ),
              ),
              items: _categories.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat, style: AppStyles.bodyMedium),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedCategory = val;
                  });
                }
              },
            ),

            const SizedBox(height: 14),

            // Nama Input
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                labelStyle: AppStyles.bodyMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 13,
                ),
                prefixIcon: const Icon(
                  Icons.person_outline,
                  size: 20,
                  color: AppColors.onSurfaceVariant,
                ),
                filled: true,
                fillColor: AppColors.surfaceBright.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.surfaceVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.surfaceVariant),
                ),
              ),
              validator: (val) =>
                  val == null || val.trim().isEmpty ? 'Nama harus diisi' : null,
            ),

            const SizedBox(height: 14),

            // Email Input
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Anda',
                labelStyle: AppStyles.bodyMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 13,
                ),
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  size: 20,
                  color: AppColors.onSurfaceVariant,
                ),
                filled: true,
                fillColor: AppColors.surfaceBright.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.surfaceVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.surfaceVariant),
                ),
              ),
              validator: (val) => val == null || val.trim().isEmpty
                  ? 'Email harus diisi'
                  : null,
            ),

            const SizedBox(height: 14),

            // Pesan Input
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Isi Pesan / Pertanyaan',
                alignLabelWithHint: true,
                labelStyle: AppStyles.bodyMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 13,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Icon(
                    Icons.message_outlined,
                    size: 20,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                filled: true,
                fillColor: AppColors.surfaceBright.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.surfaceVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.surfaceVariant),
                ),
              ),
              validator: (val) => val == null || val.trim().isEmpty
                  ? 'Isi pesan tidak boleh kosong'
                  : null,
            ),

            const SizedBox(height: 18),

            // Tombol Kirim
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isSending ? null : _sendMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isSending
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Kirim Pesan',
                        style: AppStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceVariant),
        boxShadow: AppStyles.ambientShadow,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.help_outline_rounded,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Pertanyaan Sering Diajukan',
                style: AppStyles.headlineMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.surfaceVariant),
          const SizedBox(height: 10),
          ..._faqs.map(
            (faq) => ExpansionTile(
              title: Text(
                faq['question']!,
                style: AppStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppColors.onSurface,
                ),
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  faq['answer']!,
                  style: AppStyles.bodyMedium.copyWith(
                    fontSize: 12,
                    height: 1.5,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficeAddressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceVariant),
        boxShadow: AppStyles.ambientShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.tertiary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Kantor Pusat Yayasan',
                style: AppStyles.headlineMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.surfaceVariant),
          const SizedBox(height: 14),
          Text(
            'Yayasan Kopia Raya Insani',
            style: AppStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Jl. Mampang Prapatan VII, Mampang Prapatan, Jakarta Selatan, DKI Jakarta 12790',
            style: AppStyles.bodyMedium.copyWith(
              fontSize: 13,
              color: AppColors.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
