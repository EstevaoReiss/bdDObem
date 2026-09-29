USE estudos_rh;
SELECT * FROM regioes; 


SELECT 
 f.pre_nome,
 c.cargo_id,
 c.cargo_desc
FROM funcionarios f
INNER JOIN cargos c
 ON f.cargo = c.cargo_id;


SELECT
    f.sobre_nome,
    d.departamento_nome,
    l.cidade,
    p.pais_nome,
    r.regiao_nome
FROM funcionarios f
INNER JOIN departamentos d
    ON f.departamento_id = d.departamento_id
INNER JOIN locais l
    ON d.local_id = l.local_id
INNER JOIN paises p
    ON l.pais_id = p.pais_id
INNER JOIN regioes r
  ON p.regiao_id = r.regiao_id;    

