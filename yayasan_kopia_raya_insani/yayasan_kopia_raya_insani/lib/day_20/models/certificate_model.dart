class CertificateModel {
  final String id;
  final String title;
  final String category; // 'Zakat', 'Infak', 'Wakaf', 'Pendidikan'
  final String donorName;
  final double amount;
  final String date;
  final String certificateNumber;
  final String description;
  final String signatoryName;
  final String signatoryRole;

  CertificateModel({
    required this.id,
    required this.title,
    required this.category,
    required this.donorName,
    required this.amount,
    required this.date,
    required this.certificateNumber,
    required this.description,
    this.signatoryName = 'Ustadz H. Ahmad Ridwan, M.A.',
    this.signatoryRole = 'Ketua Yayasan Kopia Raya Insani',
  });

  static List<CertificateModel> getDummyCertificates(String currentUserName) {
    final name = currentUserName.isEmpty ? 'Ahmad Fulan' : currentUserName;
    return [
      CertificateModel(
        id: 'CERT-2026-001',
        title: 'Sertifikat Muzakki Setia 2026',
        category: 'Zakat',
        donorName: name,
        amount: 1500000,
        date: '10 Februari 2026',
        certificateNumber: 'YKR/ZKT/2026/02/0014',
        description:
            'Diberikan sebagai bentuk apresiasi dan keabsahan penyaluran Zakat Maal melalui Yayasan Kopia Raya Insani untuk pemberdayaan ummat.',
      ),
      CertificateModel(
        id: 'CERT-2026-002',
        title: 'Donatur Program Beasiswa Insani',
        category: 'Pendidikan',
        donorName: name,
        amount: 750000,
        date: '25 Januari 2026',
        certificateNumber: 'YKR/EDU/2026/01/0089',
        description:
            'Apresiasi setinggi-tingginya atas kepedulian dalam mendanai beasiswa anak yatim dan dhuafa Yayasan Kopia Raya Insani.',
      ),
      CertificateModel(
        id: 'CERT-2025-003',
        title: 'Penaung Wakaf Pembangunan Masjid',
        category: 'Wakaf',
        donorName: name,
        amount: 2500000,
        date: '15 Desember 2025',
        certificateNumber: 'YKR/WKF/2025/12/0312',
        description:
            'Piagam penghargaan atas kontribusi Wakaf Tunai untuk pembangunan Pusat Dakwah & Pemberdayaan Kopia Raya Insani.',
      ),
      CertificateModel(
        id: 'CERT-2025-004',
        title: 'Sedekah Pangan Tanggap Bencana',
        category: 'Infak',
        donorName: name,
        amount: 300000,
        date: '02 November 2025',
        certificateNumber: 'YKR/INF/2025/11/0145',
        description:
            'Penghargaan atas partisipasi aktif dalam program paket sembako tanggap darurat bencana kemanusiaan.',
      ),
    ];
  }
}
