### Atividade 5 ###
# Selecionar as 5 categorias que mais venderam em cada ano

/* Um dashboard com as 5 categorias mais vendidas de cada ano */

--fazendo os relacionamentos
select categoryname,
	   p.unitprice,
	   od.unitprice,
	   sum(quantity),
	   orderdate
from projeto.products p
inner join projeto.categories c
on p.categoryid = c.categoryid
inner join projeto.orderdetails od 
on p.productid = od.productid
inner join projeto.orders ord
on od.orderid = ord.orderid;


-- fazendo o relatorio dos top5 vendas por ano
with vendas_ano as(
	select categoryname,
		   EXTRACT(YEAR FROM orderdate) as ano,
		   sum(quantity) as quantidade,
		   round(sum(od.unitprice)*sum(quantity),2) as valor
	from projeto.products p
	inner join projeto.categories c
	on p.categoryid = c.categoryid
	inner join projeto.orderdetails od 
	on p.productid = od.productid
	inner join projeto.orders ord
	on od.orderid = ord.orderid
	group by 1,2),
top5 as (
	select *,
	row_number() over (partition by ano order by quantidade desc, valor desc ) as order_quantidade
	from vendas_ano)

select categoryname,
       ano,
       quantidade,
       valor
from top5
where order_quantidade <= 5
order by ano;
