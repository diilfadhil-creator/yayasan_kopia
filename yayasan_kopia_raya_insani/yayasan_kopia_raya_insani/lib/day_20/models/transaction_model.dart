class TransactionModel {
  final String id;
  final String title;
  final String category; // 'Zakat', 'Infak', 'Wakaf', 'Kemanusiaan'
  final double amount;
  final String paymentMethod;
  final String status; // 'Berhasil', 'Diproses', 'Gagal'
  final String date;
  final String referenceCode;

  TransactionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    required this.date,
    required this.referenceCode,
  });

  static List<TransactionModel> getDummyTransactions() {
    return [
      TransactionModel(
        id: 'TRX-20260215-001',
        title: 'Zakat Maal Mal & Profesi',
        category: 'Zakat',
        amount: 1500000,
        paymentMethod: 'BSI Virtual Account',
        status: 'Berhasil',
        date: '15 Feb 2026, 08:30 WIB',
        referenceCode: 'VA-882910482910',
      ),
      TransactionModel(
        id: 'TRX-20260212-004',
        title: 'Donasi Program Beasiswa Yatim',
        category: 'Pendidikan',
        amount: 500000,
        paymentMethod: 'Bank Mandiri (Manual)',
        status: 'Berhasil',
        date: '12 Feb 2026, 14:15 WIB',
        referenceCode: 'MND-771890281203',
      ),
      TransactionModel(
        id: 'TRX-20260210-008',
        title: 'Wakaf Pembangunan Sumur Air Bersih',
        category: 'Wakaf',
        amount: 1000000,
        paymentMethod: 'QRIS Insani',
        status: 'Diproses',
        date: '10 Feb 2026, 19:45 WIB',
        referenceCode: 'QRS-991204810293',
      ),
      TransactionModel(
        id: 'TRX-20260205-012',
        title: 'Sedekah Pangan Tanggap Bencana',
        category: 'Infak',
        amount: 250000,
        paymentMethod: 'GoPay',
        status: 'Berhasil',
        date: '05 Feb 2026, 11:20 WIB',
        referenceCode: 'GPY-554109281048',
      ),
      TransactionModel(
        id: 'TRX-20260128-020',
        title: 'Infak Subuh Berkah',
        category: 'Infak',
        amount: 50000,
        paymentMethod: 'ShopeePay',
        status: 'Gagal',
        date: '28 Jan 2026, 05:10 WIB',
        referenceCode: 'SPY-110294819204',
      ),
      TransactionModel(
        id: 'TRX-20260120-025',
        title: 'Zakat Fitrah RAMADHAN',
        category: 'Zakat',
        amount: 200000,
        paymentMethod: 'BCA Virtual Account',
        status: 'Berhasil',
        date: '20 Jan 2026, 16:40 WIB',
        referenceCode: 'BCA-449102849102',
      ),
    ];
  }
}
