import 'package:flutter/material.dart';
import '../constans/app_colors.dart';
import '../constans/app_styles.dart';
import '../models/transaction_model.dart';
import '../utils/preference_handler.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String _selectedStatus = 'Semua';
  String _userName = 'Sahabat Kopia';
  List<TransactionModel> _transactions = [];

  final List<String> _statusFilters = [
    'Semua',
    'Berhasil',
    'Diproses',
    'Gagal',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final name = await PreferenceHandler.getUserName();
    if (!mounted) return;
    setState(() {
      _userName = name.isNotEmpty && name != 'Sahabat Kopia' ? name : 'Sahabat Kopia';
      _transactions = TransactionModel.getDummyTransactions();
    });
  }

  List<TransactionModel> get _filteredTransactions {
    if (_selectedStatus == 'Semua') return _transactions;
    return _transactions.where((t) => t.status == _selectedStatus).toList();
  }

  double get _totalSuccessAmount {
    return _transactions
        .where((t) => t.status == 'Berhasil')
        .fold(0, (sum, item) => sum + item.amount);
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Berhasil':
        return const Color(0xFF2E7D32); // Emerald Green
      case 'Diproses':
        return const Color(0xFFED6C02); // Orange Warning
      case 'Gagal':
        return AppColors.error;
      default:
        return AppColors.onSurfaceVariant;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'Berhasil':
        return const Color(0xFFE8F5E9);
      case 'Diproses':
        return const Color(0xFFFFF3E0);
      case 'Gagal':
        return AppColors.errorContainer.withValues(alpha: 0.3);
      default:
        return AppColors.surfaceVariant;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Zakat':
        return Icons.account_balance_wallet_outlined;
      case 'Wakaf':
        return Icons.foundation_outlined;
      case 'Pendidikan':
        return Icons.school_outlined;
      case 'Infak':
      default:
        return Icons.volunteer_activism_outlined;
    }
  }

  void _showReceiptModal(TransactionModel trx) {
    final statusColor = _getStatusColor(trx.status);
    final statusBgColor = _getStatusBgColor(trx.status);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              // Title Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bukti Transaksi Digital',
                    style: AppStyles.headlineMedium.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const Divider(height: 1, color: AppColors.surfaceVariant),
              const SizedBox(height: 16),

              // Receipt Ticket Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceBright.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.surfaceVariant),
                ),
                child: Column(
                  children: [
                    // Status Banner Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            trx.status == 'Berhasil'
                                ? Icons.check_circle_rounded
                                : (trx.status == 'Diproses'
                                    ? Icons.access_time_filled_rounded
                                    : Icons.cancel_rounded),
                            size: 16,
                            color: statusColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Transaksi ${trx.status}',
                            style: AppStyles.labelMedium.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Amount Display
                    Text(
                      _formatCurrency(trx.amount),
                      style: AppStyles.headlineLargeMobile.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      trx.title,
                      textAlign: TextAlign.center,
                      style: AppStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(
                        height: 1,
                        color: AppColors.surfaceVariant,
                        indent: 10,
                        endIndent: 10),
                    const SizedBox(height: 16),

                    // Details Rows
                    _buildReceiptRow('Nomor Transaksi', trx.id),
                    const SizedBox(height: 10),
                    _buildReceiptRow('Atas Nama', _userName),
                    const SizedBox(height: 10),
                    _buildReceiptRow('Waktu Transaksi', trx.date),
                    const SizedBox(height: 10),
                    _buildReceiptRow('Metode Pembayaran', trx.paymentMethod),
                    const SizedBox(height: 10),
                    _buildReceiptRow('Kode Referensi', trx.referenceCode),
                    const SizedBox(height: 10),
                    _buildReceiptRow('Kategori Program', trx.category),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Membuka opsi bagikan resi...'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share_outlined, size: 18),
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
                                'Mengunduh kwitansi ${trx.id} (PDF)...'),
                            backgroundColor: AppColors.primary,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Unduh Kwitansi'),
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
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.labelSmall.copyWith(
            color: AppColors.outline,
            fontSize: 12,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: AppColors.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredTransactions;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Riwayat Transaksi',
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
          // Header Summary Card
          Container(
            margin: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
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
                    Icons.receipt_long_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Terbayar',
                        style: AppStyles.labelSmall.copyWith(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatCurrency(_totalSuccessAmount),
                        style: AppStyles.headlineMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${_transactions.length} Total Transaksi Tercatat',
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

          // Status Filter Horizontal List
          SizedBox(
            height: 46,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _statusFilters.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final status = _statusFilters[index];
                final isSelected = status == _selectedStatus;
                return ChoiceChip(
                  label: Text(status),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surfaceContainerLowest,
                  labelStyle: AppStyles.labelMedium.copyWith(
                    color:
                        isSelected ? Colors.white : AppColors.onSurfaceVariant,
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
                        _selectedStatus = status;
                      });
                    }
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Transactions List
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 56,
                          color: AppColors.outline.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tidak ada transaksi dengan status ini',
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
                    itemCount: filteredList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final trx = filteredList[index];
                      return _buildTransactionCard(trx);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(TransactionModel trx) {
    final statusColor = _getStatusColor(trx.status);
    final statusBgColor = _getStatusBgColor(trx.status);
    final catIcon = _getCategoryIcon(trx.category);

    return InkWell(
      onTap: () => _showReceiptModal(trx),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.surfaceVariant),
          boxShadow: AppStyles.ambientShadow,
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Category Icon Avatar
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(catIcon, color: AppColors.primary, size: 22),
                ),

                const SizedBox(width: 14),

                // Title & Category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trx.title,
                        style: AppStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${trx.date} • ${trx.paymentMethod}',
                        style: AppStyles.labelSmall.copyWith(
                          color: AppColors.outline,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Status Badge Chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    trx.status,
                    style: AppStyles.labelSmall.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.surfaceVariant),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nominal Transaksi',
                  style: AppStyles.labelSmall.copyWith(
                    color: AppColors.outline,
                    fontSize: 11,
                  ),
                ),
                Text(
                  _formatCurrency(trx.amount),
                  style: AppStyles.headlineMedium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: trx.status == 'Berhasil'
                        ? AppColors.primary
                        : AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
