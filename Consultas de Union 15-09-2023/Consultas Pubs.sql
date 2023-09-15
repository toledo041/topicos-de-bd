Use Pubs

--FULL JOIN PUBS

-- Muestra el nombre de cada autor y el t�tulo de sus libros (incluso si algunos autores no tienen libros).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, COALESCE(T.title, 'Sin Libros') AS TituloLibro
FROM authors A
FULL JOIN titleauthor TA ON A.au_id = TA.au_id
FULL JOIN titles T ON TA.title_id = T.title_id;

-- Muestra el nombre de cada editor y el t�tulo de los libros que han publicado (incluso si algunos editores no tienen libros publicados).
SELECT P.pub_name AS NombreEditor, COALESCE(T.title, 'Sin Libros Publicados') AS TituloLibro
FROM publishers P
FULL JOIN titles T ON P.pub_id = T.pub_id; 

-- Muestra el nombre de cada empleado de ventas y el nombre de los t�tulos que han vendido (incluso si algunos empleados no han vendido t�tulos).
SELECT E.emp_id AS IDEmpleado, E.fname AS NombreEmpleado, E.lname AS ApellidoEmpleado, COALESCE(T.title, 'Sin Ventas') AS TituloVendido
FROM employee E
FULL JOIN sales S ON E.emp_id = S.stor_id
FULL JOIN titles T ON S.title_id = T.title_id;

-- Muestra el nombre de cada t�tulo y el nombre de los autores que lo han escrito (incluso si algunos t�tulos no tienen autores).
SELECT T.title AS Titulo, COALESCE(A.au_fname, 'Sin Autores') AS NombreAutor, COALESCE(A.au_lname, 'Sin Autores') AS ApellidoAutor
FROM titles T
FULL JOIN titleauthor TA ON T.title_id = TA.title_id
FULL JOIN authors A ON TA.au_id = A.au_id;

-- Muestra el nombre de cada autor y el t�tulo de los libros que han escrito (incluso si algunos autores no tienen libros).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, COALESCE(T.title, 'Sin Libros') AS TituloLibro
FROM authors A
FULL JOIN titleauthor TA ON A.au_id = TA.au_id
FULL JOIN titles T ON TA.title_id = T.title_id;



-- Muestra el nombre de cada editor y la cantidad total de libros publicados por cada uno (incluso si algunos editores no han publicado libros).
SELECT P.pub_name AS NombreEditor, COALESCE(COUNT(T.title_id), 0) AS TotalLibrosPublicados
FROM publishers P
FULL JOIN titles T ON P.pub_id = T.pub_id
GROUP BY P.pub_name;

-- Muestra el nombre de cada t�tulo y la cantidad de ejemplares vendidos (incluso si algunos t�tulos no se han vendido).
SELECT T.title AS TituloLibro, COALESCE(SUM(S.qty), 0) AS CantidadVendida
FROM titles T
FULL JOIN sales S ON T.title_id = S.title_id
GROUP BY T.title;

-- Muestra el nombre de cada empleado de ventas y la cantidad total de t�tulos vendidos (incluso si algunos empleados no han vendido t�tulos).
SELECT E.emp_id AS IDEmpleado, E.fname AS NombreEmpleado, E.lname AS ApellidoEmpleado, COALESCE(SUM(S.qty), 0) AS TotalTitulosVendidos
FROM employee E
FULL JOIN sales S ON E.emp_id = S.stor_id
GROUP BY E.emp_id, E.fname, E.lname;

-- Muestra el nombre de cada empleado y el nombre de los t�tulos que han vendido (incluso si algunos empleados no han vendido t�tulos).
SELECT E.emp_id AS IDEmpleado, E.fname AS NombreEmpleado, E.lname AS ApellidoEmpleado, COALESCE(T.title, 'Sin Ventas') AS TituloVendido
FROM employee E
FULL JOIN sales S ON E.emp_id = S.Stor_id
FULL JOIN titles T ON S.title_id = T.title_id; AS CopiasPrimeraEdicionVendidas
FROM titles T
LEFT JOIN sales S ON T.title_id = S.title_id
WHERE T.type = 'first edition'
GROUP BY T.title;


