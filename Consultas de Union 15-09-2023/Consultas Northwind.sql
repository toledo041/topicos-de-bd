use Northwind1


-----Lista de los clientes y sus órdenes con detalles de productos.
SELECT
    C.CustomerID,
    C.CompanyName,
    O.OrderID,
    P.ProductName,
    OD.Quantity
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN Products AS P ON OD.ProductID = P.ProductID;

-----Nombre de los clientes y la cantidad total gastada por cada cliente en orden descendente.
SELECT
    C.CustomerID,
    C.CompanyName,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalSpent
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY TotalSpent DESC;

-- Mostrar los productos más vendidos en un año específico
CREATE PROCEDURE sp_Productos_vendidos_Year
    @Year INT
AS
BEGIN
    SELECT
        C.CustomerID,
        C.CompanyName,
        SUM(OD.Quantity * OD.UnitPrice) AS TotalSpent
    FROM Customers AS C
    INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
    INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
    INNER JOIN Products AS P ON OD.ProductID = P.ProductID
    WHERE YEAR(O.OrderDate) = @Year
    GROUP BY C.CustomerID, C.CompanyName
    ORDER BY TotalSpent DESC;
END;

EXEC sp_Productos_Vendidos_Year @Year = 1997;


----Mostrar los productos más vendidos junto con la cantidad total vendida
SELECT
    P.ProductName,
    SUM(OD.Quantity) AS TotalSold
FROM Products AS P
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName
ORDER BY TotalSold DESC;


------Muestra el cliente que ha realizado el pedido más grande en términos de cantidad de productos.
SELECT TOP 1
    C.CustomerID,
    C.CompanyName,
    SUM(OD.Quantity) AS TotalQuantity
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY TotalQuantity DESC;
-----Lista de  los empleados junto con el número total de pedidos que han procesado.
SELECT
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    COUNT(O.OrderID) AS TotalOrders
FROM Employees AS E
INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
GROUP BY E.EmployeeID, E.FirstName, E.LastName;


-----Lista de los productos más vendidos y la cantidad total vendida para cada uno.--

SELECT
    P.ProductName,
    SUM(OD.Quantity) AS TotalSold
FROM Products AS P
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName
ORDER BY TotalSold DESC;



-- Muestra los nombres de los productos y sus precios unitarios, ordenados por precio de forma ascendente.
SELECT Products.ProductName, Products.UnitPrice
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
ORDER BY Products.UnitPrice;
------------
 -- Muestra la cantidad total de productos vendidos por categoría y muestra solo las categorías con más de n unidades vendidas en total.
	
CREATE PROCEDURE sp_Cantidad_Productos_Vendidos
    @unidades integer
AS
BEGIN
   SELECT Categories.CategoryName, SUM(Details.Quantity) AS Total
	FROM Categories
	INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
	INNER JOIN dbo.[Order Details] Details ON Products.ProductID = Details.ProductID
	GROUP BY Categories.CategoryName
	HAVING SUM(Details.Quantity) > @unidades;
END;
EXEC sp_Cantidad_Productos_Vendidos @unidades = 100;



--------------- Muestra el nombre de la categoría y el precio promedio de los productos en esa categoría,
	-- y muestra solo las categorías donde el precio promedio es superior a $n.
CREATE PROCEDURE sp_Nombre_Categoria_Prom
    @precio money
AS
BEGIN
	
	SELECT Categories.CategoryName, AVG(Products.UnitPrice) AS Precio
	FROM Categories
	INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
	GROUP BY Categories.CategoryName
	HAVING AVG(Products.UnitPrice) > @precio;
END;

EXEC sp_Nombre_Categoria_Prom @precio = 50;

-- Muestra el año de pedido y la cantidad total de productos vendidos en ese año,
-- agrupados por año de pedido.
SELECT YEAR(Orders.OrderDate) AS OrderYear, SUM(OD.Quantity) AS TotalVendido
FROM Orders
INNER JOIN dbo.[Order Details] OD ON Orders.OrderID = OD.OrderID
GROUP BY OrderDate;

--Muestra el nombre del producto más barato en cada categoría.
SELECT Categories.CategoryName, MIN(Products.UnitPrice) AS MinimoPrecio
FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryName;

-- Muestra el nombre del empleado que ha procesado el pedido más caro y el monto del pedido.
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MAX(O.Freight) AS MaxOrderTotal
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY FirstName, LastName;

-- Muestra los nombres de los productos y la cantidad de veces que aparecen en los detalles de pedidos,
-- ordenados por la cantidad de veces que se han pedido de forma descendente.
SELECT Products.ProductName, COUNT(O.ProductID) AS VecesOrdenado
FROM Products
INNER JOIN dbo.[Order Details] O ON Products.ProductID = O.ProductID
GROUP BY Products.ProductName
ORDER BY VecesOrdenado DESC;

-- Muestra el mes y año de los pedidos junto con la cantidad total de productos vendidos en cada mes,
-- ordenados por año y mes de forma ascendente.
SELECT YEAR(O.OrderDate) AS AñoORDEN, MONTH(O.OrderDate) AS MesOrden, SUM(OD.Quantity) AS TotalSold
FROM Orders O
INNER JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY OrderDate
ORDER BY AñoORDEN ASC, MesOrden ASC;

-- Muestra el nombre del empleado, el número total de pedidos procesados por el empleado,
-- y el promedio de cantidad de productos por pedido para ese empleado.
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, COUNT(O.OrderID) AS TotalOrders, AVG(OD.Quantity) AS AvgQuantityPerOrder
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
INNER JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY E.FirstName, E.LastName

-- Muestra los nombres de los productos y sus precios unitarios, ordenados por precio de forma ascendente.
SELECT P.ProductName, P.UnitPrice
FROM Products P
INNER JOIN Categories C ON P.CategoryID = C.CategoryID
ORDER BY P.UnitPrice;
----------- Muestra la cantidad total de productos vendidos por categoría y muestra solo las categorías con más de n unidades vendidas en total.
	
CREATE PROCEDURE sp_Tot_Productos_Categoria
    @unidades int
