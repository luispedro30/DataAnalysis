-- (Query 1) Receita, leads (número de visitas por mês), conversão e ticket médio mês a mês
-- Colunas: mês, leads (#), vendas (#), receita (k, R$), conversão (%), ticket médio (k, R$)


select date_trunc('month',visit_page_date::date) as visit_page_month,
count(*) as visit_page_count
from sales.funnel
group by visit_page_month
order by visit_page_month;

select date_trunc('month',paid_date::date) as paid_month,
count(*) as paid_count,
sum(pro.price * (1+fun.discount)) as receita
from sales.funnel as fun
left join sales.products as pro
on  fun.product_id = pro.product_id
group by paid_month
order by paid_month;


-- (Query 2) Estados que mais venderam
-- Colunas: país, estado, vendas (#)


-- (Query 3) Marcas que mais venderam no mês
-- Colunas: marca, vendas (#)


-- (Query 4) Lojas que mais venderam
-- Colunas: loja, vendas (#)


-- (Query 5) Dias da semana com maior número de visitas ao site
-- Colunas: dia_semana, dia da semana, visitas (#)
