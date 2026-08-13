class ZakatCalculator {
  // Current Gold price per gram in IDR (Standard reference ~ Rp 1.100.000)
  static const double hargaEmasPerGram = 1100000;
  // Nisab Zakat Maal (85 gram emas)
  static const double nisabEmasGram = 85;
  static double get nisabTahunan => hargaEmasPerGram * nisabEmasGram; // Rp 93.500.000
  static double get nisabBulanan => nisabTahunan / 12; // Rp 7.791.666

  // Calculate Zakat Maal (2.5% if >= nisab)
  static double calculateZakatMaal(double totalHarta) {
    if (totalHarta >= nisabTahunan) {
      return totalHarta * 0.025;
    }
    return 0.0;
  }

  // Calculate Zakat Penghasilan (2.5% if monthly income >= nisabBulanan)
  static double calculateZakatPenghasilan({
    required double penghasilanBulanan,
    double bonusLain = 0,
    double hutangPokokBulanan = 0,
  }) {
    double bersihan = (penghasilanBulanan + bonusLain) - hutangPokokBulanan;
    if (bersihan >= nisabBulanan) {
      return bersihan * 0.025;
    }
    return 0.0;
  }
}