AS
BEGIN
	SELECT C.CategoryName, SUM(OD.Quantity) AS TotalSold
	FROM Categories C
	INNER JOIN Products P ON C.CategoryID = P.CategoryID
	INNER JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
	GROUP BY C.CategoryName
	HAVING SUM(OD.Quantity) > @unidades;
END;

EXEC sp_Tot_Productos_Categoria @unidades = 100;

----------------- Muestra el número de pedidos realizados por cada cliente y muestra solo aquellos clientes que han realizado más de n pedidos.
	
CREATE PROCEDURE sp_N_Pedidos_Cliente
    @pedidos int
AS
BEGIN
	SELECT C.CompanyName, COUNT(O.OrderID) AS NumberOfOrders
	FROM Customers C
	INNER JOIN Orders O ON C.CustomerID = O.CustomerID
	GROUP BY C.CompanyName
	HAVING COUNT(O.OrderID) > @pedidos;
END;

EXEC sp_N_Pedidos_Cliente @pedidos = 5;



-----Lista de  los empleados junto con el número total de pedidos que han procesado.
SELECT
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    COUNT(O.OrderID) AS TotalOrders
FROM Employees AS E
INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
GROUP BY E.EmployeeID, E.FirstName, E.LastName;


-------------- Muestra el nombre de la categoría y el precio promedio de los productos en esa categoría,
	-- y muestra solo las categorías donde el precio promedio es superior a $50.
	----------

CREATE PROCEDURE sp_Nombre_Categoria_Precio
    @precio money
AS
BEGIN
	SELECT C.CategoryName, AVG(P.UnitPrice) AS Precio
	FROM Categories C
	INNER JOIN Products P ON C.CategoryID = P.CategoryID
	GROUP BY C.CategoryName
	HAVING AVG(P.UnitPrice) > @precio;
END;

EXEC sp_Nombre_Categoria_Precio @precio = 50;

-- Muestra el año de pedido y la cantidad total de productos vendidos en ese año,
-- agrupados por año de pedido.
SELECT YEAR(O.OrderDate) AS AñoOrden, SUM(OD.Quantity) AS Total
FROM Orders O
INNER JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY OrderDate;

-- Muestra el nombre de la categoría y el precio mínimo de los productos en cada categoría.
SELECT C.CategoryName AS NombreCategoría, MIN(P.UnitPrice) AS PrecioMínimo
FROM Categories C
INNER JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY CategoryName;

--Muestra los nombres de los productos y sus unidades en stock, ordenados por unidades en stock de forma descendente.
SELECT P.ProductName, P.UnitsInStock
FROM Products P
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
ORDER BY P.UnitsInStock DESC;
---------------- Muestra la cantidad total de productos vendidos por proveedor y muestra
--solo los proveedores con más de n unidades vendidas en total.---

CREATE PROCEDURE sp_Cantidad_Productos_VendidosProv
    @unidades int
AS
BEGIN
	SELECT S.CompanyName AS NombreProveedor, SUM(OD.Quantity) AS TotalVendido
	FROM Suppliers S
	INNER JOIN Products P ON S.SupplierID = P.SupplierID
	INNER JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
	GROUP BY S.CompanyName
	HAVING SUM(OD.Quantity) > @unidades;
END;

EXEC sp_Cantidad_Productos_VendidosProv @unidades = 200;
------- Muestra el número de pedidos realizados por cada empleado y muestra solo aquellos empleados que han procesado más de 15 pedidos.

CREATE PROCEDURE sp_Pedidos_Empleado
    @unidades int
AS
BEGIN
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, COUNT(O.OrderID) AS TotalPedidos
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY E.FirstName, E.LastName
HAVING COUNT(O.OrderID) > @unidades;
END;
EXEC sp_Pedidos_Empleado @unidades = 15;


------- Muestra el nombre de la categoría y el precio promedio de los productos en esa categoría,
	-- y muestra solo las categorías donde el precio promedio es superior a $n.

CREATE PROCEDURE sp_Cantidad_Productos_Categoria
    @precio money
AS
BEGIN
	SELECT C.CategoryName AS NombreCategoría, AVG(P.UnitPrice) AS PrecioPromedio
	FROM Categories C
	INNER JOIN Products P ON C.CategoryID = P.CategoryID
	GROUP BY C.CategoryName
	HAVING AVG(P.UnitPrice) > @precio;
END;

EXEC sp_Cantidad_Productos_Categoria @precio = 25;



-- Muestra el año de pedido y la cantidad total de productos vendidos en ese año,
-- agrupados por año de pedido.
SELECT YEAR(O.OrderDate) AS AñoPedido, SUM(OD.Quantity) AS TotalVendido
FROM Orders O
INNER JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY OrderDate;

-- Muestra el nombre del producto más barato en cada categoría.
SELECT C.CategoryName, MIN(P.UnitPrice) AS PrecioMínimo
FROM Categories C
INNER JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName;

-- Muestra el nombre del país y el número total de pedidos realizados desde ese país.
SELECT C.Country AS NombrePaís, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.Country;



--Muestra el nombre del producto y la cantidad total de veces que se ha pedido ese producto,
-- agrupados por nombre del producto.
SELECT P.ProductName AS NombreProducto, COUNT(OD.Quantity) AS TotalVecesPedido
FROM Products P
INNER JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY ProductName;

--Muestra el nombre del empleado y el promedio de la cantidad de productos por pedido procesado por ese empleado,
-- agrupados por nombre del empleado.
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, AVG(OD.Quantity) AS PromedioCantidadPorPedido
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
INNER JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY FirstName, LastName;

-- Muestra el nombre de la categoría y el precio mínimo de los productos en cada categoría,
-- agrupados por nombre de la categoría.
SELECT C.CategoryName AS NombreCategoría, MIN(P.UnitPrice) AS PrecioMínimo
FROM Categories C
INNER JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY CategoryName;

-- Muestra el nombre del cliente y la cantidad total gastada por cada cliente en productos,
-- agrupados por nombre del cliente.
SELECT C.CompanyName AS NombreCliente, SUM(P.UnitPrice * OD.Quantity) AS TotalGastado
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY CompanyName;

-- Muestra el nombre de la ciudad y el número total de pedidos realizados desde cada ciudad,
-- agrupados por nombre de la ciudad.
SELECT C.City AS NombreCiudad, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY City;


