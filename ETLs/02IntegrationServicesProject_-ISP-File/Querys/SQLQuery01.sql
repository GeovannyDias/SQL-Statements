create database Test_DW --Data Wherehouse -- (Base de datos multidimensional - DIM = dimensión)
go

use Test_DW
go

-- Crear la Dimensión test (Inicio de proceso)

create table DIM_TEST
(
	TestId int identity (1,1) not null,
	Record int not null,
	Description varchar(200),
	Name varchar(100),
	Value1 varchar(10),
	Value2 varchar(10),
	Country varchar(50),
	Detail varchar(100),
	UploadDate DateTime default getdate(),
	StartData DateTime default getdate(),
	EndDate DateTime
)
go

select * from DIM_TEST;
-- Truncate table DIM_TEST; // quita todas las filas de una tabla, pero permanecen la estructura y sus columnas, las restricciones, los índices, etc, // También resetea TestId desde cero

-- Fin del proceso

create table TBL_RECORD_PROCESS
(
	Id int identity (1,1) not null,
	Process varchar(50),
	Package varchar(100),
	Result varchar(20),
	StartData DateTime default getdate(),
	EndDate DateTime,
	RowsProcessed int
)
go

select * from DIM_TEST;
select * from TBL_RECORD_PROCESS;
