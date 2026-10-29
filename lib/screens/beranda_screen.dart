import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/mata_kuliah.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  // Melacak hari mana pada akordeon yang sedang terbuka
  String? _expandedDay;

  // Jadwal Kuliah Semester Ganjil 2026/2027
  static const List<MataKuliah> _semuaJadwal = [
    // SELASA
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Sistem Informasi Enterprise',
      sks: 3,
      hari: 'Selasa',
      jam: '10:00 - 12:00',
      ruangan: 'Online',
      dosen: 'Dede Sulaeman',
      semester: 'Ganjil',
      tahunAjaran: '2026/2027',
    ),
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Sistem Mikroprosessor',
      sks: 3,
      hari: 'Selasa',
      jam: '16:00 - 18:00',
      ruangan: 'A 402',
      dosen: 'Ari Hadhiwibowo, S.T., M.Kom.',
      semester: 'Ganjil',
      tahunAjaran: '2026/2027',
    ),

    // RABU
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Bahasa Indonesia',
      sks: 2,
      hari: 'Rabu',
      jam: '13:00 - 14:20',
      ruangan: 'Online',
      dosen: 'Haura Zahra Salsabila',
      semester: 'Ganjil',
      tahunAjaran: '2026/2027',
    ),

    // KAMIS
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Pemograman Web I',
      sks: 3,
      hari: 'Kamis',
      jam: '08:00 - 10:00',
      ruangan: 'B 101',
      dosen: 'Deni Heryanto, A.Md.Kom., ST., M.Kom',
      semester: 'Ganjil',
      tahunAjaran: '2026/2027',
    ),
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Augmented & Virtual Reality',
      sks: 3,
      hari: 'Kamis',
      jam: '10:00 - 12:00',
      ruangan: 'A 404',
      dosen: 'Hendi Suhendi, ST., M.Kom.',
      semester: 'Ganjil',
      tahunAjaran: '2026/2027',
    ),
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Pemrograman Mobile II',
      sks: 3,
      hari: 'Kamis',
      jam: '13:00 - 15:00',
      ruangan: 'A 403',
      dosen: 'Sutani, S.T.',
      semester: 'Ganjil',
      tahunAjaran: '2026/2027',
    ),
    MataKuliah(
      kode: 'TIF PK 23',
      nama: 'Intelegensi Buatan',
      sks: 3,
      hari: 'Kamis',
      jam: '17:00 - 18:30',
      ruangan: 'Online',
      dosen: 'Muhammad Shalahuddin, ST., MT.',
      semester: 'Ganjil',
      tahunAjaran: '2026/2027',
    ),

    // JUMAT
    MataKuliah(
      kode: 'TIF RP 24A CID',
      nama: 'Desain Kreatif Aplikasi dan Game',
      sks: 3,
      hari: 'Jumat',
      jam: '10:00 - 12:00',
      ruangan: 'B 204',
      dosen: 'Syarif Hidayat, S.Kom.',
      semester: 'Ganjil',
      tahunAjaran: '2026/2027',
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
  void initState() {
    super.initState();
    // Default buka accordion hari ini jika ada jadwalnya
    final hariIni = DateFormat('EEEE', 'id_ID').format(DateTime.now());
    if (_semuaJadwal.any((mk) => mk.hari == hariIni)) {
      _expandedDay = hariIni;
    }
  }

  IconData _getIconMatkul(String nama) {
    final lower = nama.toLowerCase();
    if (lower.contains('web')) return Icons.code;
    if (lower.contains('mobile')) return Icons.phone_android;
    if (lower.contains('mikroprosesor') || lower.contains('mikroprosessor')) {
      return Icons.memory;
    }
    if (lower.contains('intelegensi') || lower.contains('ai')) {
      return Icons.psychology;
    }
    if (lower.contains('virtual') || lower.contains('augmented') || lower.contains('vr')) {
      return Icons.view_in_ar;
    }
    if (lower.contains('game') || lower.contains('desain')) {
      return Icons.sports_esports;
    }
    if (lower.contains('enterprise') || lower.contains('informasi')) {
      return Icons.dns;
    }
    if (lower.contains('bahasa')) return Icons.auto_stories;
    return Icons.terminal;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final namaHariIni = DateFormat('EEEE', 'id_ID').format(now);
    final tanggalLengkap = DateFormat('EEEE, d MMMM y', 'id_ID').format(now);

    final jadwalHariIni = _semuaJadwal
        .where((mk) => mk.hari == namaHariIni)
        .toList();

    final totalSks = _semuaJadwal.fold<int>(0, (sum, item) => sum + item.sks);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF00E5FF).withValues(alpha: 0.4),
                ),
              ),
              child: const Icon(Icons.terminal, color: Color(0xFF00E5FF), size: 18),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'KampusKu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'TEKNIK INFORMATIKA',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00E5FF).withValues(alpha: 0.8),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF334155)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.school, size: 14, color: Color(0xFF38BDF8)),
                SizedBox(width: 6),
                Text(
                  'Ganjil 26/27',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE2E8F0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // Quick Stats HUD Card (Tech Style)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF101B2E), Color(0xFF0D1627)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF1E2F4D)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.developer_board, size: 15, color: Color(0xFF00E5FF)),
                    const SizedBox(width: 6),
                    Text(
                      tanggalLengkap.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildHudStat(
                        label: 'TOTAL MATKUL',
                        value: '${_semuaJadwal.length}',
                        icon: Icons.layers_outlined,
                        accentColor: const Color(0xFF38BDF8),
                      ),
                    ),
                    Container(width: 1, height: 36, color: const Color(0xFF1E293B)),
                    Expanded(
                      child: _buildHudStat(
                        label: 'BEBAN SKS',
                        value: '$totalSks SKS',
                        icon: Icons.speed,
                        accentColor: const Color(0xFF818CF8),
                      ),
                    ),
                    Container(width: 1, height: 36, color: const Color(0xFF1E293B)),
                    Expanded(
                      child: _buildHudStat(
                        label: 'HARI INI',
                        value: '${jadwalHariIni.length} Matkul',
                        icon: Icons.event_available,
                        accentColor: jadwalHariIni.isNotEmpty
                            ? const Color(0xFF34D399)
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // SEKSI 1: JADWAL HARI INI
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: jadwalHariIni.isNotEmpty
                      ? const Color(0xFF10B981)
                      : const Color(0xFF64748B),
                  boxShadow: jadwalHariIni.isNotEmpty
                      ? [
                          BoxShadow(
                            color: const Color(0xFF10B981).withValues(alpha: 0.6),
                            blurRadius: 8,
                            spreadRadius: 2,
                          )
                        ]
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'JADWAL HARI INI ($namaHariIni)',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                  color: Color(0xFFE2E8F0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          if (jadwalHariIni.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF1F2937),
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2937),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.coffee,
                      color: Color(0xFF94A3B8),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tidak ada perkuliahan hari ini',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE2E8F0),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Sistem santai / waktu ngoding mandiri.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else
            ...jadwalHariIni.map((mk) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildCardMatkul(mk, isHighlight: true),
                )),

          const SizedBox(height: 24),

          // SEKSI 2: DAFTAR SEMUA HARI (ACCORDION)
          Row(
            children: [
              const Icon(Icons.calendar_view_week, size: 16, color: Color(0xFF00E5FF)),
              const SizedBox(width: 8),
              const Text(
                'JADWAL BERDASARKAN HARI',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                  color: Color(0xFFE2E8F0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          for (final hari in _daftarHari)
            _buildAccordionHari(hari, isToday: hari == namaHariIni),
        ],
      ),
    );
  }

  Widget _buildHudStat({
    required String label,
    required String value,
    required IconData icon,
    required Color accentColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: accentColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: accentColor,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // Widget kartu akordeon per hari
  Widget _buildAccordionHari(String hari, {required bool isToday}) {
    final isOpen = _expandedDay == hari;
    final listMatkul = _semuaJadwal.where((mk) => mk.hari == hari).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isOpen ? const Color(0xFF131B2E) : const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isToday
              ? const Color(0xFF00E5FF).withValues(alpha: 0.4)
              : (isOpen ? const Color(0xFF334155) : const Color(0xFF1E293B)),
          width: isToday ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            leading: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: isToday
                    ? const Color(0xFF00E5FF).withValues(alpha: 0.15)
                    : const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.calendar_today,
                size: 16,
                color: isToday ? const Color(0xFF00E5FF) : const Color(0xFF94A3B8),
              ),
            ),
            title: Row(
              children: [
                Text(
                  hari,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isToday ? const Color(0xFF00E5FF) : Colors.white,
                  ),
                ),
                if (isToday) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF00E5FF).withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Text(
                      'HARI INI',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF00E5FF),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            subtitle: Text(
              '${listMatkul.length} Mata Kuliah',
              style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
            ),
            trailing: Icon(
              isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: const Color(0xFF94A3B8),
              size: 20,
            ),
            onTap: () {
              setState(() {
                _expandedDay = isOpen ? null : hari;
              });
            },
          ),
          if (isOpen) ...[
            const Divider(height: 1, color: Color(0xFF1E293B)),
            if (listMatkul.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline, size: 16, color: Colors.white.withValues(alpha: 0.4)),
                    const SizedBox(width: 8),
                    Text(
                      'Tidak ada jadwal kuliah terjadwal',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
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
                        child: _buildCardMatkul(mk, isHighlight: false),
                      ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }

  // Tampilan item kartu detail mata kuliah (Tech Edition)
  Widget _buildCardMatkul(MataKuliah mk, {required bool isHighlight}) {
    final isOnline = mk.isOnline;
    final icon = _getIconMatkul(mk.nama);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isHighlight ? const Color(0xFF142036) : const Color(0xFF0B1322),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlight
              ? const Color(0xFF00E5FF).withValues(alpha: 0.35)
              : const Color(0xFF1F2B44),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris 1: Kode Kelas & Badge Ruangan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Kode Kelas & SKS Pill
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      mk.kode,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFA5B4FC),
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${mk.sks} SKS',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFCBD5E1),
                      ),
                    ),
                  ),
                ],
              ),

              // Ruangan Pill (Online vs Offline/Lab)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isOnline
                      ? const Color(0xFF059669).withValues(alpha: 0.15)
                      : const Color(0xFFD97706).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isOnline
                        ? const Color(0xFF059669).withValues(alpha: 0.4)
                        : const Color(0xFFD97706).withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isOnline ? Icons.videocam_outlined : Icons.meeting_room_outlined,
                      size: 12,
                      color: isOnline
                          ? const Color(0xFF34D399)
                          : const Color(0xFFFBBF24),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      mk.ruangan,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: isOnline
                            ? const Color(0xFF34D399)
                            : const Color(0xFFFBBF24),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Baris 2: Icon Matkul & Nama Matkul
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFF00E5FF), size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mk.nama,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.person_outline, size: 13, color: Color(0xFF94A3B8)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            mk.dosen,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF94A3B8),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Baris 3: Jam Perkuliahan
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF090E1A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF1E293B)),
            ),
            child: Row(
              children: [
                const Icon(Icons.schedule, size: 13, color: Color(0xFF38BDF8)),
                const SizedBox(width: 6),
                Text(
                  mk.jam,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF38BDF8),
                    fontFamily: 'monospace',
                  ),
                ),
                const Spacer(),
                Text(
                  '${mk.hari} • ${mk.semester} ${mk.tahunAjaran}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