-- Muestra el nombre de cada autor y el n�mero de libros que han escrito (incluso si algunos autores no han escrito libros).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, COUNT(T.title_id) AS TotalLibrosEscritos
FROM authors A
FULL JOIN titleauthor TA ON A.au_id = TA.au_id
FULL JOIN titles T ON TA.title_id = T.title_id
GROUP BY A.au_fname, A.au_lname;

-- Muestra el nombre de cada editor y la cantidad total de copias vendidas de los libros que han publicado (incluso si algunos editores no han publicado libros).
SELECT P.pub_name AS NombreEditor, COALESCE(SUM(S.qty), 0) AS TotalCopiasVendidas
FROM publishers P
FULL JOIN titles T ON P.pub_id = T.pub_id
FULL JOIN sales S ON T.title_id = S.title_id
GROUP BY P.pub_name;

-- Muestra el nombre de cada empleado y el n�mero total de t�tulos que han vendido (incluso si algunos empleados no han vendido t�tulos).
SELECT E.emp_id AS IDEmpleado, E.fname AS NombreEmpleado, E.lname AS ApellidoEmpleado, COALESCE(COUNT(S.title_id), 0) AS TotalTitulosVendidos
FROM employee E
 FULL JOIN sales S ON E.emp_id = S.stor_id
GROUP BY E.emp_id, E.fname, E.lname;

-- Muestra el nombre de cada t�tulo y la cantidad total de copias vendidas (incluso si algunos t�tulos no se han vendido).
SELECT T.title AS TituloLibro, COALESCE(SUM(S.qty), 0) AS CantidadTotalCopiasVendidas
FROM titles T
FULL  JOIN sales S ON T.title_id = S.title_id
GROUP BY T.title;

-- Muestra el nombre de cada autor y la cantidad total de ejemplares vendidos de sus libros (incluso si algunos autores no han vendido libros).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, COALESCE(SUM(S.qty), 0) AS TotalEjemplaresVendidos
FROM authors A
FULL JOIN titleauthor TA ON A.au_id = TA.au_id
FULL JOIN titles T ON TA.title_id = T.title_id
FULL JOIN sales S ON T.title_id = S.title_id
GROUP BY A.au_fname, A.au_lname;

-- Muestra el id empleado, nombre de cada empleado de ventas y la cantidad total de copias vendidas de los libros que han vendido (incluso si algunos empleados no han vendido t�tulos).
SELECT E.emp_id AS IDEmpleado, E.fname AS NombreEmpleado, E.lname AS ApellidoEmpleado, COALESCE(SUM(S.qty), 0) AS TotalCopiasVendidas
FROM employee E
FULL JOIN sales S ON E.emp_id = S.stor_id
FULL JOIN titles T ON S.title_id = T.title_id
GROUP BY E.emp_id, E.fname, E.lname;

-- Muestra el nombre de cada t�tulo y el nombre de los autores que lo han escrito (incluso si algunos t�tulos no tienen autores).
SELECT T.title AS TituloLibro, COALESCE(AU.au_fname, 'Sin Autores') AS NombreAutor, COALESCE(AU.au_lname, 'Sin Autores') AS ApellidoAutor
FROM titles T
FULL JOIN titleauthor TA ON T.title_id = TA.title_id
FULL JOIN authors AU ON TA.au_id = AU.au_id;

-- Muestra el nombre de cada autor y la cantidad total de libros publicados (incluso si algunos autores no han publicado libros).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, COALESCE(COUNT(TA.title_id), 0) AS TotalLibrosPublicados
FROM authors A
FULL JOIN titleauthor TA ON A.au_id = TA.au_id
GROUP BY A.au_fname, A.au_lname;


-- Muestra el nombre de cada t�tulo y la cantidad total de copias no vendidas (incluso si algunos t�tulos no tienen copias no vendidas).
SELECT T.title AS TituloLibro, COALESCE((T.ytd_sales - SUM(S.qty)), T.ytd_sales) AS CopiasNoVendidas
FROM titles T
FULL JOIN sales S ON T.title_id = S.title_id
GROUP BY T.title, T.ytd_sales;

-- Consultas adicionales sin enumerar para la base de datos "Pubs" --

-- Muestra el nombre de cada autor y el n�mero de libros que han escrito (incluso si algunos autores no han escrito libros).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, COUNT(T.title_id) AS TotalLibrosEscritos
FROM authors A
full  JOIN titleauthor TA ON A.au_id = TA.au_id
full JOIN titles T ON TA.title_id = T.title_id
GROUP BY A.au_fname, A.au_lname;

