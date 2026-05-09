-- =============================================
-- Query Lanjutan: Segmentasi dan Analisis Bisnis
-- =============================================

-- 1. Segmentasi pelanggan berdasarkan total pembelian (RFM sederhana)
SELECT
    p.nama,
    p.kota,
    COUNT(ps.id) AS frequency,
    SUM(ps.total) AS monetary,
    MAX(ps.tanggal_pesanan) AS last_order,
    CASE
        WHEN SUM(ps.total) >= 5000000 THEN 'High Value'
        WHEN SUM(ps.total) >= 1000000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS segment
FROM pelanggan p
JOIN pesanan ps ON p.id = ps.pelanggan_id
WHERE ps.status = 'selesai'
GROUP BY p.id, p.nama, p.kota
ORDER BY monetary DESC;

-- 2. Analisis basket: produk yang sering dibeli bersamaan
SELECT
    p1.nama_produk AS produk_1,
    p2.nama_produk AS produk_2,
    COUNT(*) AS dibeli_bersamaan
FROM detail_pesanan dp1
JOIN detail_pesanan dp2
    ON dp1.pesanan_id = dp2.pesanan_id
    AND dp1.produk_id < dp2.produk_id
JOIN produk p1 ON dp1.produk_id = p1.id
JOIN produk p2 ON dp2.produk_id = p2.id
GROUP BY p1.nama_produk, p2.nama_produk
HAVING COUNT(*) >= 1
ORDER BY dibeli_bersamaan DESC;

-- 3. Month-over-month growth rate
WITH monthly AS (
    SELECT
        DATE_FORMAT(tanggal_pesanan, '%Y-%m') AS bulan,
        SUM(total) AS revenue
    FROM pesanan
    WHERE status = 'selesai'
    GROUP BY DATE_FORMAT(tanggal_pesanan, '%Y-%m')
)
SELECT
    bulan,
    revenue,
    LAG(revenue) OVER (ORDER BY bulan) AS prev_month,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY bulan))
        / LAG(revenue) OVER (ORDER BY bulan) * 100, 1
    ) AS growth_pct
FROM monthly
ORDER BY bulan;

-- 4. Pelanggan yang belum repeat order
SELECT
    p.nama,
    p.kota,
    p.tanggal_daftar,
    COUNT(ps.id) AS total_pesanan,
    SUM(ps.total) AS total_belanja
FROM pelanggan p
LEFT JOIN pesanan ps ON p.id = ps.pelanggan_id AND ps.status = 'selesai'
GROUP BY p.id, p.nama, p.kota, p.tanggal_daftar
HAVING COUNT(ps.id) <= 1
ORDER BY p.tanggal_daftar;

-- 5. Kontribusi revenue per produk (Pareto analysis)
SELECT
    pr.nama_produk,
    SUM(dp.jumlah * dp.harga_satuan) AS revenue,
    SUM(SUM(dp.jumlah * dp.harga_satuan)) OVER (ORDER BY SUM(dp.jumlah * dp.harga_satuan) DESC) AS kumulatif,
    ROUND(
        SUM(SUM(dp.jumlah * dp.harga_satuan)) OVER (ORDER BY SUM(dp.jumlah * dp.harga_satuan) DESC)
        / SUM(SUM(dp.jumlah * dp.harga_satuan)) OVER () * 100, 1
    ) AS kumulatif_pct
FROM detail_pesanan dp
JOIN produk pr ON dp.produk_id = pr.id
JOIN pesanan ps ON dp.pesanan_id = ps.id
WHERE ps.status = 'selesai'
GROUP BY pr.nama_produk
ORDER BY revenue DESC;

-- 6. Average order value per kota
SELECT
    p.kota,
    COUNT(DISTINCT p.id) AS jumlah_pelanggan,
    COUNT(ps.id) AS total_pesanan,
    SUM(ps.total) AS total_revenue,
    ROUND(AVG(ps.total), 0) AS avg_order_value,
    ROUND(SUM(ps.total) / COUNT(DISTINCT p.id), 0) AS revenue_per_pelanggan
FROM pelanggan p
JOIN pesanan ps ON p.id = ps.pelanggan_id
WHERE ps.status = 'selesai'
GROUP BY p.kota
ORDER BY total_revenue DESC;

-- 7. Conversion rate: pelanggan yang daftar vs yang beli
SELECT
    total_pelanggan,
    pelanggan_beli,
    ROUND(pelanggan_beli * 100.0 / total_pelanggan, 1) AS conversion_rate
FROM (
    SELECT
        (SELECT COUNT(*) FROM pelanggan) AS total_pelanggan,
        (SELECT COUNT(DISTINCT pelanggan_id) FROM pesanan WHERE status = 'selesai') AS pelanggan_beli
) AS stats;