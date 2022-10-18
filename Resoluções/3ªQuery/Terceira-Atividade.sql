### Atividade 3 ###
/* Os 10 produtos mais caros */


select  productname, 
	unitprice, 
	categoryname
from projeto.products p
inner join projeto.categories c
on p.categoryid = c.categoryid
--where exists (select distinct categoryid from projeto.categories)
order by 2 desc
LIMIT 10;

-- Aumentando a complexidade...Caso quisesse o mais vendido por categoria
with por_categoria as (
  select productname, 
	 unitprice, 
	 categoryname
  from projeto.products p
  inner join projeto.categories c
  on p.categoryid = c.categoryid
  order by 2 desc),
unico as ( 
    select *,
  row_number() over (partition by categoryname order by unitprice desc ) as order_quantidade
  from por_categoria)

select categoryname,
       productname,
       unitprice
from unico
where order_quantidade = 1
order by 3 desc;
-- como só temos 8 categorias, não precisamos de um limit
