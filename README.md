# SQL Data Exploration - Toko Online

Kumpulan query SQL untuk eksplorasi dan analisis data toko online. Meliputi pembuatan database, pengisian data sampel, dan 10 query analisis mulai dari dasar hingga window function.

---

## Daftar File

### `01_create_database.sql`

Script untuk membuat database toko online beserta data sampel.

**Tabel yang dibuat:**

| Tabel | Deskripsi | Jumlah Data |
|-------|-----------|-------------|
| `pelanggan` | Data pelanggan (nama, email, kota, tanggal daftar) | 10 baris |
| `kategori` | Kategori produk | 5 baris |
| `produk` | Data produk (nama, harga, stok) | 10 baris |
| `pesanan` | Data pesanan (tanggal, total, status) | 15 baris |
| `detail_pesanan` | Detail item per pesanan | 27 baris |

**Relasi antar tabel:**

```
pelanggan --> pesanan --> detail_pesanan <-- produk <-- kategori
```

---

### `02_analysis_queries.sql`

10 query analisis data yang mencakup berbagai tingkat kompleksitas.

**Daftar Query:**

| No | Query | Konsep SQL |
|----|-------|------------|
| 1 | Total penjualan per bulan | GROUP BY, DATE_FORMAT, agregasi |
| 2 | Top 5 pelanggan dengan pembelian terbesar | JOIN, GROUP BY, ORDER BY, LIMIT |
| 3 | Produk terlaris berdasarkan unit terjual | Multi-table JOIN, agregasi |
| 4 | Penjualan per kategori produk | Multi-table JOIN, GROUP BY |
| 5 | Distribusi status pesanan | Subquery, persentase |
| 6 | Pelanggan per kota | CASE WHEN, subquery |
| 7 | Waktu antara pendaftaran dan pesanan pertama | DATEDIFF, MIN, GROUP BY |
| 8 | Produk dengan stok rendah | LEFT JOIN, HAVING, filter |
| 9 | Revenue kumulatif per hari | Window function: SUM OVER, moving average |
| 10 | Ranking pelanggan | Window function: RANK OVER |

---

## Cara Menggunakan

1. Pastikan MySQL sudah terinstall
2. Jalankan `01_create_database.sql` untuk membuat database dan data sampel
3. Jalankan query di `02_analysis_queries.sql` satu per satu untuk melihat hasil analisis

```bash
mysql -u root -p < 01_create_database.sql
mysql -u root -p toko_online < 02_analysis_queries.sql
```

---

## Struktur File

```
sql-data-exploration/
├── 01_create_database.sql    # Setup database dan data sampel
├── 02_analysis_queries.sql   # 10 query analisis data
└── README.md
```

---

## Teknologi yang Digunakan

| Teknologi | Fungsi |
|-----------|--------|
| MySQL | Database management system |
| SQL | Bahasa query untuk manipulasi dan analisis data |

---

## Tentang

Proyek ini dibuat sebagai bagian dari proses belajar SQL untuk data analysis. Query yang dibuat mencakup konsep dasar (SELECT, JOIN, GROUP BY) hingga tingkat lanjut (window function, subquery) yang umum digunakan dalam pekerjaan data analyst.
