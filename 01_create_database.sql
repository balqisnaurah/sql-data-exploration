-- =============================================
-- Script untuk membuat database toko online
-- dan mengisinya dengan data sampel
-- =============================================

CREATE DATABASE IF NOT EXISTS toko_online;
USE toko_online;

-- Tabel pelanggan
CREATE TABLE pelanggan (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE,
	kota VARCHAR(50),
	tanggal_daftar DATE
);

-- Tabel kategori produk
CREATE TABLE kategori (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_kategori VARCHAR(50) NOT NULL
);

-- Tabel produk
CREATE TABLE produk (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_produk VARCHAR(100) NOT NULL,
	kategori_id INT,
	harga DECIMAL(12, 2),
	stok INT DEFAULT 0,
	FOREIGN KEY (kategori_id) REFERENCES kategori(id)
);

-- Tabel pesanan
CREATE TABLE pesanan (
	id INT PRIMARY KEY AUTO_INCREMENT,
	pelanggan_id INT,
	tanggal_pesanan DATE,
	total DECIMAL(12, 2),
	STATUS ENUM('pending', 'diproses', 'dikirim', 'selesai', 'batal'),
	FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(id)
);

-- Tabel detail pesanan
CREATE TABLE detail_pesanan (
	id INT PRIMARY KEY AUTO_INCREMENT,
	pesanan_id INT,
	produk_id INT,
	jumlah INT,
	harga_satuan DECIMAL(12, 2),
	FOREIGN KEY (pesanan_id) REFERENCES pesanan(id),
	FOREIGN KEY (produk_id) REFERENCES produk(id)
);

-- =============================================
-- INSERT DATA SAMPEL
-- =============================================

INSERT INTO kategori (nama_kategori) VALUES
('Elektronik'), ('Fashion'), ('Makanan'), ('Kesehatan'), ('Olahraga');

INSERT INTO pelanggan (nama, email, kota, tanggal_daftar) VALUES
('Andi Pratama', 'andi@email.com', 'Jakarta', '2024-01-15'),
('Budi Santoso', 'budi@email.com', 'Surabaya', '2024-02-20'),
('Citra Dewi', 'citra@email.com', 'Bandung', '2024-01-10'),
('Dina Amelia', 'dina@email.com', 'Malang', '2024-03-05'),
('Eka Putra', 'eka@email.com', 'Jakarta', '2024-04-12'),
('Fani Rahma', 'fani@email.com', 'Yogyakarta', '2024-02-28'),
('Galih Wicaksono', 'galih@email.com', 'Semarang', '2024-05-01'),
('Hana Safitri', 'hana@email.com', 'Malang', '2024-03-18'),
('Irfan Hakim', 'irfan@email.com', 'Jakarta', '2024-06-10'),
('Jasmine Putri', 'jasmine@email.com', 'Bandung', '2024-04-25');

INSERT INTO produk (nama_produk, kategori_id, harga, stok) VALUES
('Laptop Acer Aspire', 1, 8500000, 25),
('Mouse Wireless', 1, 150000, 100),
('Kaos Polos', 2, 75000, 200),
('Sepatu Running', 5, 450000, 50),
('Vitamin C 1000mg', 4, 85000, 150),
('Mie Instan Box', 3, 95000, 300),
('Headset Bluetooth', 1, 350000, 75),
('Jaket Hoodie', 2, 250000, 80),
('Protein Bar', 3, 35000, 200),
('Yoga Mat', 5, 180000, 60);

INSERT INTO pesanan (pelanggan_id, tanggal_pesanan, total, status) VALUES
(1, '2024-07-01', 8650000, 'selesai'),
(2, '2024-07-02', 525000, 'selesai'),
(3, '2024-07-03', 150000, 'selesai'),
(4, '2024-07-05', 535000, 'dikirim'),
(5, '2024-07-06', 8500000, 'selesai'),
(1, '2024-07-10', 450000, 'selesai'),
(6, '2024-07-12', 330000, 'diproses'),
(7, '2024-07-15', 680000, 'selesai'),
(8, '2024-07-18', 250000, 'batal'),
(3, '2024-07-20', 870000, 'selesai'),
(9, '2024-07-22', 185000, 'pending'),
(10, '2024-07-25', 525000, 'selesai'),
(2, '2024-07-28', 350000, 'dikirim'),
(4, '2024-08-01', 180000, 'selesai'),
(5, '2024-08-03', 700000, 'selesai');

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_satuan) VALUES
(1, 1, 1, 8500000), (1, 2, 1, 150000),
(2, 4, 1, 450000), (2, 3, 1, 75000),
(3, 2, 1, 150000),
(4, 5, 3, 85000), (4, 9, 4, 35000), (4, 6, 1, 95000),
(5, 1, 1, 8500000),
(6, 4, 1, 450000),
(7, 8, 1, 250000), (7, 3, 1, 80000),
(8, 7, 1, 350000), (8, 8, 1, 250000), (8, 10, 1, 180000),
(9, 8, 1, 250000),
(10, 7, 1, 350000), (10, 4, 1, 450000), (10, 9, 2, 35000),
(11, 5, 1, 85000), (11, 6, 1, 95000),
(12, 4, 1, 450000), (12, 3, 1, 75000),
(13, 7, 1, 350000),
(14, 10, 1, 180000),
(15, 7, 1, 350000), (15, 7, 1, 350000);