-- Muestra el nombre de cada editor y la cantidad total de copias vendidas de los libros que han publicado (incluso si algunos editores no han publicado libros).
SELECT P.pub_name AS NombreEditor, COALESCE(SUM(S.qty), 0) AS TotalCopiasVendidas
FROM publishers P
FULL  JOIN titles T ON P.pub_id = T.pub_id
FULL JOIN sales S ON T.title_id = S.title_id
GROUP BY P.pub_name;

-- Muestra el nombre de cada empleado y el n�mero total de t�tulos que han vendido (incluso si algunos empleados no han vendido t�tulos).
SELECT E.emp_id AS IDEmpleado, E.fname AS NombreEmpleado, E.lname AS ApellidoEmpleado, COALESCE(COUNT(S.title_id), 0) AS TotalTitulosVendidos
FROM employee E
FULL JOIN sales S ON E.emp_id = S.stor_id
GROUP BY E.emp_id, E.fname, E.lname;

-- Muestra el nombre de cada t�tulo y la cantidad total de copias vendidas (incluso si algunos t�tulos no se han vendido).
SELECT T.title AS TituloLibro, COALESCE(SUM(S.qty), 0) AS CantidadTotalCopiasVendidas
FROM titles T
FULL JOIN sales S ON T.title_id = S.title_id
GROUP BY T.title;

-- Muestra el nombre de cada autor y la cantidad total de ejemplares vendidos de sus libros (incluso si algunos autores no han vendido libros).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, COALESCE(SUM(S.qty), 0) AS TotalEjemplaresVendidos
FROM authors A
FULL JOIN titleauthor TA ON A.au_id = TA.au_id
FULL JOIN titles T ON TA.title_id = T.title_id
FULL JOIN sales S ON T.title_id = S.title_id
GROUP BY A.au_fname, A.au_lname;


-- Muestra el nombre de cada t�tulo y el nombre de los autores que lo han escrito (incluso si algunos t�tulos no tienen autores).
SELECT T.title AS TituloLibro, COALESCE(AU.au_fname, 'Sin Autores') AS NombreAutor, COALESCE(AU.au_lname, 'Sin Autores') AS ApellidoAutor
FROM titles T
FULL JOIN titleauthor TA ON T.title_id = TA.title_id
FULL JOIN authors AU ON TA.au_id = AU.au_id;

-- Muestra el nombre de cada autor y la cantidad total de libros publicados (incluso si algunos autores no han publicado libros).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, COALESCE(COUNT(TA.title_id), 0) AS TotalLibrosPublicados
FROM authors A
full JOIN titleauthor TA ON A.au_id = TA.au_id
GROUP BY A.au_fname, A.au_lname;



-- Muestra el nombre de cada autor y la cantidad total de libros publicados en cada ciudad (incluso si algunos autores no han publicado en ciertas ciudades).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, COALESCE(P.city, 'Sin Ciudad') AS Ciudad, COALESCE(COUNT(TA.title_id), 0) AS LibrosPublicadosEnCiudad
FROM authors A
FULL  JOIN titleauthor TA ON A.au_id = TA.au_id
FULL   JOIN titles T ON TA.title_id = T.title_id
FULL   JOIN publishers PU ON T.pub_id = PU.pub_id
FULL   JOIN publishers P ON PU.pub_id = P.pub_id
GROUP BY A.au_fname, A.au_lname, P.city;

-- Muestra el nombre de cada t�tulo y la cantidad total de copias vendidas en cada g�nero (incluso si algunos t�tulos no se han vendido en un g�nero).
SELECT T.title AS TituloLibro, G.type AS Genero, COALESCE(SUM(S.qty), 0) AS CopiasVendidasEnGenero
FROM titles T
FULL JOIN roysched RS ON T.title_id = RS.title_id
FULL JOIN titles G ON RS.title_id = G.title_id
FULL JOIN sales S ON T.title_id = S.title_id
GROUP BY T.title, G.type;

-- Muestra el nombre de cada autor y la cantidad total de libros publicados en cada pa�s (incluso si algunos autores no han publicado en ciertos pa�ses).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, COALESCE(PU.country, 'Sin Pa�s') AS Pais, COALESCE(COUNT(TA.title_id), 0) AS LibrosPublicadosEnPais
FROM authors A
FULL JOIN titleauthor TA ON A.au_id = TA.au_id
FULL JOIN titles T ON TA.title_id = T.title_id
FULL JOIN publishers PU ON T.pub_id = PU.pub_id
GROUP BY A.au_fname, A.au_lname, PU.country;

