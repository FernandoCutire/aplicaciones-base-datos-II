
-- Tabla --
CREATE TABLE cantidades (
    receta      NUMBER NOT NULL,
    ingrediente NUMBER NOT NULL,
    cantidad    NUMBER NOT NULL,
    medida      NUMBER NOT NULL
);

CREATE TABLE categoria (
    id_cat     NUMBER NOT NULL,
    nombre_cat VARCHAR2(45)
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_cat );

CREATE TABLE ingredientes (
    id_ingrediente     NUMBER NOT NULL,
    nombre_ingrediente VARCHAR2(100)
);

ALTER TABLE ingredientes ADD CONSTRAINT ingredientes_pk PRIMARY KEY ( id_ingrediente );

CREATE TABLE medidas (
    id_umedida    NUMBER NOT NULL,
    nombre_medida VARCHAR2(100)
);

ALTER TABLE medidas ADD CONSTRAINT medidas_pk PRIMARY KEY ( id_umedida );

CREATE TABLE recetas (
    id_receta     NUMBER NOT NULL,
    nombre_receta VARCHAR2(100),
    preparacion   VARCHAR2(2500),
    duracion      VARCHAR2(10),
    comentarios   VARCHAR2(2500),
    tipoplato     NUMBER NOT NULL
);

ALTER TABLE recetas ADD CONSTRAINT recetas_pk PRIMARY KEY ( id_receta );

CREATE TABLE tipoplatos (
    id_plato     NUMBER NOT NULL,
    nombre_plato VARCHAR2(45),
    cod_cat      NUMBER NOT NULL
);

ALTER TABLE tipoplatos ADD CONSTRAINT tipoplatos_pk PRIMARY KEY ( id_plato );

ALTER TABLE cantidades
    ADD CONSTRAINT cantidades_ingredientes_fk FOREIGN KEY ( ingrediente )
        REFERENCES ingredientes ( id_ingrediente );

ALTER TABLE cantidades
    ADD CONSTRAINT cantidades_medidas_fk FOREIGN KEY ( medida )
        REFERENCES medidas ( id_umedida );

ALTER TABLE cantidades
    ADD CONSTRAINT cantidades_recetas_fk FOREIGN KEY ( receta )
        REFERENCES recetas ( id_receta );

ALTER TABLE recetas
    ADD CONSTRAINT recetas_tipoplatos_fk FOREIGN KEY ( tipoplato )
        REFERENCES tipoplatos ( id_plato );

ALTER TABLE tipoplatos
    ADD CONSTRAINT tipoplatos_categoria_fk FOREIGN KEY ( cod_cat )
        REFERENCES categoria ( id_cat );


-- Vistas --
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
    c.nombre_cat, t.nombre_plato
from
    categoria c, tipoplatos t
where c.id_cat = t.cod_cat;

-- Indices --
CREATE UNIQUE INDEX INDEX_TIPOSPLATOS ON TIPOPLATOS (NOMBRE_PLATO DESC);

CREATE UNIQUE INDEX INDEX_PLATO_UNICO ON TIPOPLATOS (NOMBRE_PLATO, COD_CAT);



---- INSERT PARA LAS TABLAS---

-- CATEGORIA--
INSERT INTO CATEGORIA VALUES (1, 'desayuno');
INSERT INTO CATEGORIA VALUES (2, 'almuerzo');
INSERT INTO CATEGORIA VALUES (3, 'cena');

-- TIPOPLATOS--
INSERT INTO TIPOPLATOS VALUES (1, 'Huevos revueltos', 1);
INSERT INTO TIPOPLATOS VALUES (2, 'Hojaldra y salchichas guisadas', 1);
INSERT INTO TIPOPLATOS VALUES (3, 'Arroz con pollo', 2);
INSERT INTO TIPOPLATOS VALUES (4, 'Coditos con pollo', 3);

