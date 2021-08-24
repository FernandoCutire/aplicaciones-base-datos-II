CREATE VIEW VIEW_INGREDIENTES_POR_RECETA
AS select
    r.id_receta, r.nombre_receta, i.nombre_ingrediente, c.cantidad, m.nombre_medida
from
    recetas r, ingredientes i, medidas m,  cantidades c
where c.receta = r.id_receta and c.ingrediente = i.id_ingrediente and c.medida = m.id_umedida;


CREATE VIEW VIEW_RECETAS
AS SELECT
    id_receta, nombre_receta as "Receta", preparacion
FROM
    recetas;

CREATE VIEW VIEW_PLATOS_POR_HORARIO
AS select
    c.combre_cat, t.nombre_plato
from
    categoria c, tipoplatos t
where c.id_cat = t.cod_cat;