-- Muestra el nombre de cada t�tulo y la cantidad total de t�tulos publicados por cada g�nero (incluso si algunos g�neros no tienen t�tulos).
SELECT G.type AS Genero, COALESCE(COUNT(T.title_id), 0) AS TitulosPublicadosEnGenero
FROM titles T
FULL JOIN roysched RS ON T.title_id = RS.title_id
FULL JOIN titles G ON RS.title_id = G.title_id
GROUP BY G.type;


-- Muestra el nombre de cada t�tulo y la cantidad total de copias vendidas en cada a�o (incluso si algunos t�tulos no se han vendido en un a�o).
SELECT T.title AS TituloLibro, YEAR(S.ord_date) AS A�oVenta, COALESCE(SUM(S.qty), 0) AS CopiasVendidasEnA�o
FROM titles T
FULL JOIN sales S ON T.title_id = S.title_id
GROUP BY T.title, YEAR(S.ord_date);

-- Muestra el nombre de cada autor y la cantidad total de libros publicados en cada g�nero (incluso si algunos autores no han publicado en ciertos g�neros).
SELECT A.au_fname AS NombreAutor, A.au_lname AS ApellidoAutor, G.type AS Genero, COALESCE(COUNT(TA.title_id), 0) AS LibrosPublicadosEnGenero
FROM authors A
FULL JOIN titleauthor TA ON A.au_id = TA.au_id
FULL JOIN titles T ON TA.title_id = T.title_id
FULL JOIN roysched RS ON T.title_id = RS.title_id
FULL JOIN titles G ON RS.title_id = G.title_id
GROUP BY A.au_fname, A.au_lname, G.type;

-- Muestra el nombre de cada t�tulo y la cantidad total de t�tulos publicados en cada pa�s (incluso si algunos t�tulos no se han publicado en ciertos pa�ses).
SELECT T.title AS TituloLibro, COALESCE(PU.country, 'Sin Pa�s') AS Pais, COALESCE(COUNT(T.title_id), 0) AS TitulosPublicadosEnPais
FROM titles T
FULL JOIN publishers PU ON T.pub_id = PU.pub_id
GROUP BY T.title, PU.country;

-- Muestra el nombre de cada t�tulo y la cantidad total de t�tulos publicados por cada editor (incluso si algunos editores no han publicado t�tulos).
SELECT T.title AS TituloLibro, COALESCE(PU.pub_name, 'Sin Editor') AS Editor, COALESCE(COUNT(T.title_id), 0) AS TitulosPublicadosPorEditor
FROM titles T
FULL JOIN publishers PU ON T.pub_id = PU.pub_id
GROUP BY T.title, PU.pub_name;



-- Muestra el nombre de cada empleado y la cantidad total de t�tulos que han vendido en cada mes (incluso si algunos empleados no han vendido en un mes).
SELECT E.emp_id AS IDEmpleado, E.fname AS NombreEmpleado, E.lname AS ApellidoEmpleado, MONTH(S.ord_date) AS MesVenta, COALESCE(SUM(S.qty), 0) AS TitulosVendidosEnMes
FROM employee E
FULL JOIN sales S ON E.emp_id = S.stor_id
GROUP BY E.emp_id, E.fname, E.lname, MONTH(S.ord_date);

-- Muestra el nombre de cada t�tulo y la cantidad total de ejemplares no vendidos (incluso si algunos t�tulos no tienen ejemplares no vendidos).
SELECT T.title AS TituloLibro, COALESCE(SUM(S.qty), 0) AS EjemplaresNoVendidos
FROM titles T
FULL JOIN sales S ON T.title_id = S.title_id
GROUP BY T.title;















---------------------------------LEFT JOIN ------------------------------------------------
--Lista de autores con la cantidad de libros escritos, ordenados por la cantidad de libros en orden descendente
SELECT A.au_id, A.au_lname, A.au_fname, COUNT(T.title_id) AS NumLibros
FROM authors AS A
LEFT JOIN titleauthor AS TA ON A.au_id = TA.au_id
inner join titles as T on TA.title_id = T.title_id
GROUP BY A.au_id, A.au_lname, A.au_fname
ORDER BY NumLibros DESC;

