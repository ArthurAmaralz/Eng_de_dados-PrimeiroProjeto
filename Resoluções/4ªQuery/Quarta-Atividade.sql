###  Atividade 4 ###

#Mostar a quantidade de vendas total por fornecedor nos anos de 2021 e 2020 
# me posteriormente a diferença entre o total de vendas desses anos 
/* relatorio de vendas mostrando a diferença dos ultimos 2 anos por fornecedor */

-- primeiro criando a query e relacões principais
select companyname, 
       p.unitprice, 
	   od.unitprice, 
	   quantity, 
	   ord.orderdate
from projeto.products p
inner join projeto.suppliers s 
on p.supplierid = s.supplierid
inner join projeto.orderdetails od
on p.productid = od.productid
inner join projeto.orders ord
on od.orderid = ord.orderid;


-- segundo fazendo os agrupamentos dos anos de 2020 e 2021, onde por final foi retirado um relatorio da diferença em quantidade e valor de vendas
with valor_2020 as (
	select companyname,
           sum(quantity) as quantidade_2020,
		   round(sum(od.unitprice)*sum(quantity),2) as valor_2020
	from projeto.products p
	inner join projeto.suppliers s 
	on p.supplierid = s.supplierid
	inner join projeto.orderdetails od
	on p.productid = od.productid
	inner join projeto.orders ord
	on od.orderid = ord.orderid
	where cast(EXTRACT(YEAR FROM orderdate) as string) = '2020'
	group by 1
	),
valor_2021 as (
	select companyname,
           sum(quantity) as quantidade_2021,  
		   round(sum(od.unitprice)*sum(quantity),2) as valor_2021
	from projeto.products p
	inner join projeto.suppliers s 
	on p.supplierid = s.supplierid
	inner join projeto.orderdetails od
	on p.productid = od.productid
	inner join projeto.orders ord
	on od.orderid = ord.orderid
	where cast(EXTRACT(YEAR FROM orderdate) as string) = '2021'
	group by 1
	),
relatorio as (
	select t1.companyname,
		   t1.quantidade_2020,
		   t1.valor_2020,
		   t2.quantidade_2021,
		   t2.valor_2021,
		   t2.quantidade_2021 - t1.quantidade_2020 as quantitativo_2021_2020,
		   t2.valor_2021 - t1.valor_2020 as relatorio_vendas_2021_2020
	from valor_2020 as t1

	inner join valor_2021 as t2
	on t1.companyname = t2.companyname)

select * from relatorio

order by relatorio_vendas_2021_2020 desc;
