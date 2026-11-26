# Dekoruma Sofa: Web Scraping & Data Preparation ETL

An end-to-end **ETL (Extract, Transform, Load)** pipeline that scrapes sofa
product listings from the [Dekoruma](https://www.dekoruma.com/Sofa) e-commerce
website, cleans and prepares the data with Pandas, and loads the result into a
PostgreSQL database for further analysis.

**Author:** Ryan Farid Pratama
**Tech Stack:** Python · Selenium · BeautifulSoup · Pandas · PostgreSQL · SQL

---

## Pipeline

1. **Extract** — Scrape product data across all catalog pages (33 pages) using
   Selenium to render the dynamic page and BeautifulSoup to parse it. Each field
   is wrapped in a `try/except` so every column stays the same length even when a
   field is missing. Raw output is saved to `dekoruma_raw.csv`.
2. **Transform** — With Pandas: explore the data, drop rows with no product name,
   strip non-numeric characters from the numeric fields, cast them to a nullable
   integer type (`Int64`), add a sequential `id` primary key, and sort by `id`.
   Cleaned output is saved to `dekoruma_sofa.csv`.
3. **Load** — Create the target table and load the cleaned CSV into PostgreSQL
   using `dekoruma_sofa_schema.sql`.

---

## Data Dictionary

The scraped column names are kept in Indonesian to match the source website and
the loaded database table.

<table width="100%">
  <thead>
    <tr>
      <th align="left" width="20%">Column</th>
      <th align="left" width="20%">Type</th>
      <th align="left" width="60%">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr><td><code>id</code></td><td><code>INTEGER</code> (PK)</td><td>Sequential identifier assigned during transformation</td></tr>
    <tr><td><code>nama_produk</code></td><td><code>VARCHAR(300)</code></td><td>Product name</td></tr>
    <tr><td><code>harga_produk</code></td><td><code>INTEGER</code></td><td>Original price (IDR), non-numeric characters stripped</td></tr>
    <tr><td><code>diskon_produk</code></td><td><code>INTEGER</code></td><td>Discount percentage</td></tr>
    <tr><td><code>harga_diskon</code></td><td><code>INTEGER</code></td><td>Discounted price (IDR)</td></tr>
    <tr><td><code>jumlah_ukuran</code></td><td><code>INTEGER</code></td><td>Number of available size variants</td></tr>
    <tr><td><code>jumlah_terjual</code></td><td><code>INTEGER</code></td><td>Units sold</td></tr>
    <tr><td><code>area_pengiriman</code></td><td><code>VARCHAR(300)</code></td><td>Shipping area</td></tr>
  </tbody>
</table>

> Numeric columns are modeled as nullable integers because many listings are
> missing one or more of these values.

---

## Repository Structure

```
.
├── dekoruma_sofa_etl.ipynb      # ETL notebook (Extract → Transform → Load)
├── dekoruma_sofa_schema.sql     # PostgreSQL table creation + CSV load
├── dekoruma_raw.csv             # Raw scraped data (extract output)
├── dekoruma_sofa.csv            # Cleaned data (transform output)
└── README.md
```

---

## Getting Started

### Prerequisites
- Python 3.10+
- Google Chrome + a matching [ChromeDriver](https://chromedriver.chromium.org/)
  (Selenium uses `webdriver.Chrome()`)
- A running PostgreSQL instance
- Python packages:
  ```bash
  pip install beautifulsoup4 selenium pandas
  ```

### Run the pipeline

1. **Extract & Transform** — open `dekoruma_sofa_etl.ipynb` and run the cells top
   to bottom. This scrapes the site, cleans the data, and writes
   `dekoruma_raw.csv` and `dekoruma_sofa.csv`.

2. **Load into PostgreSQL** — update the CSV path in `dekoruma_sofa_schema.sql` to
   match your machine, then run it:
   ```bash
   psql -U your_username -d dekoruma_sofa -f dekoruma_sofa_schema.sql
   ```

---

## Notes

- **Dynamic scraping:** Dekoruma loads products with JavaScript, so Selenium is
  required to render each page before parsing. A 5-second wait per page gives the
  content time to load.
- **Fragile selectors:** the scraper targets auto-generated CSS class names, which
  can change when the website is updated. The selectors may need to be refreshed
  if the site changes.
- **Normalization:** the single table is already in 3NF — one primary key (`id`)
  with every attribute depending only on it — so no further normalization is
  required.
