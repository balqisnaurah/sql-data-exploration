-- =============================================
-- Query Analisis Data Toko Online
-- =============================================

-- 1. Total penjualan per bulan
SELECT
	DATE_FORMAT(tanggal_pesanan, '%Y-%m') AS bulan,
	COUNT(*) AS jumlah_pesanan,
	SUM(total) AS total_penjualan,
	AVG(total) AS rata_rata_pesanan
FROM pesanan
WHERE status != 'batal'
GROUP BY DATE_FORMAT(tanggal_pesanan, '%Y-%m')
ORDER BY bulan;

-- 2. Top 5 pelanggan dengan total pembelian terbesar
SELECT
	p.nama,
	p.kota,
	COUNT(ps.id) AS jumlah_pesanan,
	SUM(ps.total) AS total_pembelian
FROM pelanggan p
JOIN pesanan ps ON p.id = ps.pelanggan_id
WHERE ps.status = 'selesai'
GROUP BY p.id, p.nama, p.kota
ORDER BY total_pembelian DESC
LIMIT 5;

-- 3. Produk terlaris berdasarkan jumlah unit terjual
SELECT
	pr.nama_produk,
	k.nama_kategori,
	SUM(dp.jumlah) AS total_terjual,
	SUM(dp.jumlah * dp.harga_satuan) AS total_pendapatan
FROM detail_pesanan dp
JOIN produk pr ON dp.produk_id = pr.id
JOIN kategori k ON pr.kategori_id = k.id
JOIN pesanan ps ON dp.pesanan_id = ps.id
WHERE ps.status != 'batal'
GROUP BY pr.id, pr.nama_produk, k.nama_kategori
ORDER BY total_terjual DESC;

-- 4. Penjualan per kategori produk
SELECT
	k.nama_kategori,
	COUNT(DISTINCT dp.pesanan_id) AS jumlah_transaksi,
	SUM(dp.jumlah) AS total_unit,
	SUM(dp.jumlah * dp.harga_satuan) AS total_pendapatan
FROM kategori k
JOIN produk pr ON k.id = pr.kategori_id
JOIN detail_pesanan dp ON pr.id = dp.produk_id
JOIN pesanan ps ON dp.pesanan_id = ps.id
WHERE ps.status != 'batal'
GROUP BY k.id, k.nama_kategori
ORDER BY total_pendapatan DESC;

-- 5. Distribusi status pesanan
SELECT
	status,
	COUNT(*) AS jumlah,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM pesanan), 1) AS persentase
FROM pesanan
GROUP BY status
ORDER BY jumlah DESC;

-- 6. Pelanggan per kota
SELECT
	kota,
	COUNT(*) AS jumlah_pelanggan,
	SUM(CASE WHEN p.id IN (SELECT pelanggan_id FROM pesanan) THEN 1 ELSE 0 END) AS yang_pernah_beli
FROM pelanggan p
GROUP BY kota
ORDER BY jumlah_pelanggan DESC;

-- 7. Rata-rata waktu antara pendaftaran dan pesanan pertama
SELECT
	p.nama,
	p.tanggal_daftar,
	MIN(ps.tanggal_pesanan) AS pesanan_pertama,
	DATEDIFF(MIN(ps.tanggal_pesanan), p.tanggal_daftar) AS hari_sampai_beli
FROM pelanggan p
JOIN pesanan ps ON p.id = ps.pelanggan_id
GROUP BY p.id, p.nama, p.tanggal_daftar
ORDER BY hari_sampai_beli;

-- 8. Produk dengan stok rendah (di bawah 60 unit)
SELECT
	pr.nama_produk,
	k.nama_kategori,
	pr.stok,
	pr.harga,
	COALESCE(SUM(dp.jumlah), 0) AS total_terjual
FROM produk pr
JOIN kategori k ON pr.kategori_id = k.id
LEFT JOIN detail_pesanan dp ON pr.id = dp.produk_id
WHERE pr.stok < 60
GROUP BY pr.id, pr.nama_produk, k.nama_kategori, pr.stok, pr.harga
ORDER BY pr.stok ASC;

-- 9. Revenue per minggu (window function)
SELECT
	tanggal_pesanan,
	total,
	SUM(total) OVER (ORDER BY tanggal_pesanan) AS kumulatif_revenue,
	AVG(total) OVER (ORDER BY tanggal_pesanan ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3
FROM pesanan
WHERE status != 'batal'
ORDER BY tanggal_pesanan;

-- 10. Ranking pelanggan bedasarkan total pembelian (window function)
SELECT
	p.nama,
	p.kota,
	SUM(ps.total) AS total_pembelian,
	RANK() OVER (ORDER BY SUM(ps.total) DESC) AS ranking
FROM pelanggan p
JOIN pesanan ps ON p.id = ps.pelanggan_id
WHERE ps.status = 'selesai'
GROUP BY p.id, p.nama, p.kota;