-- INGREDIENTES--
INSERT INTO INGREDIENTES VALUES (1, 'aceite de soja');
INSERT INTO INGREDIENTES VALUES (2, 'aceite de maiz');
INSERT INTO INGREDIENTES VALUES (3, 'aceite de oliva');
INSERT INTO INGREDIENTES VALUES (4, 'leche');
INSERT INTO INGREDIENTES VALUES (5, 'queso mozarella');
INSERT INTO INGREDIENTES VALUES (6, 'queso parmesano');
INSERT INTO INGREDIENTES VALUES (7, 'queso prensado');
INSERT INTO INGREDIENTES VALUES (8, 'mantequilla');
INSERT INTO INGREDIENTES VALUES (9, 'leche');
INSERT INTO INGREDIENTES VALUES (10, 'garbanzos');
INSERT INTO INGREDIENTES VALUES (11, 'guisantes');
INSERT INTO INGREDIENTES VALUES (12, 'lentejas');
INSERT INTO INGREDIENTES VALUES (13, 'patatas');
INSERT INTO INGREDIENTES VALUES (14, 'lechuga');
INSERT INTO INGREDIENTES VALUES (15, 'brocoli');
INSERT INTO INGREDIENTES VALUES (16, 'cebolla');
INSERT INTO INGREDIENTES VALUES (17, 'ajo');
INSERT INTO INGREDIENTES VALUES (18, 'tomate');
INSERT INTO INGREDIENTES VALUES (19, 'zanahoria');
INSERT INTO INGREDIENTES VALUES (20, 'espinaca');
INSERT INTO INGREDIENTES VALUES (21, 'maiz');
INSERT INTO INGREDIENTES VALUES (22, 'remolacha');
INSERT INTO INGREDIENTES VALUES (23, 'pepino');
INSERT INTO INGREDIENTES VALUES (24, 'platano verde');
INSERT INTO INGREDIENTES VALUES (25, 'platano maduro');
INSERT INTO INGREDIENTES VALUES (26, 'pimienta');
INSERT INTO INGREDIENTES VALUES (27, 'sal ');
INSERT INTO INGREDIENTES VALUES (28, 'oregano');
INSERT INTO INGREDIENTES VALUES (29, 'azucar');
INSERT INTO INGREDIENTES VALUES (30, 'albahaca');
INSERT INTO INGREDIENTES VALUES (31, 'arroz');
INSERT INTO INGREDIENTES VALUES (32, 'frijoles rojos');
INSERT INTO INGREDIENTES VALUES (33, 'frijoles negros');
INSERT INTO INGREDIENTES VALUES (34, 'jengibre');
INSERT INTO INGREDIENTES VALUES (35, 'yuca');
INSERT INTO INGREDIENTES VALUES (36, 'otoe');
INSERT INTO INGREDIENTES VALUES (37, 'aguacate');
INSERT INTO INGREDIENTES VALUES (38, 'melon');
INSERT INTO INGREDIENTES VALUES (39, 'pina');
INSERT INTO INGREDIENTES VALUES (40, 'sandia');
INSERT INTO INGREDIENTES VALUES (41, 'naranja');
INSERT INTO INGREDIENTES VALUES (42, 'limon');
INSERT INTO INGREDIENTES VALUES (43, 'harina');
INSERT INTO INGREDIENTES VALUES (44, 'pasta');
INSERT INTO INGREDIENTES VALUES (45, 'atun');
INSERT INTO INGREDIENTES VALUES (46, 'sardina');
INSERT INTO INGREDIENTES VALUES (47, 'camaron');
INSERT INTO INGREDIENTES VALUES (48, 'corvina');
INSERT INTO INGREDIENTES VALUES (49, 'salmon');
INSERT INTO INGREDIENTES VALUES (50, 'pollo');
INSERT INTO INGREDIENTES VALUES (51, 'huevos');
INSERT INTO INGREDIENTES VALUES (52, 'agua');
INSERT INTO INGREDIENTES VALUES (53, 'carne de falda');
INSERT INTO INGREDIENTES VALUES (54, 'perejil');
INSERT INTO INGREDIENTES VALUES (55, 'recao');
INSERT INTO INGREDIENTES VALUES (56, 'jalapeno');
INSERT INTO INGREDIENTES VALUES (57, 'salsa inglesa');
INSERT INTO INGREDIENTES VALUES (58, 'salsa de soja');
INSERT INTO INGREDIENTES VALUES (60, 'salsa de tomate');
INSERT INTO INGREDIENTES VALUES (61, 'mayonesa');
INSERT INTO INGREDIENTES VALUES (62, 'mostaza');
INSERT INTO INGREDIENTES VALUES (63, 'aceite vegetal');
INSERT INTO INGREDIENTES VALUES (64, 'alas de pollo');
INSERT INTO INGREDIENTES VALUES (65, 'pechuga de pollo');
INSERT INTO INGREDIENTES VALUES (66, 'pimenton rojo');
INSERT INTO INGREDIENTES VALUES (67, 'pimenton verde');
INSERT INTO INGREDIENTES VALUES (68, 'pimenton amarillo');
INSERT INTO INGREDIENTES VALUES (69, 'pasta de tomate');
INSERT INTO INGREDIENTES VALUES (70, 'vinagre blanco');
INSERT INTO INGREDIENTES VALUES (71, 'salsa china');
INSERT INTO INGREDIENTES VALUES (72, 'aji');
INSERT INTO INGREDIENTES VALUES (73, 'chile serrano');
INSERT INTO INGREDIENTES VALUES (74, 'cilantro');
INSERT INTO INGREDIENTES VALUES (75, 'aceituna');
INSERT INTO INGREDIENTES VALUES (76, 'cubo de caldo de pollo');
INSERT INTO INGREDIENTES VALUES (77, 'polvo para hornear');
INSERT INTO INGREDIENTES VALUES (78, 'salchicha');
INSERT INTO INGREDIENTES VALUES (79, 'ajo en polvo');
INSERT INTO INGREDIENTES VALUES (80, 'pimienta');
INSERT INTO INGREDIENTES VALUES (81, 'curry');
INSERT INTO INGREDIENTES VALUES (82, 'crema de leche');