--Mostrar los t�tulos de los libros junto con la cantidad de copias vendidas por t�tulo, ordenados por la cantidad de copias vendidas en orden descendente
SELECT T.title, SUM(S.qty) AS CopiasVendidas
FROM titles AS T
LEFT JOIN sales AS S ON T.title_id = S.title_id
GROUP BY T.title
ORDER BY CopiasVendidas DESC;

--Lista de los editores con la cantidad total de ventas, ordenados por la cantidad total de ventas en orden descendente
SELECT P.pub_name, SUM(S.qty) AS TotalVentas
FROM publishers AS P
LEFT JOIN titles AS T ON P.pub_id = T.pub_id
LEFT JOIN sales AS S ON T.title_id = S.title_id
GROUP BY P.pub_name
ORDER BY TotalVentas DESC;

--Mostrar los t�tulos de los libros junto con sus autores y la cantidad de copias vendidas, ordenados por t�tulo
SELECT T.title, A.au_lname, A.au_fname, SUM(S.qty) AS CopiasVendidas
FROM titles AS T
LEFT JOIN titleauthor AS TA ON T.title_id = TA.title_id
LEFT JOIN authors AS A ON TA.au_id = A.au_id
LEFT JOIN sales AS S ON T.title_id = S.title_id
GROUP BY T.title, A.au_lname, A.au_fname
ORDER BY T.title;


--Mostrar los autores con la cantidad total de regal�as ganadas, ordenados por la cantidad total de regal�as en orden descendente
SELECT A.au_id, A.au_lname, A.au_fname, SUM(T.royalty) AS TotalRegalias
FROM authors AS A
LEFT JOIN titleauthor AS TA ON A.au_id = TA.au_id
LEFT JOIN titles AS T ON TA.title_id = T.title_id
GROUP BY A.au_id, A.au_lname, A.au_fname
ORDER BY TotalRegalias DESC;

--Listar las tiendas junto con la cantidad total de copias vendidas en cada una, ordenadas por la cantidad total de copias vendidas en orden descendente
SELECT ST.stor_name, SUM(S.qty) AS CopiasVendidas
FROM stores AS ST
LEFT JOIN sales AS S ON ST.stor_id = S.stor_id
GROUP BY ST.stor_name
ORDER BY CopiasVendidas DESC;

--Mostrar los t�tulos de libros junto con su precio y la cantidad de copias vendidas, ordenados por el precio unitario en orden descendente
SELECT T.title, T.price, SUM(S.qty) AS CopiasVendidas
FROM titles AS T
LEFT JOIN sales AS S ON T.title_id = S.title_id
GROUP BY T.title, T.price
ORDER BY T.price DESC;

--Listar los autores con la cantidad total de copias vendidas de sus libros, ordenados por la cantidad total de copias vendidas en orden descendente
SELECT A.au_id, A.au_lname, A.au_fname, SUM(S.qty) AS CopiasVendidas
FROM authors AS A
LEFT JOIN titleauthor AS TA ON A.au_id = TA.au_id
LEFT JOIN titles AS T ON TA.title_id = T.title_id
LEFT JOIN sales AS S ON T.title_id = S.title_id
GROUP BY A.au_id, A.au_lname, A.au_fname
ORDER BY CopiasVendidas DESC;

--Mostrar los t�tulos de libros junto con su precio y la cantidad total de regal�as ganadas, ordenados por la cantidad total de regal�as en orden descendente
SELECT T.title, T.price, SUM(T.royalty) AS TotalRegalias
FROM titles AS T
LEFT JOIN titleauthor AS TA ON T.title_id = TA.title_id
LEFT JOIN authors AS A ON TA.au_id = A.au_id
GROUP BY T.title, T.price
ORDER BY TotalRegalias DESC;


--Listar los autores junto con el total de regal�as ganadas por cada uno, ordenados por el total de regal�as en orden descendente
SELECT
    A.au_id,
    A.au_lname,
    A.au_fname,
    SUM(T.royalty) AS TotalRegalias
FROM
    authors AS A
LEFT JOIN
    titleauthor AS TA ON A.au_id = TA.au_id
LEFT JOIN
    titles AS T ON TA.title_id = T.title_id