-- Muestra el nombre del empleado y el número total de pedidos procesados por ese empleado,
-- agrupados por nombre del empleado.
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, COUNT(O.OrderID) AS TotalPedidos
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY FirstName, LastName;



-- Muestra el nombre del cliente y el número total de pedidos realizados por ese cliente,
-- agrupados por nombre del cliente.
SELECT C.CompanyName AS NombreCliente, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY CompanyName;
-- Muestra el nombre del proveedor y el total de unidades vendidas de todos los productos de ese proveedor,
-- agrupados por nombre del proveedor.
SELECT S.CompanyName AS NombreProveedor, SUM(OD.Quantity) AS TotalUnidadesVendidas
FROM Suppliers S
INNER JOIN Products P ON S.SupplierID = P.SupplierID
INNER JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY CompanyName;

-- Muestra el nombre de la categoría y el número total de productos en cada categoría,
-- agrupados por nombre de la categoría.
SELECT C.CategoryName AS NombreCategoría, COUNT(P.ProductID) AS TotalProductos
FROM Categories C
INNER JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY CategoryName;


-- Muestra el nombre del cliente y el total gastado por cada cliente en productos,
-- agrupados por nombre del cliente.
SELECT C.CompanyName AS NombreCliente, SUM(P.UnitPrice * OD.Quantity) AS TotalGastado
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY CompanyName;

-- Muestra el nombre de la ciudad y el número total de pedidos realizados desde cada ciudad,
-- agrupados por nombre de la ciudad.
SELECT C.City AS NombreCiudad, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY City;

-- Muestra el nombre del empleado y la cantidad promedio de productos por pedido procesado por ese empleado,
-- agrupados por nombre del empleado.
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, AVG(OD.Quantity) AS CantidadPromedioPorPedido
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
INNER JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY FirstName, LastName;

-- Muestra el nombre del producto y el total de unidades vendidas de ese producto,
-- agrupados por nombre del producto.
SELECT P.ProductName AS NombreProducto, SUM(OD.Quantity) AS TotalUnidadesVendidas
FROM Products P
INNER JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY ProductName;

-- Muestra el nombre de la categoría y la cantidad total de productos en cada categoría,
-- agrupados por nombre de la categoría, pero excluyendo las categorías que tienen menos de 10 productos.
SELECT C.CategoryName AS NombreCategoría, COUNT(P.ProductID) AS TotalProductos
FROM Categories C
INNER JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY CategoryName
HAVING COUNT(P.ProductID) >= 10;
--Listar los productos junto con la cantidad total vendida por mes y año, ordenados por mes y año
SELECT
    YEAR(Orders.OrderDate) AS Año,
    MONTH(Orders.OrderDate) AS Mes,
    Products.ProductName,
    SUM([Order Details].Quantity) AS CantidadTotal
FROM
    Orders
