/*
=================================================
Dekoruma Sofa ETL - Load & Schema

Author: Ryan Farid Pratama

This script creates the target table and loads the cleaned,
web-scraped sofa data (CSV) into a PostgreSQL database.
=================================================
*/

/*
=================================================
Create table and load data
=================================================
*/

-- Create the database to store the scraped data (run once).
-- CREATE DATABASE dekoruma_sofa;

-- Create the main sofa table.
CREATE TABLE sofa (
    id              INTEGER PRIMARY KEY,
    nama_produk     VARCHAR(300),
    harga_produk    INTEGER,
    diskon_produk   INTEGER,
    harga_diskon    INTEGER,
    jumlah_ukuran   INTEGER,
    jumlah_terjual  INTEGER,
    area_pengiriman VARCHAR(300)
);

-- Load the cleaned CSV into the sofa table.
-- NOTE: Update the file path below to match your local machine.
-- NULL '' treats empty CSV fields as NULL, which is required because the
-- numeric columns contain missing values after cleaning.
COPY sofa (
    id,
    nama_produk,
    harga_produk,
    diskon_produk,
    harga_diskon,
    jumlah_ukuran,
    jumlah_terjual,
    area_pengiriman
)
FROM 'dekoruma_sofa.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '');

-- Verify the load.
SELECT * FROM sofa;

/*
=================================================
Normalization
=================================================
*/

-- No further normalization is required: the table is already in 3NF.
-- There is a single primary key (id), and every non-key attribute depends
-- only on id, with no partial or transitive dependencies.
