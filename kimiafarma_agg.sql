SELECT * FROM public.tabel_base
limit 10

-- sales by cabang_sales & group
select cabang_sales, "group",
	avg(jumlah_barang * harga) as avg_sales,
	sum(jumlah_barang * harga) as total_sales
	into agg_cabang
from public.tabel_base
group by 1, 2
order by 4 desc

-- sales by cabang_sales, group, brand
select cabang_sales, "group", brand,
	avg(jumlah_barang * harga) as avg_sales,
	sum(jumlah_barang * harga) as total_sales
	into agg_cabang_brand
from public.tabel_base
group by 1, 2, 3
order by 1, 5 desc

--sales by brand
select brand,
	avg(jumlah_barang * harga) as avg_sales,
	sum(jumlah_barang * harga) as total_sales
	into agg_brand
from public.tabel_base
group by 1
order by 3 desc

--groupby month
select
	extract(month from tanggal) as bulan,
  to_char(tanggal, 'Month') as "month",
  nama_customer, cabang_sales, "group", nama_barang, brand, jumlah_barang, harga
  into agg_bulan
from public.tabel_base
order by tanggal

--sales by month
with bybulan as(
select 
  extract(month from tanggal) as bulan,
  tanggal, nama_customer, cabang_sales, "group", nama_barang, brand, jumlah_barang, harga
from public.tabel_base
order by bulan
)
select bulan,
	to_char(to_timestamp (bulan::text, 'MM'), 'TMmon') as "month",
	avg(jumlah_barang * harga) as avg_sales,
	sum(jumlah_barang * harga) as total_sales
	into agg_sales_bulan
from bybulan
group by bulan
order by bulan

--sales by nama_barang
select nama_barang, brand,
	avg(jumlah_barang * harga) as avg_sales,
	sum(jumlah_barang * harga) as total_sales
	into agg_barang
from public.tabel_base
group by 1, 2
order by 3 desc

--sales by jenis_barang
select split_part(nama_barang, ' ', 1) as jenis_barang,
	avg(jumlah_barang * harga) as avg_sales,
	sum(jumlah_barang * harga) as total_sales
	into agg_jenisbarang
from public.tabel_base
group by 1
order by 3 desc

--top 5 jenis_barang per bulan
select split_part(nama_barang, ' ', 1) as jenis_barang,
	avg(jumlah_barang * harga) as avg_sales,
	sum(jumlah_barang * harga) as total_sales
from public.tabel_base
group by 1
order by 3 desc
limit 5;

with b as(
select bulan, "month",
	split_part(nama_barang, ' ', 1) as jenis_barang,
	avg(jumlah_barang * harga) as avg_sales,
	sum(jumlah_barang * harga) as total_sales
from public.agg_bulan
group by 1, 2, 3
order by 1
	)
select *
into agg_jenisbarang_bulan
from b
where jenis_barang in ('AMPICILLIN', 'TRAMADOL', 'PARACETAMOL', 'KLORPROMAZINA', 'AMBROXOL')
