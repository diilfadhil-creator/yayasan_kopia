class ProgramModel {
  final String id;
  final String title;
  final String category; // 'Zakat', 'Infaq', 'Qurban', 'Emergency'
  final String imageUrl;
  final double targetAmount;
  final double collectedAmount;
  final int totalDonors;
  final int daysRemaining;
  final String description;

  ProgramModel({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.targetAmount,
    required this.collectedAmount,
    required this.totalDonors,
    required this.daysRemaining,
    required this.description,
  });

  double get progressPercentage {
    if (targetAmount <= 0) return 0.0;
    return (collectedAmount / targetAmount).clamp(0.0, 1.0);
  }
}

// Sample Data for Kopia Raya Insani Programs
final List<ProgramModel> samplePrograms = [
  ProgramModel(
    id: '1',
    title: 'Sedekah Subuh Berkah untuk Anak Yatim',
    category: 'Infaq',
    imageUrl: 'assets/images/amal.jpg',
    targetAmount: 50000000,
    collectedAmount: 37500000,
    totalDonors: 320,
    daysRemaining: 12,
    description:
        'Bantu mencukupi kebutuhan pendidikan dan pangan santri & anak yatim piatu binaan Yayasan Kopia Raya Insani.',
  ),
  ProgramModel(
    id: '2',
    title: 'Zakat Fitrah & Maal Kopia Peduli',
    category: 'Zakat',
    imageUrl: 'assets/images/zakat.png',
    targetAmount: 100000000,
    collectedAmount: 82400000,
    totalDonors: 195,
    daysRemaining: 25,
    description:
        'Salurkan zakat fitrah & maal Anda secara tepat sasaran kepada 8 asnaf berhak penerima manfaat.',
  ),
  ProgramModel(
    id: '3',
    title: 'Mari Tebar Qurban Bersama Kopia Raya Insani',
    category: 'Qurban',
    imageUrl: 'assets/images/qurban.jpg',
    targetAmount: 75000000,
    collectedAmount: 48000000,
    totalDonors: 88,
    daysRemaining: 18,
    description:
        'Tebar kebahagiaan daging qurban ke pelosok desa dan kawasan pra-sejahtera binaan.',
  ),
  ProgramModel(
    id: '4',
    title: 'Pelatihan Microsoft Office & Skill Kerja Gratis',
    category: 'Emergency',
    imageUrl: 'assets/images/pelatihan.jpg',
    targetAmount: 30000000,
    collectedAmount: 26500000,
    totalDonors: 142,
    daysRemaining: 5,
    description:
        'Program beasiswa pelatihan ketrampilan digital bersertifikat untuk pemuda dan pencari kerja.',
  ),
];
