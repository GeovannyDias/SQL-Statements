 set statistics time on; -- Consultas eficientes con estad�sticas de tiempo // SQL Server Execution Times: CPU time = 16 ms,  elapsed time = 29 ms.
-- set statistics io on; -- Consultas eficientes con estad�sticas de entrada y salida (I/O) // logical reads 12 // Temas de disco, causando embotellamiento en el procesamiento de entrada y salida

use WideWorldImporters;
go

-- select * from Sales.OrderLines;

-- Soluci�n #1: Cuando la columna OrderLineID es la columna de identidad.
select * from Sales.OrderLines
	where OrderLineID in (
		select min(OrderLineID) as OrderLineID
		from Sales.OrderLines
		union all
		select max(OrderLineID) as OrderLineID
		from Sales.OrderLines
	);
go

-- Soluci�n #2: Cuando ordenamos por cualquier columna. En este caso  ordenamos por OrderLines
select * from Sales.OrderLines
	where OrderLineID in (
		select top 1 OrderLineID
		from Sales.OrderLines
		order by OrderLineID
	)
	or OrderLineID in (
		select top 1 OrderLineID
		from Sales.OrderLines
		order by OrderLineID desc
	);
go


-- Soluci�n #3: Usando funciones de rango (Ranking Functions).

select * from (
		select * ,
		row_number() over (order by OrderLineID asc) as TopRow,
		row_number() over (order by OrderLineID desc) as BottomRow
		from Sales.OrderLines
	) as t
	where TopRow = 1 or BottomRow = 1
	order by TopRow
go


-- Cual de estas 3 consultas es la m�s eficiente, para mostrar la primera y �ltima fila de una table
-- basada en una condici�n.

-- Include Actual Execution (Ctrl + M).





/*
*/