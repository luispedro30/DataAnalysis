--(Query 1) Gênero dos leads
-- Colunas: gênero, leads(#)
 

select ibge.gender as "gênero",
count(*) as "leads(#)"
from sales.customers as cus
left join temp_tables.ibge_genders as ibge
on lower(cus.first_name) = lower(ibge.first_name)
group by "gênero";


-- (Query 2) Status profissional dos leads
-- Colunas: status profissional, leads (%)
select cus.professional_status as "status profissional",
(count(*)::float)/(select count(*) from sales.customers) as "leads(#)"
from sales.customers as cus
group by cus.professional_status
order by cus.professional_status;

-- (Query 3) Faixa etária dos leads
-- Colunas: faixa etária, leads (%)
select 
case 
	when (current_date-cus.birth_date)/365 <20 then '0-20'
	when (current_date-cus.birth_date)/365 <40 then '20-40'
	when (current_date-cus.birth_date)/365 <60 then '40-60'
	when (current_date-cus.birth_date)/365 <80 then '60-80'
	else '80+' end "faixa etária",
(count(*)::float)/(select count(*) from sales.customers) as "leads(#)"
from sales.customers as cus
group by "faixa etária"
order by "leads(#)";



-- (Query 4) Faixa salarial dos leads
-- Colunas: faixa salarial, leads (%), ordem
select 
case 
	when cus.income <5000 then '0-5000'
	when cus.income <10000 then '5000-10000'
	when cus.income <15000 then '10000-15000'
	when cus.income <20000 then '15000-20000'
	else '20000' end "faixa salarial",
(count(*)::float)/(select count(*) from sales.customers) as "leads(#)"
from sales.customers as cus
group by "faixa salarial"
order by "leads(#)";


-- (Query 5) Classificação dos veículos visitados
-- Colunas: classificação do veículo, veículos visitados (#)
-- Regra de negócio: Veículos novos tem até 2 anos e seminovos acima de 2 anos

select * from sales.products;
select 
case 
	when (extract('year' FROM fun.visit_page_date) - pro.model_year::int) <=2 then 'novo'
	else 'seminovos' end as "classificação do veículo",
	count(*) as "veículos visitados (#)" 
from sales.funnel as fun
left join sales.products as pro
	on fun.product_id = pro.product_id
group by "classificação do veículo" ;

select extract("YEAR" FROM current_date);
-- (Query 6) Idade dos veículos visitados
-- Colunas: Idade do veículo, veículos visitados (%), ordem

select 
case 
	when (extract('year' FROM fun.visit_page_date) - pro.model_year::int) <=2 then 'até 2 anos'
	when (extract('year' FROM fun.visit_page_date) - pro.model_year::int) <=4 then 'de 2 a 4 anos'
	when (extract('year' FROM fun.visit_page_date) - pro.model_year::int) <=6 then 'de 4 a 6 anos'
	when (extract('year' FROM fun.visit_page_date) - pro.model_year::int) <=8 then 'de 6 a 8 anos'
	when (extract('year' FROM fun.visit_page_date) - pro.model_year::int) <=10 then 'de 8 a 10 anos'
	else 'acima de 10 anos' end as "Idade do veículo",
	(count(*)::float)/(select count(*) from sales.customers) as "veículos visitados (%)"
from sales.funnel as fun
left join sales.products as pro
	on fun.product_id = pro.product_id
group by "Idade do veículo" ;


-- (Query 7) Veículos mais visitados por marca
-- Colunas: brand, model, visitas (#)

select pro.brand, pro.model, count (*) as "visitas (#)"
from sales.funnel as fun
left join sales.products as pro
	on fun.product_id = pro.product_id
group by pro.brand, pro.model
order by "visitas (#)" desc;
