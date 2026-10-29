class MataKuliah {
  const MataKuliah({
    required this.kode,
    required this.nama,
    required this.sks,
    required this.hari,
    required this.jam,
    required this.ruangan,
    required this.dosen,
    this.semester = 'Ganjil',
    this.tahunAjaran = '2026/2027',
  });

  final String kode;
  final String nama;
  final int sks;
  final String hari;
  final String jam;
  final String ruangan;
  final String dosen;
  final String semester;
  final String tahunAjaran;

  bool get isOnline => ruangan.toLowerCase().contains('online');
}
