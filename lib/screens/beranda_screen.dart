import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/mata_kuliah.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  // Melacak hari mana pada akordeon yang sedang terbuka (null jika tertutup semua)
  String? _expandedDay;

  // Seluruh daftar matkul dari portal E-Learning semester ini
  static const List<MataKuliah> _semuaJadwal = [
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Sistem Informasi Enterprise',
      sks: 3,
      hari: 'Selasa',
      jam: '10:00 - 12:00',
      ruangan: 'Online',
      dosen: 'Dede Sulaeman',
    ),
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Sistem Mikroprosesor',
      sks: 3,
      hari: 'Selasa',
      jam: '16:00 - 18:00',
      ruangan: 'A 402',
      dosen: 'Ari Hadhiwibowo, S.T., M.Kom.',
    ),
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Bahasa Indonesia',
      sks: 2,
      hari: 'Rabu',
      jam: '13:00 - 14:20',
      ruangan: 'Online',
      dosen: 'Haura Zahra Salsabila',
    ),
    MataKuliah(
      kode: 'TIF RM 23B',
      nama: 'Pengembangan Diri',
      sks: 2,
      hari: 'Rabu',
      jam: '19:00 - 20:20',
      ruangan: 'Online',
      dosen: 'Brian Damastu, M.Kom.',
    ),
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Augmented & Virtual Reality',
      sks: 3,
      hari: 'Kamis',
      jam: '10:00 - 12:00',
      ruangan: 'A 404',
      dosen: 'Hendi Suhendi, ST., M.Kom.',
    ),
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Pemrograman Mobile II',
      sks: 3,
      hari: 'Kamis',
      jam: '13:00 - 15:00',
      ruangan: 'A 403',
      dosen: 'Sutani, S.T.',
    ),
    MataKuliah(
      kode: 'TIF PK 23',
      nama: 'Intelegensi Buatan',
      sks: 3,
      hari: 'Kamis',
      jam: '17:00 - 18:30',
      ruangan: 'Online',
      dosen: 'Muhammad Shalahuddin, ST., MT.',
    ),
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Desain Kreatif Aplikasi dan Game',
      sks: 3,
      hari: 'Jumat',
      jam: '10:00 - 12:00',
      ruangan: 'B 204',
      dosen: 'Syarif Hidayat, S.Kom.',
    ),
  ];

  static const List<String> _daftarHari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  @override
  Widget build(BuildContext context) {
    // Mengambil nama hari ini dalam bahasa Indonesia
    final namaHariIni = DateFormat('EEEE', 'id_ID').format(DateTime.now());
    final tanggalLengkap = DateFormat(
      'EEEE, d MMMM y',
      'id_ID',
    ).format(DateTime.now());

    // Filter jadwal khusus hari ini
    final jadwalHariIni = _semuaJadwal
        .where((mk) => mk.hari == namaHariIni)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('KampusKu'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Tanggal
          Text(
            tanggalLengkap,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // SEKSI 1: JADWAL HARI INI (SELALU DI ATAS)
          Card(
            elevation: 3,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Jadwal Kuliah Hari Ini ($namaHariIni)',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  if (jadwalHariIni.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text('Tidak ada jadwal kuliah untuk hari ini.'),
                    )
                  else
                    for (final mk in jadwalHariIni)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildItemMatkul(mk),
                      ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // SEKSI 2: DAFTAR SEMUA HARI (ACCORDION / SINGLE EXPAND)
          Text(
            'Jadwal Berdasarkan Hari',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          for (final hari in _daftarHari) _buildAccordionHari(hari),
        ],
      ),
    );
  }

  // Widget kartu akordeon per hari
  Widget _buildAccordionHari(String hari) {
    final isOpen = _expandedDay == hari;
    final listMatkul = _semuaJadwal.where((mk) => mk.hari == hari).toList();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.calendar_month,
              color: isOpen ? Theme.of(context).colorScheme.primary : null,
            ),
            title: Text(
              hari,
              style: TextStyle(
                fontWeight: isOpen ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            subtitle: Text('${listMatkul.length} Mata Kuliah'),
            trailing: Icon(
              isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            ),
            onTap: () {
              setState(() {
                // Jika hari yang sama ditekan kembali, maka tertutup
                // Jika hari lain ditekan, hari sebelumnya otomatis tertutup
                _expandedDay = isOpen ? null : hari;
              });
            },
          ),
          if (isOpen) ...[
            const Divider(height: 1),
            if (listMatkul.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Tidak ada perkuliahan dijadwalkan.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    for (final mk in listMatkul)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _buildItemMatkul(mk),
                      ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }

  // Tampilan item detail mata kuliah
  Widget _buildItemMatkul(MataKuliah mk) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(child: Text('${mk.sks}')),
        title: Text(
          mk.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14),
                const SizedBox(width: 4),
                Text(mk.jam),
                const SizedBox(width: 12),
                const Icon(Icons.room, size: 14),
                const SizedBox(width: 4),
                Text(mk.ruangan),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.person, size: 14),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(mk.dosen, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
