-- view the tables
SELECT * FROM public.penjualan;
SELECT * FROM public.pelanggan;
SELECT * FROM public.barang;

-- delete null values
delete from public.pelanggan
where id_customer isnull;

-- rename 'nama'
ALTER TABLE public.pelanggan 
RENAME nama TO nama_customer;

-- rename 'lini'
ALTER TABLE public.penjualan 
RENAME lini TO brand;

-- join column 'nama_customer', 'cabang_sales' & 'group' from pelanggan and 'nama_barang' from barang
SELECT DISTINCT
	pn.id_invoice,
	pn.id_distributor,
	pn.tanggal,
    pl.nama_customer,
	b.nama_barang,
	b.kemasan,
    pn.jumlah_barang,
	pn.harga,
	pn.brand,
	pl.cabang_sales,
	pl.group
	INTO tabel_base
FROM public.penjualan AS pn
JOIN public.pelanggan AS pl ON pn.id_customer = pl.id_customer
JOIN public.barang AS b ON pn.id_barang = b.kode_barang
ORDER BY tanggal