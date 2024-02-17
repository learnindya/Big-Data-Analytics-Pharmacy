select * from public.pelanggan;

-- delete null values
delete from public.pelanggan
where id_customer isnull;

-- rename 'nama'
ALTER TABLE public.pelanggan 
RENAME nama TO nama_customer;

-- groupby cabang_sales & group
select cabang_sales, "group",
	count("group") as jumlah_group
from public.pelanggan
group by 1, 2
order by 3 desc

