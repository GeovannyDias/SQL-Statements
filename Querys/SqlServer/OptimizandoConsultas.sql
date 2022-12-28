 set statistics time on; -- Consultas eficientes con estadísticas de tiempo // SQL Server Execution Times: CPU time = 16 ms,  elapsed time = 29 ms.
-- set statistics io on; -- Consultas eficientes con estadísticas de entrada y salida (I/O) // logical reads 12 // Temas de disco, causando embotellamiento en el procesamiento de entrada y salida

use WideWorldImporters;
go

-- select * from Sales.OrderLines;

-- Solución #1: Cuando la columna OrderLineID es la columna de identidad.
select * from Sales.OrderLines
	where OrderLineID in (
		select min(OrderLineID) as OrderLineID
		from Sales.OrderLines
		union all
		select max(OrderLineID) as OrderLineID
		from Sales.OrderLines
	);
go

-- Solución #2: Cuando ordenamos por cualquier columna. En este caso  ordenamos por OrderLines
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


-- Solución #3: Usando funciones de rango (Ranking Functions).

select * from (
		select * ,
		row_number() over (order by OrderLineID asc) as TopRow,
		row_number() over (order by OrderLineID desc) as BottomRow
		from Sales.OrderLines
	) as t
	where TopRow = 1 or BottomRow = 1
	order by TopRow
go


-- Cual de estas 3 consultas es la más eficiente, para mostrar la primera y última fila de una table
-- basada en una condición.

-- Include Actual Execution (Ctrl + M).





/*
*/