-- MEDIDAS--

INSERT INTO MEDIDAS VALUES (1, 'libra ');
INSERT INTO MEDIDAS VALUES (2, 'kilogramo');
INSERT INTO MEDIDAS VALUES (3, 'pizca');
INSERT INTO MEDIDAS VALUES (4, 'taza');
INSERT INTO MEDIDAS VALUES (5, 'onzas');
INSERT INTO MEDIDAS VALUES (6, 'gramos');
INSERT INTO MEDIDAS VALUES (7, 'cucharadas');
INSERT INTO MEDIDAS VALUES (8, 'grados celcius');
INSERT INTO MEDIDAS VALUES (9, 'grados farenhiet');
INSERT INTO MEDIDAS VALUES (10, 'Litros');
INSERT INTO MEDIDAS VALUES (11, 'Mililitros');
INSERT INTO MEDIDAS VALUES (12, 'galon');
INSERT INTO MEDIDAS VALUES (13, 'quartos');
INSERT INTO MEDIDAS VALUES (14, 'slide');
INSERT INTO MEDIDAS VALUES (15, 'unidad');
INSERT INTO MEDIDAS VALUES (16, 'diente');

-- RECETAS--

INSERT INTO RECETAS VALUES (1, 'Huevos revueltos basicos','1. Lo primero que vamos a hacer es romper el huevo en un bol, agregarle sal y el chorrito de leche (hay gente que reemplaza la leche por crema de leche, pueden hacerlo si lo desean).  Vamos a batir bien batido hasta que estos ingredientes estén bien unidos.2. Vamos a llevar una sartén al fuego, y vamos a poner allí, el pedacito de manteca a que se derrita. Como aclaré más arriba, esto también puede hacerse con aceite.3. Una vez derretida la manteca, o bien calentado el aceite, vamos a darle una última batida al huevo y vamos a echarlo en el centro de la sartén.4.Lo que vamos a hacer ahora, es, con una espátula, ir atravesando el huevo desde los bordes hacia el centro, dejando unos segundos (yo cuento 4 o 5) entre pasada y pasada para darle tiempo a que cuaje.5- Una vez que esté cocido, a gusto de ustedes, lo sacan con cuidado y depositan el huevo revuelto en el plato.','4','Es importante que la sartén esté a fuego medio para que se cocine a la perfección.',1);

