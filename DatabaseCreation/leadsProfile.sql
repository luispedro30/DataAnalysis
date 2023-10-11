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



-- (Query 3) Faixa etária dos leads
-- Colunas: faixa etária, leads (%)



-- (Query 4) Faixa salarial dos leads
-- Colunas: faixa salarial, leads (%), ordem



-- (Query 5) Classificação dos veículos visitados
-- Colunas: classificação do veículo, veículos visitados (#)
-- Regra de negócio: Veículos novos tem até 2 anos e seminovos acima de 2 anos



-- (Query 6) Idade dos veículos visitados
-- Colunas: Idade do veículo, veículos visitados (%), ordem