GROUP BY
    A.au_id,
    A.au_lname,
    A.au_fname
HAVING
    SUM(T.royalty) > 0
ORDER BY
    TotalRegalias DESC;

 --Mostrar los editores con la cantidad total de ventas superior a $n, ordenados por la cantidad total de ventas en orden descendente
	
CREATE PROCEDURE sp_total_Ventas_editor
@cantidad money
AS
BEGIN
   SELECT
		P.pub_id,
		P.pub_name,
		SUM(S.qty * T.price) AS TotalVentas
	FROM
		publishers AS P
	LEFT JOIN
		titles AS T ON P.pub_id = T.pub_id
	LEFT JOIN
		sales AS S ON T.title_id = S.title_id
	GROUP BY
		P.pub_id,
		P.pub_name
	HAVING
		SUM(S.qty * T.price) > @cantidad
	ORDER BY
		TotalVentas DESC;
END;

EXEC sp_total_Ventas_editor @cantidad = 500;


    --Listar los t�tulos de libros que tienen m�s de n copias vendidas, ordenados por t�tulo
CREATE PROCEDURE sp_titulosMasCopias
@copias int
AS
BEGIN
	SELECT
		T.title,
		SUM(S.qty) AS CopiasVendidas
	FROM
		titles AS T
	LEFT JOIN
		sales AS S ON T.title_id = S.title_id
	GROUP BY
		T.title
	HAVING
		SUM(S.qty) > @copias
	ORDER BY
		T.title;
END;
EXEC sp_titulosMasCopias @copias = 10;


--Mostrar los autores junto con la cantidad de libros que han escrito, ordenados por la cantidad de libros en orden descendente
SELECT
    A.au_id,
    A.au_lname,
    A.au_fname,
    COUNT(DISTINCT TA.title_id) AS NumLibros
FROM
    authors AS A
LEFT JOIN
    titleauthor AS TA ON A.au_id = TA.au_id
GROUP BY
    A.au_id,
    A.au_lname,
    A.au_fname
ORDER BY
    NumLibros DESC;

--Mostrar los t�tulos de libros junto con el precio unitario y la cantidad total de copias vendidas, ordenados por el precio unitario en orden descendente
SELECT
    T.title,
    T.price,
    SUM(S.qty) AS CopiasVendidas
FROM
    titles AS T
LEFT JOIN
    sales AS S ON T.title_id = S.title_id
GROUP BY
    T.title,
    T.price
ORDER BY
    T.price DESC;

--Listar los autores junto con el total de copias vendidas de sus libros, ordenados por el total de copias vendidas en orden descendente
SELECT
    A.au_id,
    A.au_lname,
    A.au_fname,
    SUM(S.qty) AS CopiasVendidas
FROM
    authors AS A
LEFT JOIN
    titleauthor AS TA ON A.au_id = TA.au_id
LEFT JOIN
    titles AS T ON TA.title_id = T.title_id
LEFT JOIN
    sales AS S ON T.title_id = S.title_id
GROUP BY
    A.au_id,
    A.au_lname,
    A.au_fname
ORDER BY
    CopiasVendidas DESC;

----Listar los autores junto con el total de copias vendidas de sus libros, ordenados por el total de copias vendidas en orden descendente
SELECT
    T.title,
    SUM(S.qty) AS CopiasVendidas,
    SUM(T.royalty) AS TotalRegalias
FROM
    titles AS T
LEFT JOIN
    sales AS S ON T.title_id = S.title_id
GROUP BY
    T.title
HAVING
    SUM(S.qty) > 0
ORDER BY
    CopiasVendidas DESC;

CREATE PROCEDURE sp_titulosVentasCopias
@copias int
AS
BEGIN
    ----Listar los t�tulos de libros junto con la cantidad total de ventas de libros que tienen al menos n copias vendidas, ordenados por la cantidad total de ventas en orden descendente
	SELECT
		T.title,
		SUM(S.qty) AS VentasTotales
	FROM
		titles AS T
	LEFT JOIN
		sales AS S ON T.title_id = S.title_id
	GROUP BY
		T.title
	HAVING
		SUM(S.qty) >= @copias
	ORDER BY
		VentasTotales DESC;
END;
EXEC sp_titulosVentasCopias @copias = 10;