INSERT INTO RECETAS VALUES (2, 'Huevos revueltos a la mexicana','1.Calienta el aceite en un sartén a fuego medio. Agrega la cebolla, chile y jitomate. Sofríe durante 2 minutos. 
2.Añade los huevos, reduce el fuego a medio-bajo, y cocina, revolviendo constantemente, durante 2 minutos más o hasta que el huevo se haya cuajado. Sazona con sal.','7','Sal al gusto',1);
INSERT INTO RECETAS VALUES (3, 'Hojaldre con salchicha guisada','1. En un bowl echas la harina, el polvo de hornear, la sal, el azúcar, revuelves y luego agregas el agua.
2. Amasas hasta que se integre todo. Si la masa está muy pegajosa le vas agregando harina de a poco o de lo contrario le agregas entonces agua.
3. Sigue amasando muy bien hasta que tengas una masa manejable, suave, lisa y que se pueda estirar.
4. Haces una bola con ella, la guardas en un recipiente tapada y dejas en la nevera toda la noche (hay algunos que sólo lo dejan reposar unas horas).
5. Una vez pase esto agarras una bolita del tamaño de tus dedos y la vas estirando ni muy gruesa ni muy fina y repites hasta que se acabe la masa.
6. Con bastante aceite fríes las hojaldres.
7. Para las salchichas guisada, agregas un poquito de aceite en el sartén, viertes las salchichas dejas un rato.
8. Agregas un poco de agua, la salsa de tomate y Cebolla, ajo en polvo, curry, sal y pimienta, esperas que todo se guise bien y listo. Sírvete con la hojaldre.','30','Para 10 o más personas, los ingredientes de las salchichas pueden ser al gusto, el aceite es para freir las hojaldres y hacer las salchichas',2);
INSERT INTO RECETAS VALUES (4, 'Arroz con pollo panameño','1.Para que el pollo con arroz al estilo panameño tenga bastante sabor, comienza por salpimentar y agregar especias a las piezas de pollo ya limpias. También puedes usar salsa de soya u otros saborizantes.
2.Pica en cuadritos la cebolla y los pimentones verde y rojo.
3.También pica los tomates y el cilantro. Igualmente, ralla o machaca los dientes de ajos.
4.Sofríe hasta dorar las piezas de pollo en unas tres cucharadas de aceite. Esto tomará unos 5 minutos.
5.Luego, agrega la cebolla y los pimentones. Reserva un poco de estos últimos para la cocción final. Revuelve con el pollo.
6.Pasado un minuto, añade los tomates, cilantro y ajo.
7.Cuando los vegetales comiencen a soltar sus jugos, incorpora el achiote.
8.Después de unos 5 minutos, añade el agua. La cantidad de agua dependerá de la cantidad de arroz, ya que el caldo que se produzca será el líquido que usarás para preparar el arroz. Deja hervir por unos 20 minutos. Retira el pollo y reserva el caldo.
9.En las otras tres cucharadas de aceite, sofríe el arroz con la cúrcuma. También puedes sustituir la cúrcuma por más achiote en polvo.
10.Cuando el arroz tome el color de la cúrcuma, vierte el caldo. Asegúrate de que sea la cantidad necesaria para preparar el arroz.
11.También adiciona el resto de los ingredientes: más cilantro, aceitunas, las zanahorias ya hervidas y picadas y guisantes. También los pimentones rojos y verdes que reservaste anteriormente.
12.Mientras el arroz está listo, desmecha todo el pollo. Por cierto, controla la cocción del arroz para que no quede mi muy seco ni muy húmedo.
13.Cuando el arroz esté listo, agrega el pollo y revuelve bien. Sirve caliente.','90','suele acompañarse con ensaladas, plátano pícaro o tajadas de plátano maduro.',3);

INSERT INTO RECETAS VALUES (5, 'Arroz con Pollo Colombiano','1.Coloca el aceite en una olla grande a fuego bajo. Sofríe los tres pimentones picados, el ajo y la cebolla cabezona y revuelve hasta que tomen un color doradito.
2.Agrega las 3 tazas de arroz, lo importante es revolver muy bien.
3.Añade las 5 tazas de agua, las verduras en trocitos, las pechugas de pollo, el cubo de caldo de pollo, el sobre de sazón y la sal al gusto. Revuelve y deja cocinar a fuego medio por aproximadamente 15 minutos o hasta que se seque el arroz.
4.Una vez que el arroz haya absorbido toda el agua tapa la olla y cocina a fuego bajo por 10 a 15 minutos más hasta que el arroz esté suave.','45','Al gusto y servir',3);

INSERT INTO RECETAS VALUES (6, 'Coditos con pollo','1. Asar el pimiento morrón directamente sobre fuego directo dando vueltas con una pinza hasta que estén asados, pero no quemados. Meter en una bolsa de plástico y dejar sudar durante 5 minutos. Retirar la piel quemada del chile con la mano mojada, enjuagándola cada vez que sea necesario. Retirar las semillas y las venas y reservar.
2. Cortar la milanesa de pollo en fajitas delgadas. Salpimentar y reservar.
3. Hervir agua en una olla, agregar la pasta y un poco de sal y dejar cocer entre 8 y 10 minutos, hasta que esté al dente. Escurrir y reservar.
4. Colocar el pimiento morrón asado, la crema, sal y pimienta en el vaso de la licuadora y licuar hasta obtener una mezcla homogénea.
5. Calentar la cucharada de aceite y cuando esté caliente sofreír las fajitas de pollo durante unos minutos o hasta que cambien de color, añadir la salsa de pimiento y la pasta.
6. Revolver bien y retirar del fuego.
7. Servir inmediatamente.','60','Decorar con nueces si desea, sal y pimienta al gusto',4);

-- Cantidades--
INSERT INTO CANTIDADES VALUES( 1,3, 3, 7  );
INSERT INTO CANTIDADES VALUES( 1,51, 2, 15  );
INSERT INTO CANTIDADES VALUES( 1,27, 1, 3  );
INSERT INTO CANTIDADES VALUES( 1,4, 7, 11  );
INSERT INTO CANTIDADES VALUES( 2,3, 1, 7  );
INSERT INTO CANTIDADES VALUES( 2,16, 0.5, 15  );
INSERT INTO CANTIDADES VALUES( 2,18, 0.5, 15  );
INSERT INTO CANTIDADES VALUES( 2,73, 1, 15  );
INSERT INTO CANTIDADES VALUES( 2,51, 2, 15  );
INSERT INTO CANTIDADES VALUES( 2,27, 1, 3  );
INSERT INTO CANTIDADES VALUES( 3,43, 1, 1  );
INSERT INTO CANTIDADES VALUES( 3,52, 1, 4  );
INSERT INTO CANTIDADES VALUES( 3,77, 1, 7  );
INSERT INTO CANTIDADES VALUES( 3,27, 1, 7  );
INSERT INTO CANTIDADES VALUES( 3,29, 2, 7  );
INSERT INTO CANTIDADES VALUES( 3,78, 10, 15  );
INSERT INTO CANTIDADES VALUES( 3,60, 1, 15  );
INSERT INTO CANTIDADES VALUES( 3,16, 1, 15  );
INSERT INTO CANTIDADES VALUES( 3,79, 1, 3  );
INSERT INTO CANTIDADES VALUES( 3,81, 1, 3  );
INSERT INTO CANTIDADES VALUES( 3,80, 1, 3  );
INSERT INTO CANTIDADES VALUES( 3,3, 100, 11  );
INSERT INTO CANTIDADES VALUES( 4,50, 4, 15  );
INSERT INTO CANTIDADES VALUES( 4,66, 1, 15  );
INSERT INTO CANTIDADES VALUES( 4,67, 1, 15  );
INSERT INTO CANTIDADES VALUES( 4,16, 1, 15  );
INSERT INTO CANTIDADES VALUES( 4,18, 2, 15  );
INSERT INTO CANTIDADES VALUES( 4,74, 50, 6  );
INSERT INTO CANTIDADES VALUES( 4,17, 4, 16  );
INSERT INTO CANTIDADES VALUES( 4,31, 2, 4  );
INSERT INTO CANTIDADES VALUES( 4,19, 1, 15  );
INSERT INTO CANTIDADES VALUES( 4,75, 50, 6  );
INSERT INTO CANTIDADES VALUES( 4,11, 50, 6  );
INSERT INTO CANTIDADES VALUES( 5,50, 4, 15  );
INSERT INTO CANTIDADES VALUES( 5,3, 3, 7  );
INSERT INTO CANTIDADES VALUES( 5,66, 1, 15  );
INSERT INTO CANTIDADES VALUES( 5,67, 1, 15  );
INSERT INTO CANTIDADES VALUES( 5,68, 1, 15  );
INSERT INTO CANTIDADES VALUES( 5,17, 1, 16  );
INSERT INTO CANTIDADES VALUES( 5,16, 1, 15  );
INSERT INTO CANTIDADES VALUES( 5,31, 3, 4  );
INSERT INTO CANTIDADES VALUES( 5,52, 5, 4  );
INSERT INTO CANTIDADES VALUES( 5,19, 1, 15  );
INSERT INTO CANTIDADES VALUES( 5,16, 0.5, 15  );
INSERT INTO CANTIDADES VALUES( 5,76, 1, 15  );
INSERT INTO CANTIDADES VALUES( 5,27, 1, 3  );
INSERT INTO CANTIDADES VALUES( 6,3, 1, 7  );
INSERT INTO CANTIDADES VALUES( 6,82, 1, 4  );
INSERT INTO CANTIDADES VALUES( 6,65, 2, 15  );
INSERT INTO CANTIDADES VALUES( 6,69, 200, 6  );
INSERT INTO CANTIDADES VALUES( 6,27, 2, 3  );
INSERT INTO CANTIDADES VALUES( 6,26, 1, 3  );
INSERT INTO CANTIDADES VALUES( 6,66, 1, 15  );
INSERT INTO CANTIDADES VALUES( 6,67, 1, 15  );
INSERT INTO CANTIDADES VALUES( 6,52, 2, 4  );


