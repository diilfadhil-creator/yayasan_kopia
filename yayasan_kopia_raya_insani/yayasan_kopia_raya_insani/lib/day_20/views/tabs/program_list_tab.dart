import 'package:flutter/material.dart';
import '../../constans/app_colors.dart';
import '../../constans/app_styles.dart';
import '../../models/program_model.dart';

class ProgramListTab extends StatefulWidget {
  const ProgramListTab({super.key});

  @override
  State<ProgramListTab> createState() => _ProgramListTabState();
}

class _ProgramListTabState extends State<ProgramListTab> {
  String _selectedCategory = 'Semua';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  final List<String> _categories = ['Semua', 'Zakat', 'Infaq', 'Qurban', 'Emergency'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ProgramModel> get _filteredPrograms {
    return samplePrograms.where((program) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          program.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = program.title
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _showDonationModal(BuildContext context, ProgramModel program) {
    double amount = 50000;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Donasi Program',
                    style: AppStyles.headlineMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    program.title,
                    style: AppStyles.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Pilih Nominal Donasi',
                    style: AppStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [20000, 50000, 100000, 250000, 500000].map((val) {
                      final isSelected = amount == val.toDouble();
                      return ChoiceChip(
                        label: Text('Rp ${_formatRupiah(val.toDouble())}'),
                        selected: isSelected,
                        selectedColor: AppColors.primaryContainer,
                        backgroundColor: AppColors.surfaceContainerLow,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppColors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            setModalState(() {
                              amount = val.toDouble();
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Alhamdulillah! Donasi sebesar Rp ${_formatRupiah(amount)} berhasil disalurkan.'),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Lanjutkan Pembayaran (Rp ${_formatRupiah(amount)})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Bar & Search
        Container(
          color: AppColors.surfaceBright,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daftar Program',
                style: AppStyles.headlineLargeMobile.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Pilih program kebaikan dan tebar manfaat',
                style: AppStyles.bodyMedium,
              ),
              const SizedBox(height: 16),
              // Search Input
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari program kebaikan...',
                  hintStyle: AppStyles.bodyMedium.copyWith(
                    color: AppColors.outlineVariant,
                  ),
                  prefixIcon:
                      const Icon(Icons.search_rounded, color: AppColors.outline),
                  filled: true,
                  fillColor: AppColors.surfaceContainerLow,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Category Filter Bar
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    final isSelected = _selectedCategory == cat;
                    return ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.surfaceContainerLow,
                      labelStyle: AppStyles.labelMedium.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.onSurfaceVariant,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedCategory = cat;
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Programs List
        Expanded(
          child: _filteredPrograms.isEmpty
              ? Center(
                  child: Text(
                    'Program tidak ditemukan',
                    style: AppStyles.bodyMedium,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: _filteredPrograms.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final program = _filteredPrograms[index];
                    return _buildProgramCard(context, program);
                  },
                ),
        ),
      ],
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
          program.imageUrl.startsWith('http')
              ? Image.network(
                  program.imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160,
                    color: AppColors.secondaryContainer,
                    child: const Center(
                      child: Icon(Icons.image_not_supported_rounded,
                          size: 48, color: AppColors.secondary),
                    ),
                  ),
                )
              : Image.asset(
                  program.imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 160,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
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
                    Row(
                      children: [
                        const Icon(Icons.people_outline_rounded,
                            size: 16, color: AppColors.outline),
                        const SizedBox(width: 4),
                        Text(
                          '${program.totalDonors} Donatur',
                          style: AppStyles.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  program.title,
                  style: AppStyles.headlineMedium.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  program.description,
                  style: AppStyles.bodyMedium.copyWith(fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Terkumpul', style: AppStyles.labelSmall),
                        Text(
                          'Rp ${_formatRupiah(program.collectedAmount)}',
                          style: AppStyles.labelMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => _showDonationModal(context, program),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Donasi'),
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
