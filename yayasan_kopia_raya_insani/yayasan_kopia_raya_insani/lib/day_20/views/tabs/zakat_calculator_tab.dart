import 'package:flutter/material.dart';
import '../../constans/app_colors.dart';
import '../../constans/app_styles.dart';
import '../../models/zakat_model.dart';

class ZakatCalculatorTab extends StatefulWidget {
  const ZakatCalculatorTab({super.key});

  @override
  State<ZakatCalculatorTab> createState() => _ZakatCalculatorTabState();
}

class _ZakatCalculatorTabState extends State<ZakatCalculatorTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Zakat Maal Controllers
  final _hartaController = TextEditingController();

  // Zakat Penghasilan Controllers
  final _penghasilanController = TextEditingController();
  final _bonusController = TextEditingController();
  final _hutangController = TextEditingController();

  double _zakatMaalAmount = 0;
  double _zakatPenghasilanAmount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _hartaController.dispose();
    _penghasilanController.dispose();
    _bonusController.dispose();
    _hutangController.dispose();
    super.dispose();
  }

  void _calculateZakatMaal() {
    double harta =
        double.tryParse(_hartaController.text.replaceAll('.', '')) ?? 0;
    setState(() {
      _zakatMaalAmount = ZakatCalculator.calculateZakatMaal(harta);
    });
  }

  void _calculateZakatPenghasilan() {
    double penghasilan =
        double.tryParse(_penghasilanController.text.replaceAll('.', '')) ?? 0;
    double bonus =
        double.tryParse(_bonusController.text.replaceAll('.', '')) ?? 0;
    double hutang =
        double.tryParse(_hutangController.text.replaceAll('.', '')) ?? 0;

    setState(() {
      _zakatPenghasilanAmount = ZakatCalculator.calculateZakatPenghasilan(
        penghasilanBulanan: penghasilan,
        bonusLain: bonus,
        hutangPokokBulanan: hutang,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceBright,
        elevation: 0,
        title: Text(
          'Kalkulator Zakat',
          style: AppStyles.headlineLargeMobile.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: AppStyles.labelMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
          tabs: const [
            Tab(text: 'Zakat Maal'),
            Tab(text: 'Zakat Penghasilan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildZakatMaalView(), _buildZakatPenghasilanView()],
      ),
    );
  }

  Widget _buildZakatMaalView() {
    double harta =
        double.tryParse(_hartaController.text.replaceAll('.', '')) ?? 0;
    bool reachesNisab = harta >= ZakatCalculator.nisabTahunan;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Nisab Zakat Maal setara 85 gr Emas = Rp ${_formatRupiah(ZakatCalculator.nisabTahunan)} / tahun.',
                    style: AppStyles.bodyMedium.copyWith(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Form Card
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
                  'Total Nilai Harta / Aset Simpanan (1 Tahun)',
                  style: AppStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _hartaController,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => _calculateZakatMaal(),
                  decoration: InputDecoration(
                    prefixText: 'Rp ',
                    prefixStyle: AppStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    hintText: '0',
                    filled: true,
                    fillColor: AppColors.surfaceContainerLow,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Divider(),

                const SizedBox(height: 16),

                // Calculation Result
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status Nisab:', style: AppStyles.bodyMedium),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: reachesNisab
                            ? AppColors.tertiaryFixed
                            : AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        reachesNisab ? 'Wajib Zakat' : 'Belum Wajib Zakat',
                        style: AppStyles.labelSmall.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kewajiban Zakat (2.5%)',
                        style: AppStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp ${_formatRupiah(_zakatMaalAmount)}',
                        style: AppStyles.headlineMedium.copyWith(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _zakatMaalAmount > 0
                        ? () {
                            _processZakatPayment(
                              _zakatMaalAmount,
                              'Zakat Maal',
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Bayar Zakat Maal Sekarang',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildZakatPenghasilanView() {
    double totalNetto =
        (double.tryParse(_penghasilanController.text.replaceAll('.', '')) ??
            0) +
        (double.tryParse(_bonusController.text.replaceAll('.', '')) ?? 0) -
        (double.tryParse(_hutangController.text.replaceAll('.', '')) ?? 0);
    bool reachesNisab = totalNetto >= ZakatCalculator.nisabBulanan;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Nisab Zakat Penghasilan = Rp ${_formatRupiah(ZakatCalculator.nisabBulanan)} / bulan.',
                    style: AppStyles.bodyMedium.copyWith(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Form Card
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
                  'Penghasilan per Bulan',
                  style: AppStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _penghasilanController,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => _calculateZakatPenghasilan(),
                  decoration: InputDecoration(
                    prefixText: 'Rp ',
                    prefixStyle: AppStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    hintText: '0',
                    filled: true,
                    fillColor: AppColors.surfaceContainerLow,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Bonus / Pendapatan Lain (Optional)',
                  style: AppStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _bonusController,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => _calculateZakatPenghasilan(),
                  decoration: InputDecoration(
                    prefixText: 'Rp ',
                    prefixStyle: AppStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    hintText: '0',
                    filled: true,
                    fillColor: AppColors.surfaceContainerLow,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Hutang / Cicilan Pokok Bulanan (Optional)',
                  style: AppStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _hutangController,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => _calculateZakatPenghasilan(),
                  decoration: InputDecoration(
                    prefixText: 'Rp ',
                    prefixStyle: AppStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    hintText: '0',
                    filled: true,
                    fillColor: AppColors.surfaceContainerLow,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Divider(),

                const SizedBox(height: 16),

                // Calculation Result
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status Nisab:', style: AppStyles.bodyMedium),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: reachesNisab
                            ? AppColors.tertiaryFixed
                            : AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        reachesNisab ? 'Wajib Zakat' : 'Belum Wajib Zakat',
                        style: AppStyles.labelSmall.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kewajiban Zakat (2.5%)',
                        style: AppStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp ${_formatRupiah(_zakatPenghasilanAmount)}',
                        style: AppStyles.headlineMedium.copyWith(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _zakatPenghasilanAmount > 0
                        ? () {
                            _processZakatPayment(
                              _zakatPenghasilanAmount,
                              'Zakat Penghasilan',
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Bayar Zakat Penghasilan Sekarang',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

  void _processZakatPayment(double amount, String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Alhamdulillah! Pembayaran $type sebesar Rp ${_formatRupiah(amount)} berhasil diproses.',
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  String _formatRupiah(double amount) {
    return amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}
