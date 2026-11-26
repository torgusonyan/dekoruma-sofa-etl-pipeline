

/*
=================================================
Milestone 1

Nama  : Ryan Farid Pratama
Batch : CODA-RMT-023

Program ini dibuat untuk melakukan normalisasi dan memasukkan data mentah csv hasil web scraping ke dalam database
=================================================
*/

/*
=================================================
Pembuatan dan Memindahkan isi Tabel
=================================================
*/

-- Query di bawah ini untuk membuat database untuk menyimpan data film
-- CREATE DATABASE CODA23_M1;

-- Query di bawah ini untuk membuat tabel utama sofa
CREATE TABLE sofa(
	id INTEGER PRIMARY KEY,
	nama_produk VARCHAR(300),
	harga_produk INTEGER,
	diskon_produk INTEGER,
	harga_diskon INTEGER,
	jumlah_ukuran INTEGER,
	jumlah_terjual INTEGER,
	area_pengiriman VARCHAR(300)
	);

-- Query di bawah ini untuk memasukkan data tabel csv ke tabel utama
COPY sofa(
	id,
	nama_produk,
	harga_produk,
	diskon_produk,
	harga_diskon,
	jumlah_ukuran,
	jumlah_terjual,
	area_pengiriman
	)
FROM 'C:\01. CODA_23_TOR\phase0-P0-M1-torgusonyan\dekoruma_sofa.csv'
DELIMITER ','
CSV HEADER;

-- Query di bawah ini untuk cek hasil pembuatan dan memindahkan isi tabel dari csv ke databaase
SELECT * FROM sofa;

/*
=================================================
Normalisasi Data
=================================================
*/

-- Tidak ada proses normalisasi karena tabel sudah dalam bentuk 3NF. Primary Key hanya satu, yaitu id sehingga tidak terdapat dependant key lainnya karena semua bergantung ke id.