CREATE PROCEDURE sp_titulosRegaliasCopias
@copias int
AS
BEGIN
    --Mostrar los t�tulos de libros junto con el total de regal�as ganadas y la cantidad de copias vendidas, para libros que tengan al menos 20 copias vendidas, ordenados por la cantidad total de regal�as en orden descendente
	SELECT
		T.title,
		SUM(S.qty) AS CopiasVendidas,
		SUM(T.royalty) AS TotalRegalias
	FROM
		titles AS T
	LEFT JOIN
		sales AS S ON T.title_id = S.title_id
	GROUP BY
		T.title
	HAVING
		SUM(S.qty) >= @copias
	ORDER BY
		TotalRegalias DESC;
END;
EXEC sp_titulosRegaliasCopias @copias = 20;


--Mostrar los nombres de los autores junto con la cantidad de libros que han escrito, ordenados por la cantidad de libros en orden descendente
SELECT
    A.au_lname + ', ' + A.au_fname AS Autor,
    COUNT(DISTINCT TA.title_id) AS NumLibros
FROM
    authors AS A
LEFT JOIN
    titleauthor AS TA ON A.au_id = TA.au_id
GROUP BY
    A.au_lname, A.au_fname
ORDER BY
    NumLibros DESC;

--Listar los nombres de los autores junto con la cantidad total de copias vendidas de sus libros, ordenados por la cantidad total de copias vendidas en orden descendente
SELECT
    A.au_lname + ', ' + A.au_fname AS Autor,
    SUM(S.qty) AS CopiasVendidas
FROM
    authors AS A
LEFT JOIN
    titleauthor AS TA ON A.au_id = TA.au_id
LEFT JOIN
    titles AS T ON TA.title_id = T.title_id
LEFT JOIN
    sales AS S ON T.title_id = S.title_id
GROUP BY
    A.au_lname, A.au_fname
ORDER BY
    CopiasVendidas DESC;

--Listar los editores junto con la longitud promedio de los nombres de los t�tulos de libros que han publicado, ordenados por la longitud promedio en orden descendente
SELECT
    P.pub_name,
    AVG(LEN(T.title)) AS LongitudPromedio
FROM
    publishers AS P
LEFT JOIN
    titles AS T ON P.pub_id = T.pub_id
GROUP BY
    P.pub_name
ORDER BY
    LongitudPromedio DESC;


--Mostrar los nombres de los autores y la cantidad de libros que han escrito, separando los nombres con una coma y espacio, ordenados por la cantidad de libros en orden descendente
SELECT
    STRING_AGG(A.au_lname + ', ' + A.au_fname, ', ') AS Autores,
    COUNT(DISTINCT TA.title_id) AS NumLibros
FROM
    authors AS A
LEFT JOIN
    titleauthor AS TA ON A.au_id = TA.au_id
GROUP BY
    A.au_id
ORDER BY
    NumLibros DESC;

--Mostrar los t�tulos de libros junto con el nombre del editor en par�ntesis, ordenados por t�tulo
SELECT
    T.title + ' (' + P.pub_name + ')' AS TituloEditor
FROM
    titles AS T
LEFT JOIN
    publishers AS P ON T.pub_id = P.pub_id
ORDER BY
    T.title;

--Listar los nombres de los autores junto con la cantidad de libros que han escrito, mostrando solo los autores que han escrito m�s de un libro, ordenados por la cantidad de libros en orden descendente
SELECT
    A.au_lname + ', ' + A.au_fname AS Autor,
    COUNT(DISTINCT TA.title_id) AS NumLibros
FROM
    authors AS A
LEFT JOIN
    titleauthor AS TA ON A.au_id = TA.au_id
GROUP BY
    A.au_lname, A.au_fname
HAVING
    COUNT(DISTINCT TA.title_id) > 1
ORDER BY
    NumLibros DESC;

--Mostrar los t�tulos de libros junto con el nombre del autor que ha escrito el libro m�s largo, ordenados por la longitud del t�tulo en orden descendente
SELECT
    T.title,
    A.au_lname + ', ' + A.au_fname AS Autor
FROM
    titles AS T
LEFT JOIN
    titleauthor AS TA ON T.title_id = TA.title_id
LEFT JOIN
    authors AS A ON TA.au_id = A.au_id
WHERE
    LEN(T.title) = (
        SELECT MAX(LEN(title))
        FROM titles
    )
ORDER BY
    LEN(T.title) DESC;
	
	
