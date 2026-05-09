# SQL Data Exploration - Toko Online

Kumpulan query SQL untuk eksplorasi dan analisis data toko online. Meliputi pembuatan database, pengisian data sampel, query analisis dasar hingga lanjut (segmentasi, basket analysis, Pareto).

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

10 query analisis data mencakup berbagai tingkat kompleksitas.

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

### `03_advanced_queries.sql`

7 query lanjutan untuk analisis bisnis yang lebih mendalam.

| No | Query | Konsep SQL |
|----|-------|------------|
| 1 | Segmentasi pelanggan (RFM sederhana) | CASE WHEN, agregasi, segmentasi |
| 2 | Basket analysis (produk yang sering dibeli bersamaan) | Self JOIN, HAVING |
| 3 | Month-over-month growth rate | CTE, LAG window function |
| 4 | Pelanggan yang belum repeat order | LEFT JOIN, HAVING |
| 5 | Pareto analysis (kontribusi revenue per produk) | Window function kumulatif |
| 6 | Average order value per kota | COUNT DISTINCT, agregasi multi-level |
| 7 | Conversion rate (pendaftar vs pembeli) | Subquery, persentase |

---

## Cara Menggunakan

1. Pastikan MySQL sudah terinstall
2. Jalankan `01_create_database.sql` untuk membuat database dan data sampel
3. Jalankan query di `02_analysis_queries.sql` dan `03_advanced_queries.sql` satu per satu

```bash
mysql -u root -p < 01_create_database.sql
mysql -u root -p toko_online < 02_analysis_queries.sql
mysql -u root -p toko_online < 03_advanced_queries.sql
```

---

## Struktur File

```
sql-data-exploration/
├── 01_create_database.sql    # Setup database dan data sampel
├── 02_analysis_queries.sql   # 10 query analisis data dasar
├── 03_advanced_queries.sql   # 7 query lanjutan (segmentasi, Pareto, RFM)
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

Proyek ini dibuat sebagai bagian dari proses belajar SQL untuk data analysis. Query yang dibuat mencakup konsep dasar (SELECT, JOIN, GROUP BY) hingga tingkat lanjut (window function, CTE, segmentasi RFM, Pareto analysis) yang umum digunakan dalam pekerjaan data analyst.
