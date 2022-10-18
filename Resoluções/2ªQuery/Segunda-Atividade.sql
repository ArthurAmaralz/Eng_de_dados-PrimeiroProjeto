### Atividade2 ###
# Agrupar o valor das vendas dos vendedores no ano de 2022 para analisar o desempenho de um deles 

/* Segundo desafio - performance do vendedor "Robert" no ano passado em comparação com outros vendedores */

select  firstname || " " || lastname as nome_completo,
	salary
from projeto.employees 
where FirstName like 'Robert';


--LINKANDO AS TABELAS EMPREGADO, ORDENS E DETALHES
SELECT  firstname || " " || lastname as Nome_completo,
	ORD.ORDERDATE,
	round(sum(OD.UNITPRICE)) as vendas_dia,
	sum(OD.QUANTITY) as quantidade_dia
FROM projeto.orders as ord
INNER JOIN projeto.employees as E
on ord.employeeid = e.employeeid
inner join projeto.orderdetails as od
on ord.orderid = od.orderid
where FirstName like 'Robert' 
and cast(EXTRACT(YEAR FROM orderdate) as string) = '2022'
group by 1,2
order by 2



-- fazendo o agrupamento comparativo com outros vendedores
SELECT  firstname || " " || lastname as Nome_completo,   
	round(sum(OD.UNITPRICE * OD.QUANTITY),2) as total_vendas
FROM projeto.orders as ord
INNER JOIN projeto.employees as E
on ord.employeeid = e.employeeid
inner join projeto.orderdetails as od
on ord.orderid = od.orderid 
where cast(EXTRACT(YEAR FROM orderdate) as string) = '2022' -- esse funcao foi a alternativa que encontrei para usar no bigquery, mas pode ser usado 'DATE_PART(year, orderdate) = 2022' no postgress ou aws redshift
group by 1
order by 2 desc;
-- outra maneira seria usando o ' sum(od.unitprice) / count(distinct firstname) '