INNER JOIN
    [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN
    Products ON [Order Details].ProductID = Products.ProductID
GROUP BY
    YEAR(Orders.OrderDate),
    MONTH(Orders.OrderDate),
    Products.ProductName
ORDER BY
    Año, Mes;

--Mostrar la cantidad total de productos vendidos por categoría durante el año actual, ordenados por la cantidad total en orden descendente
SELECT
    YEAR(Orders.OrderDate) AS Año,
    Categories.CategoryName,
    SUM([Order Details].Quantity) AS CantidadTotal
FROM
    Orders
INNER JOIN
    [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN
    Products ON [Order Details].ProductID = Products.ProductID
INNER JOIN
    Categories ON Products.CategoryID = Categories.CategoryID
WHERE
    YEAR(Orders.OrderDate) = YEAR(GETDATE())
GROUP BY
    YEAR(Orders.OrderDate),
    Categories.CategoryName
ORDER BY
    CantidadTotal DESC;

--Listar los empleados con la cantidad total de órdenes procesadas por trimestre durante el año actual, ordenados por trimestre y empleado
SELECT
    YEAR(Orders.OrderDate) AS Año,
    DATEPART(QUARTER, Orders.OrderDate) AS Trimestre,
    Employees.LastName + ', ' + Employees.FirstName AS Empleado,
    COUNT(Orders.OrderID) AS TotalOrdenes
FROM
    Orders
INNER JOIN
    Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE
    YEAR(Orders.OrderDate) = YEAR(GETDATE())
GROUP BY
    YEAR(Orders.OrderDate),
    DATEPART(QUARTER, Orders.OrderDate),
    Employees.LastName,
    Employees.FirstName
ORDER BY
    Año, Trimestre, Empleado;

--Mostrar los clientes con la cantidad total de órdenes realizadas por año, ordenados por año y cliente
SELECT
    YEAR(Orders.OrderDate) AS Año,
    Customers.CompanyName AS Cliente,
    COUNT(Orders.OrderID) AS TotalOrdenes
FROM
    Orders
INNER JOIN
    Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY
    YEAR(Orders.OrderDate),
    Customers.CompanyName
ORDER BY
    Año, Cliente;

--Listar los productos junto con la cantidad total vendida por año y mes durante el último año, ordenados por año y mes
SELECT
    YEAR(Orders.OrderDate) AS Año,
    MONTH(Orders.OrderDate) AS Mes,
    Products.ProductName,
    SUM([Order Details].Quantity) AS CantidadTotal
FROM
    Orders
INNER JOIN
    [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN
    Products ON [Order Details].ProductID = Products.ProductID
WHERE
    Orders.OrderDate >= DATEADD(YEAR, -1, GETDATE())
GROUP BY
    YEAR(Orders.OrderDate),
    MONTH(Orders.OrderDate),
    Products.ProductName
ORDER BY
    Año, Mes;

--Mostrar los empleados con la cantidad total de órdenes procesadas por año, ordenados por año y empleado
SELECT
    YEAR(Orders.OrderDate) AS Año,
    Employees.LastName + ', ' + Employees.FirstName AS Empleado,
    COUNT(Orders.OrderID) AS TotalOrdenes
FROM
    Orders
INNER JOIN
    Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY
    YEAR(Orders.OrderDate),
    Employees.LastName,
    Employees.FirstName
ORDER BY
    Año, Empleado;

--------------------------------------------------------------------------------------------------------------------------------------
--LEFT JOIN
-- Muestra todos los clientes y sus pedidos correspondientes (si los tienen).
SELECT C.CompanyName AS NombreCliente, O.OrderID
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID;

-- Muestra todos los productos y su categoría correspondiente (si están categorizados).
SELECT P.ProductName AS NombreProducto, C.CategoryName AS Categoria
FROM Products P
LEFT JOIN Categories C ON P.CategoryID = C.CategoryID;

-- Muestra el nombre de cada empleado y la cantidad total de pedidos que ha procesado (incluso si no ha procesado ningún pedido).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, COUNT(O.OrderID) AS TotalPedidos
FROM Employees E
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY FirstName, LastName;

-- Muestra el nombre de cada producto y la cantidad total de unidades vendidas de ese producto (incluso si no se ha vendido ninguna unidad).
SELECT P.ProductName AS NombreProducto, SUM(OD.Quantity) AS TotalUnidadesVendidas
FROM Products P
LEFT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY ProductName;

-- Muestra todos los proveedores y los productos que suministran (incluso si no suministran ningún producto).
SELECT S.CompanyName AS NombreProveedor, P.ProductName AS NombreProducto
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID;

-- Muestra el nombre de cada cliente y el número total de pedidos que ha realizado (incluso si no ha realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY CompanyName;

--Muestra el nombre de cada producto y la cantidad total de unidades en stock de ese producto (incluso si no se tiene ninguna unidad en stock).
SELECT P.ProductName AS NombreProducto, SUM(P.UnitsInStock) AS TotalUnidadesEnStock
FROM Products P
LEFT JOIN Products S ON P.ProductID = S.ProductID
GROUP BY P.ProductName;

-- Muestra todos los pedidos y sus detalles de pedido correspondientes (incluso si no tienen detalles de pedido).
SELECT O.OrderID, P.ProductName AS NombreProducto, OD.Quantity
FROM Orders O
LEFT JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
LEFT JOIN Products P ON OD.ProductID = P.ProductID;

-- Muestra el nombre de cada cliente y el promedio de los montos de sus pedidos (incluso si no ha realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, AVG(O.OrderAmount) AS PromedioMontoPedido
FROM Customers C
LEFT JOIN (
  SELECT CustomerID, OrderID, SUM(Freight) AS OrderAmount
  FROM Orders
  GROUP BY CustomerID, OrderID
) O ON C.CustomerID = O.CustomerID
GROUP BY CompanyName;

-- Muestra el nombre de cada producto y el precio máximo de venta de ese producto (incluso si no se ha vendido ninguna unidad).
SELECT P.ProductName AS NombreProducto, MAX(OD.UnitPrice) AS PrecioMaximoVenta
FROM Products P
LEFT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY ProductName;

-- Muestra todos los productos y la cantidad total de unidades vendidas de ese producto (incluso si no se han vendido unidades).
SELECT P.ProductName AS NombreProducto, SUM(ISNULL(OD.Quantity, 0)) AS TotalUnidadesVendidas
FROM Products P
LEFT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY ProductName;

-- Muestra el nombre de cada categoría y la cantidad total de productos en esa categoría (incluso si no hay productos en esa categoría).
SELECT C.CategoryName AS NombreCategoría, SUM(ISNULL(P.ProductID, 0)) AS TotalProductos
FROM Categories C
LEFT JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY CategoryName;

--Muestra el nombre de cada producto y el precio promedio de venta de ese producto (incluso si no se ha vendido ninguna unidad).
SELECT P.ProductName AS NombreProducto, AVG(ISNULL(OD.UnitPrice, 0)) AS PrecioPromedioVenta
FROM Products P
LEFT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY ProductName;

-- Muestra todos los proveedores y la cantidad de productos que suministran (incluso si no suministran productos).
SELECT S.CompanyName AS NombreProveedor, COUNT(P.ProductID) AS TotalProductosSuministrados
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY CompanyName;

-- Muestra todos los empleados y sus pedidos correspondientes (incluso si no han realizado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, O.OrderID
FROM Employees E
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID;

-- Muestra el nombre de cada producto y la cantidad máxima vendida de ese producto (incluso si no se ha vendido ninguna unidad).
SELECT P.ProductName AS NombreProducto, MAX(ISNULL(OD.Quantity, 0)) AS MaxUnidadesVendidas
FROM Products P
LEFT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY ProductName;

-- Muestra el nombre de cada empleado y el promedio de la cantidad de productos por pedido procesado por ese empleado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, AVG(ISNULL(OD.Quantity, 0)) AS CantidadPromedioPorPedido
FROM Employees E
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
LEFT JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY FirstName, LastName;

-- Muestra todos los productos y su proveedor correspondiente (incluso si algunos productos no tienen proveedor).
SELECT P.ProductName AS NombreProducto, S.CompanyName AS Proveedor
FROM Products P
LEFT JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- Consultas con LEFT JOIN --

--Muestra el nombre de cada producto y la cantidad máxima vendida de ese producto (incluso si no se ha vendido ninguna unidad).
SELECT P.ProductName AS NombreProducto, MAX(ISNULL(OD.Quantity, 0)) AS MaxUnidadesVendidas
FROM Products P
LEFT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY ProductName;

--Muestra el nombre de cada cliente y la fecha del primer pedido que realizaron (incluso si no han realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, MIN(O.OrderDate) AS PrimeraFechaPedido
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY CompanyName;



-- Muestra el nombre de cada empleado y el nombre del jefe bajo el cual trabajan (incluso si no tienen jefe asignado).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, CONCAT(M.FirstName, ' ', M.LastName) AS Jefe
FROM Employees E
LEFT JOIN Employees M ON E.ReportsTo = M.EmployeeID;

-- Muestra el nombre de cada producto y su precio de compra promedio (incluso si no se ha comprado ningún producto).
SELECT P.ProductName AS NombreProducto, AVG(ISNULL(OD.UnitPrice, 0)) AS PrecioCompraPromedio
FROM Products P
LEFT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY ProductName;

--Muestra el nombre de cada proveedor y la cantidad total de productos que suministran (incluso si no suministran productos).
SELECT S.CompanyName AS NombreProveedor, COUNT(P.ProductID) AS TotalProductosSuministrados
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY CompanyName;


-- Muestra el nombre de cada cliente y la fecha del primer pedido que realizaron (incluso si no han realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, MIN(O.OrderDate) AS PrimeraFechaPedido
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY CompanyName;



-- Muestra el nombre de cada producto y el nombre del proveedor correspondiente (incluso si algunos productos no tienen proveedor).
SELECT P.ProductName AS NombreProducto, S.CompanyName AS Proveedor
FROM Products P
LEFT JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- Consultas con LEFT JOIN -----------------------------------------------------------------------------------

--Muestra el nombre de cada empleado y el nombre de su supervisor (incluso si no tienen supervisor).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, CONCAT(S.FirstName, ' ', S.LastName) AS Supervisor
FROM Employees E
LEFT JOIN Employees S ON E.ReportsTo = S.EmployeeID;



-- Muestra el nombre de cada producto y su precio de venta promedio (incluso si no se ha vendido ninguna unidad).
SELECT P.ProductName AS NombreProducto, AVG(ISNULL(OD.UnitPrice, 0)) AS PrecioVentaPromedio
FROM Products P
LEFT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY ProductName;


-- Muestra el nombre de cada empleado y el total de productos vendidos por ese empleado (incluso si no han vendido productos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, SUM(ISNULL(OD.Quantity, 0)) AS TotalProductosVendidos
FROM Employees E
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
LEFT JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY FirstName, LastName;

-- Muestra el nombre de cada cliente y la fecha del último pedido que realizaron (incluso si no han realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, MAX(O.OrderDate) AS ÚltimaFechaPedido
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY CompanyName;



-- Muestra el nombre de cada empleado y el nombre del territorio que supervisa (incluso si no supervisan territorios).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, T.TerritoryDescription AS TerritorioSupervisado
FROM Employees E
LEFT JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
LEFT JOIN Territories T ON ET.TerritoryID = T.TerritoryID;

-- Muestra el nombre de cada empleado y el nombre del territorio que supervisa (incluso si no supervisan territorios).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, T.TerritoryDescription AS TerritorioSupervisado
FROM Employees E
LEFT JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
LEFT JOIN Territories T ON ET.TerritoryID = T.TerritoryID;


-- Muestra el nombre de cada producto y su proveedor correspondiente (incluso si algunos productos no tienen proveedor).
SELECT P.ProductName AS NombreProducto, S.CompanyName AS Proveedor
FROM Products P
LEFT JOIN Suppliers S ON P.SupplierID = S.SupplierID;



-- Muestra el nombre de cada producto y su categoría correspondiente (incluso si no están categorizados).
SELECT P.ProductName AS NombreProducto, C.CategoryName AS Categoria
FROM Products P
LEFT JOIN Categories C ON P.CategoryID = C.CategoryID;

-- Muestra el nombre de cada empleado y la cantidad total de productos que ha vendido (incluso si no han vendido productos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, SUM(ISNULL(OD.Quantity, 0)) AS TotalProductosVendidos
FROM Employees E
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
LEFT JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY FirstName, LastName;

-- Muestra el nombre de cada cliente y el número total de pedidos que ha realizado (incluso si no ha realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY CompanyName;

-- Muestra el nombre de cada empleado y la fecha de su primer pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MIN(O.OrderDate) AS PrimeraFechaPedido
FROM Employees E
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY FirstName, LastName;






--RIGT JOIN------------------------------------

-- Muestra el nombre de cada empleado y el nombre de su jefe (incluso si algunos empleados no tienen jefe).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, CONCAT(M.FirstName, ' ', M.LastName) AS Jefe
FROM Employees M
RIGHT JOIN Employees E ON E.ReportsTo = M.EmployeeID;


-- Muestra el nombre de cada empleado y la fecha de su último pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MAX(O.OrderDate) AS ÚltimaFechaPedido
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);


-- Muestra el nombre de cada producto y el nombre de su proveedor correspondiente (incluso si algunos productos no tienen proveedor).
SELECT P.ProductName AS NombreProducto, S.CompanyName AS Proveedor
FROM Suppliers S
RIGHT JOIN Products P ON S.SupplierID = P.SupplierID;

--Muestra el nombre de cada empleado y su título (incluso si no tienen título registrado).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, COALESCE(E.Title, 'Título Desconocido') AS Título
FROM Employees E
RIGHT JOIN Employees M ON E.ReportsTo = M.EmployeeID;

-- Muestra el nombre de cada empleado y el nombre de su jefe (incluso si algunos empleados no tienen jefe).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, CONCAT(M.FirstName, ' ', M.LastName) AS Jefe
FROM Employees M
RIGHT JOIN Employees E ON E.ReportsTo = M.EmployeeID;

-- Muestra el nombre de cada producto y su categoría correspondiente (incluso si no están categorizados).
SELECT P.ProductName AS NombreProducto, C.CategoryName AS Categoria
FROM Categories C
RIGHT JOIN Products P ON C.CategoryID = P.CategoryID;

-- Muestra el nombre de cada empleado y la cantidad total de productos que ha vendido (incluso si no han vendido productos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, SUM(ISNULL(OD.Quantity, 0)) AS TotalProductosVendidos
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
RIGHT JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

-- Muestra el nombre de cada cliente y el número total de pedidos que ha realizado (incluso si no ha realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
RIGHT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName;

-- Muestra el nombre de cada empleado y la fecha de su primer pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MIN(O.OrderDate) AS PrimeraFechaPedido
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

-- Muestra el nombre de cada producto y la cantidad mínima en stock (incluso si no se ha establecido una cantidad mínima).
SELECT P.ProductName AS NombreProducto, COALESCE(P.ReorderLevel, 0) AS CantidadMínimaEnStock
FROM Products P
RIGHT JOIN Suppliers S ON P.SupplierID = S.SupplierID;


-- Muestra el nombre de cada empleado y el nombre de su jefe (incluso si algunos empleados no tienen jefe).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, CONCAT(M.FirstName, ' ', M.LastName) AS Jefe
FROM Employees M
RIGHT JOIN Employees E ON E.ReportsTo = M.EmployeeID;

-- Muestra el nombre de cada producto y el nombre de su proveedor correspondiente (incluso si algunos productos no tienen proveedor).
SELECT P.ProductName AS NombreProducto, S.CompanyName AS Proveedor
FROM Suppliers S
RIGHT JOIN Products P ON S.SupplierID = P.SupplierID;

-- Muestra el nombre de cada empleado y su título (incluso si no tienen título registrado).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, COALESCE(E.Title, 'Título Desconocido') AS Título
FROM Employees E
RIGHT JOIN Employees M ON E.ReportsTo = M.EmployeeID;

-- Muestra el nombre de cada empleado y la cantidad total de productos que ha vendido (incluso si no han vendido productos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, SUM(ISNULL(OD.Quantity, 0)) AS TotalProductosVendidos
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
RIGHT JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

--Muestra el nombre de cada producto y su categoría correspondiente (incluso si no están categorizados).
SELECT P.ProductName AS NombreProducto, C.CategoryName AS Categoria
FROM Categories C
RIGHT JOIN Products P ON C.CategoryID = P.CategoryID;

-- Muestra el nombre de cada empleado y la cantidad total de productos que ha vendido (incluso si no han vendido productos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, SUM(ISNULL(OD.Quantity, 0)) AS TotalProductosVendidos
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
RIGHT JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

-- Muestra el nombre de cada cliente y el número total de pedidos que ha realizado (incluso si no ha realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
RIGHT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName;

-- Muestra el nombre de cada empleado y la fecha de su primer pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MIN(O.OrderDate) AS PrimeraFechaPedido
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

-- Muestra el nombre de cada producto y la cantidad mínima en stock (incluso si no se ha establecido una cantidad mínima).
SELECT P.ProductName AS NombreProducto, COALESCE(P.ReorderLevel, 0) AS CantidadMínimaEnStock
FROM Products P
RIGHT JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- Muestra el nombre de cada empleado y la fecha de su último pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MAX(O.OrderDate) AS ÚltimaFechaPedido
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);


-- Muestra el nombre de cada producto y la cantidad total vendida en todas las órdenes (incluso si algunos productos no se han vendido).
SELECT P.ProductName AS NombreProducto, SUM(ISNULL(OD.Quantity, 0)) AS TotalVendido
FROM Products P
RIGHT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName;

-- Muestra el nombre de cada producto y su categoría correspondiente (incluso si no están categorizados).
SELECT P.ProductName AS NombreProducto, C.CategoryName AS Categoria
FROM Categories C
RIGHT JOIN Products P ON C.CategoryID = P.CategoryID;

-- Muestra el nombre de cada empleado y la fecha de su primer pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MIN(O.OrderDate) AS PrimeraFechaPedido
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

-- Muestra el nombre de cada producto y la cantidad mínima en stock (incluso si no se ha establecido una cantidad mínima).
SELECT P.ProductName AS NombreProducto, COALESCE(P.ReorderLevel, 0) AS CantidadMínimaEnStock
FROM Products P
RIGHT JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- Muestra el nombre de cada empleado y la fecha de su último pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MAX(O.OrderDate) AS ÚltimaFechaPedido
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

-- Muestra el nombre de cada cliente y el número total de pedidos que ha realizado (incluso si no ha realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
RIGHT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName;

-- Muestra el nombre de cada empleado y el nombre de su jefe (incluso si algunos empleados no tienen jefe).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, CONCAT(M.FirstName, ' ', M.LastName) AS Jefe
FROM Employees M
RIGHT JOIN Employees E ON E.ReportsTo = M.EmployeeID;

-- Muestra el nombre de cada producto y el nombre de su proveedor correspondiente (incluso si algunos productos no tienen proveedor).
SELECT P.ProductName AS NombreProducto, S.CompanyName AS Proveedor
FROM Suppliers S
RIGHT JOIN Products P ON S.SupplierID = P.SupplierID;

-- Muestra el nombre de cada empleado y su título (incluso si no tienen título registrado).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, COALESCE(E.Title, 'Título Desconocido') AS Título
FROM Employees E
RIGHT JOIN Employees M ON E.ReportsTo = M.EmployeeID;

-- Muestra el nombre de cada empleado y la cantidad total de productos que ha vendido (incluso si no han vendido productos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, SUM(ISNULL(OD.Quantity, 0)) AS TotalProductosVendidos
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
RIGHT JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);


-- Muestra el nombre de cada empleado y su título (incluso si no tienen título registrado).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, COALESCE(E.Title, 'Título Desconocido') AS Título
FROM Employees E
RIGHT JOIN Employees M ON E.ReportsTo = M.EmployeeID;

-- Muestra el nombre de cada empleado y la cantidad total de productos que ha vendido (incluso si no han vendido productos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, SUM(ISNULL(OD.Quantity, 0)) AS TotalProductosVendidos
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
RIGHT JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

-- Muestra el nombre de cada producto y su categoría correspondiente (incluso si no están categorizados).
SELECT P.ProductName AS NombreProducto, C.CategoryName AS Categoría
FROM Categories C
RIGHT JOIN Products P ON C.CategoryID = P.CategoryID;

--Muestra el nombre de cada empleado y la fecha de su primer pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MIN(O.OrderDate) AS PrimeraFechaPedido
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

-- Muestra el nombre de cada producto y la cantidad mínima en stock (incluso si no se ha establecido una cantidad mínima).
SELECT P.ProductName AS NombreProducto, COALESCE(P.ReorderLevel, 0) AS CantidadMínimaEnStock
FROM Products P
RIGHT JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- Muestra el nombre de cada cliente y el número total de pedidos que ha realizado (incluso si no ha realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
RIGHT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName;

-- Muestra el nombre de cada empleado y la fecha de su último pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MAX(O.OrderDate) AS ÚltimaFechaPedido
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

-- Muestra el nombre de cada producto y el nombre de su proveedor correspondiente (incluso si algunos productos no tienen proveedor).
SELECT P.ProductName AS NombreProducto, S.CompanyName AS Proveedor
FROM Suppliers S
RIGHT JOIN Products P ON S.SupplierID = P.SupplierID;

-- Muestra el nombre de cada producto y su precio unitario más bajo (incluso si no tienen precio registrado).
SELECT P.ProductName AS NombreProducto, MIN(ISNULL(P.UnitPrice, 0)) AS PrecioUnitarioMásBajo
FROM Products P
RIGHT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName;

-- Muestra el nombre de cada empleado y el nombre de su jefe (incluso si algunos empleados no tienen jefe).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, CONCAT(M.FirstName, ' ', M.LastName) AS Jefe
FROM Employees M
RIGHT JOIN Employees E ON E.ReportsTo = M.EmployeeID;

---Muestra el nombre de cada producto y el precio promedio de venta (incluso si no se han vendido productos).
SELECT P.ProductName AS NombreProducto, AVG(ISNULL(OD.UnitPrice, 0)) AS PrecioPromedioVenta
FROM Products P
RIGHT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName;

--- Muestra el nombre de cada producto y su categoría correspondiente (incluso si no están categorizados).
SELECT P.ProductName AS NombreProducto, C.CategoryName AS Categoría
FROM Categories C
RIGHT JOIN Products P ON C.CategoryID = P.CategoryID;

-- Muestra el nombre de cada empleado y la fecha de su primer pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MIN(O.OrderDate) AS PrimeraFechaPedido
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

--- Muestra el nombre de cada producto y la cantidad mínima en stock (incluso si no se ha establecido una cantidad mínima).
SELECT P.ProductName AS NombreProducto, COALESCE(P.ReorderLevel, 0) AS CantidadMínimaEnStock
FROM Products P
RIGHT JOIN Suppliers S ON P.SupplierID = S.SupplierID;

--- Muestra el nombre de cada cliente y el número total de pedidos que ha realizado (incluso si no ha realizado ningún pedido).
SELECT C.CompanyName AS NombreCliente, COUNT(O.OrderID) AS TotalPedidos
FROM Customers C
RIGHT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName;

--- Muestra el nombre de cada empleado y la fecha de su último pedido procesado (incluso si no han procesado pedidos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, MAX(O.OrderDate) AS ÚltimaFechaPedido
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

--- Muestra el nombre de cada producto y el nombre de su proveedor correspondiente (incluso si algunos productos no tienen proveedor).
SELECT P.ProductName AS NombreProducto, S.CompanyName AS Proveedor
FROM Suppliers S
RIGHT JOIN Products P ON S.SupplierID = P.SupplierID;

--- Muestra el nombre de cada empleado y la cantidad total de productos que ha vendido (incluso si no han vendido productos).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, SUM(ISNULL(OD.Quantity, 0)) AS TotalProductosVendidos
FROM Employees E
RIGHT JOIN Orders O ON E.EmployeeID = O.EmployeeID
RIGHT JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY CONCAT(E.FirstName, ' ', E.LastName);

--- Muestra el nombre de cada empleado y el nombre de su jefe (incluso si algunos empleados no tienen jefe).
SELECT CONCAT(E.FirstName, ' ', E.LastName) AS NombreEmpleado, CONCAT(M.FirstName, ' ', M.LastName) AS Jefe
FROM Employees M
RIGHT JOIN Employees E ON E.ReportsTo = M.EmployeeID;

--- Muestra el nombre de cada producto y la cantidad total vendida en todas las órdenes (incluso si algunos productos no se han vendido).
SELECT P.ProductName AS NombreProducto, SUM(ISNULL(OD.Quantity, 0)) AS TotalVendido
FROM Products P
RIGHT JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductName;


------------------------FULL JOIN-----------------------
--1Muestra los nombres y su categoría ordenados por nombre alfabaticamente
SELECT Products.ProductName nombre, Categories.CategoryName FROM Products
FULL JOIN Categories on Products.CategoryID = Categories.CategoryID
order by nombre

--2-Muestra las catogorías y los productos de cada categoria 
SELECT CategoryName, COUNT(*) AS total_productos
FROM (
    SELECT Products.CategoryID cat, Products.ProductName nombre, Categories.CategoryName FROM Products
FULL JOIN Categories on Products.CategoryID = Categories.CategoryID
) AS departamentos_combinados
GROUP BY CategoryName
order by CategoryName

--Encontrar todos los clientes y sus pedidos y ordenarlos por nombre
SELECT Customers.CustomerID, Customers.ContactName, Orders.OrderID
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID
order by ContactName

--obtener todos los productos con sus proveedores ordenados por compañía
SELECT Products.ProductName, Products.UnitPrice, Suppliers.CompanyName, Suppliers.Country
FROM Products
FULL JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
order by Suppliers.CompanyName

--Se muestra el número de pedidos por empleado ordenado por el total de pedidos
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS TotalPedidos
FROM Employees
FULL JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY TotalPedidos DESC

--lista de clientes junto con el número total de pedidos que han realizado, ordenados de mayor a menor número de pedidos
SELECT Customers.CustomerID, Customers.ContactName, COUNT(Orders.OrderID) AS TotalPedidos
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.ContactName
ORDER BY TotalPedidos ASC;



-- lista de empleados junto con el número total de territorios que les han sido asignados, ordenados de mayor a menor número de territorios asignados
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, COUNT(EmployeeTerritories.TerritoryID) AS TotalTerritorios
FROM Employees
full JOIN EmployeeTerritories ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY TotalTerritorios DESC;

--lista de productos junto con la cantidad total vendida de cada producto, ordenada de mayor a menor cantidad vendida
SELECT Products.ProductID, Products.ProductName, SUM([Order Details].Quantity) AS TotalVendido
FROM Products
FULL JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
FULL JOIN Orders ON [Order Details].OrderID = Orders.OrderID
GROUP BY Products.ProductID, Products.ProductName
ORDER BY TotalVendido DESC;

-- lista de productos que han sido vendidos más de 100 veces, junto con la cantidad total vendida de cada producto, ordenada de mayor a menor cantidad vendida
SELECT Products.ProductID, Products.ProductName, SUM([Order Details].Quantity) AS TotalVendido
FROM Products
FULL JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
FULL JOIN Orders ON [Order Details].OrderID = Orders.OrderID
GROUP BY Products.ProductID, Products.ProductName
HAVING SUM([Order Details].Quantity) > 100
ORDER BY TotalVendido DESC;

--lista de clientes junto con los productos que han comprado y la cantidad total de cada producto vendido a cada cliente
SELECT Customers.CustomerID, Customers.ContactName, Products.ProductName, SUM([Order Details].Quantity) AS TotalVendido
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID
FULL JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
FULL JOIN Products ON [Order Details].ProductID = Products.ProductID
GROUP BY Customers.CustomerID, Customers.ContactName, Products.ProductName
ORDER BY Customers.CustomerID, TotalVendido DESC;

-- Seleccionar el nombre del producto, el nombre del cliente y el total de ventas por producto y cliente
SELECT Products.ProductName, Customers.CompanyName, SUM ([Order Details].UnitPrice * [Order Details].Quantity) AS TotalSales
FROM Products 
full JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
FULL JOIN Orders ON [Order Details].OrderID = Orders.OrderID
FULL JOIN Customers ON Customers.CustomerID = Customers.CustomerID
GROUP BY Products.ProductName, Customers.CompanyName
ORDER BY TotalSales DESC;

-- lista de empleados junto con la cantidad total de territorios asignados a cada empleado, ordenada de mayor a menor cantidad de territorios asignados
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, COUNT(EmployeeTerritories.TerritoryID) AS TotalTerritorios
FROM Employees
FULL JOIN EmployeeTerritories ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
FULL JOIN Territories ON EmployeeTerritories.TerritoryID = Territories.TerritoryID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY TotalTerritorios DESC;

-- Seleccionar el nombre del empleado, el título del territorio y el número de territorios asignados a cada empleado
SELECT Employees.FirstName, Employees.LastName, Territories.TerritoryDescription, COUNT (EmployeeTerritories.TerritoryID) AS NumTerritorios
FROM Employees 
FULL JOIN EmployeeTerritories ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
FULL JOIN Territories ON EmployeeTerritories.TerritoryID = Territories.TerritoryID
GROUP BY Employees.FirstName, Employees.LastName, Territories.TerritoryDescription

--número de territorios por región, agrupado por el identificador y la descripción de la región
SELECT Region.RegionID, Region.RegionDescription, COUNT (Territories.TerritoryID) AS TotalTerritories
FROM Region
full JOIN Territories
ON Region.RegionID = Territories.RegionID
GROUP BY Region.RegionID, Region.RegionDescription
ORDER BY Region.RegionDescription ASC

-- lista de productos de categoría que han sido vendidos más de 50 veces, junto con la cantidad total vendida de cada producto dentro de su respectiva categoría.
SELECT Categories.CategoryName, Products.ProductName, SUM([Order Details].Quantity) AS TotalVendido
FROM [Order Details]
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY Categories.CategoryName, Products.ProductName
HAVING SUM([Order Details].Quantity) > 50
ORDER BY Categories.CategoryName, TotalVendido DESC;



	
--el inventario total disponible en cada fecha, tomando en cuenta las ventas y las cantidades en stock de los productos.	
SELECT
    Orders.OrderDate AS Fecha,
    SUM([Order Details].Quantity) AS TotalVendido,
    (P.UnitsInStock - SUM([Order Details].Quantity)) AS InventarioDisponible
FROM
    Orders
FULL JOIN
    [Order Details] ON Orders.OrderID = [Order Details].OrderID
FULL JOIN
    Products AS P ON [Order Details].ProductID = P.ProductID
GROUP BY
    Orders.OrderDate, P.UnitsInStock
ORDER BY
    Orders.OrderDate;	
	
--las regiones junto con el total de ventas para cada una de ellas, ordenadas de mayor a menor total de ventas
SELECT
    Region.RegionDescription AS Region,
    SUM([Order Details].Quantity * ([Order Details].UnitPrice - [Order Details].Discount)) AS TotalVentas
FROM
    Region
FULL JOIN
    Territories ON Region.RegionID = Territories.RegionID
FULL JOIN
    EmployeeTerritories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
FULL JOIN
    Employees ON EmployeeTerritories.EmployeeID = Employees.EmployeeID
FULL JOIN
    Orders ON Employees.EmployeeID = Orders.EmployeeID
INNER JOIN
    [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY
    Region.RegionDescription
ORDER BY
    TotalVentas DESC;
	
-- lista de territorios junto con el número de empleados en cada territorio, ordenados por el identificador del territorio
SELECT
    Territories.TerritoryID,
    Territories.TerritoryDescription,
    COUNT(ET.EmployeeID) AS NumeroEmpleados
FROM
    Territories
full JOIN
    EmployeeTerritories AS ET ON Territories.TerritoryID = ET.TerritoryID
GROUP BY
    Territories.TerritoryID, Territories.TerritoryDescription
ORDER BY
    Territories.TerritoryID;
	
--lista de territorios junto con el número de ventas realizadas por empleados en cada territorio, ordenados por el identificador del territorio
SELECT
    Territories.TerritoryID,
    Territories.TerritoryDescription,
    COUNT(DISTINCT Orders.OrderID) AS NumeroVentas
FROM
    Territories 
full JOIN
    EmployeeTerritories AS ET ON Territories.TerritoryID = ET.TerritoryID
full JOIN
    Employees ON ET.EmployeeID = Employees.EmployeeID
full JOIN
    Orders ON Employees.EmployeeID = Orders.EmployeeID
full JOIN
    [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY
    Territories.TerritoryID, Territories.TerritoryDescription
ORDER BY
    Territories.TerritoryID;	

--lista de territorios junto con el costo total de los productos vendidos en cada territorio, ordenados primero por el identificador del territorio y luego por el nombre del producto
SELECT
    Territories.TerritoryID,
    Territories.TerritoryDescription,
    Products.ProductName,
    SUM([Order Details].Quantity * Products.UnitPrice) AS CostoTotal
FROM
    Territories
full JOIN
    EmployeeTerritories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
full JOIN
    Employees ON EmployeeTerritories.EmployeeID = Employees.EmployeeID
full JOIN
    Orders ON Employees.EmployeeID = Orders.EmployeeID
full JOIN
    [Order Details] ON Orders.OrderID = [Order Details].OrderID
full JOIN
    Products ON [Order Details].ProductID = Products.ProductID
GROUP BY
    Territories.TerritoryID, Territories.TerritoryDescription, Products.ProductName
ORDER BY
    Territories.TerritoryID, Products.ProductName;





