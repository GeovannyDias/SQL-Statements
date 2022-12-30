create database Company_DW;
go
use Company_DW
go

CREATE TABLE OrderDetails(
	OrderLineID int NOT NULL, /*IDENTITY(1,1) → incremento de uno en uno*/ -- OrderLineID int identity(1,1)
	Description nvarchar(100) NOT NULL,
	DescriptionFull nvarchar(200) NOT NULL,
	PackageTypeID int NOT NULL,
	Quantity int NOT NULL,
	UnitPrice decimal(18, 2) NULL,
	TaxRate decimal(18, 3) NOT NULL,
	PickedQuantity int NOT NULL,
	LastEditedWhen [datetime2](7) NOT NULL,
 CONSTRAINT PK_OrderDetail PRIMARY KEY CLUSTERED (OrderLineID) /*clustered → indice mostrar campos que seran clave primaria (id1,id2,id3)*/
 )
GO

select * from OrderDetails;

-- drop table OrderDetails;
-- delete from OrderDetails; OrderLineID