--1. ���������������� ������� ���������� ���������� ���������� �����������.
USE SportMagazine;
GO
CREATE FUNCTION NumberOfUniqueClients () 
RETURNS INT 
AS
BEGIN 
	DECLARE @ClientQuantity INT
	SELECT @ClientQuantity = COUNT(DISTINCT EMAIL) --������ ���� ����������, ����� ������������ ��� � �������
	FROM Client
RETURN @ClientQuantity					 
END

--2. ���������������� ������� ���������� ������� ���� ������ ����������� ����. 
--��� ������ ��������� � �������� ���������. ��������, ������� ���� �����.
USE SportMagazine;
GO

CREATE FUNCTION AvgPrice(@TypeProduct NVARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @Avg_price INT;
	SET @Avg_price = (SELECT avg(Price)
					  FROM Product p, TypeOfGoods t  
					  WHERE t.ID = p.TYPE_OF_GOODSID AND TYPE_OF_GOODS = @TypeProduct);
RETURN @Avg_price
END;
GO

SELECT dbo.AvgPrice('�����');

--3. ���������������� ������� ���������� ������� ���� ������� �� ������ ����, ����� �������������� �������.
USE SportMagazine;
GO

CREATE FUNCTION AvgPriceToDate()
RETURNS TABLE
AS
--BEGIN
	RETURN (SELECT DATE_OF_SALE, AVG(SELLING_PRICE) AS AvgPriceToDate
			FROM Sale
			GROUP BY DATE_OF_SALE);
--END;
GO

SELECT * FROM dbo.AvgPriceToDate();


--4. ���������������� ������� ���������� ���������� � ��������� ��������� ������. 
--�������� ����������� ���������� ���������� ������: ���� �������.
USE SportMagazine;
GO

CREATE FUNCTION GoodSalesEnd()
RETURNS TABLE
AS
RETURN (SELECT TOP 1 NAME_PRODUCT, QUANTITY, COST_PRICE, PRICE, TYPE_OF_GOODS, MANUFACTURER
        FROM Product p, Manufacturer m, TypeOfGoods t, Sale s
		WHERE m.id = p.id AND m.id = t.id AND s.ID = p.ID
        ORDER BY s.DATE_OF_SALE DESC);
GO

USE SportMagazine;
GO
SELECT * FROM dbo.GoodSalesEnd();

--5. ���������������� ������� ���������� ���������� � �������� ���� ������� ����������� �������������.
--��� ������ � �������� ������������� ���������� � �������� ����������.
USE SportMagazine;
GO

CREATE FUNCTION GoodOfTypeManufacterer(@TypeGood nvarchar(50), @Manufacturer nvarchar(50))
RETURNS TABLE
AS
RETURN (SELECT NAME_PRODUCT, QUANTITY, COST_PRICE, PRICE, TYPE_OF_GOODS, MANUFACTURER
        FROM Product p, Manufacturer m, TypeOfGoods t  
		WHERE m.id = p.id AND m.id = t.id AND t.TYPE_OF_GOODS = @TypeGood AND m.MANUFACTURER = @Manufacturer);
GO

USE SportMagazine;
GO
SELECT * FROM dbo.GoodOfTypeManufacterer('�����','HUMEL');

--6. ���������������� ������� ���������� ���������� � �����������, ������� � ���� ���� ���������� 45 ���
USE SportMagazine;
GO
--���� ���� �� ������� ������
CREATE FUNCTION Client45()
RETURNS TABLE
AS
	RETURN (SELECT p.NAME_PERSON AS [Name],
				   p.SURNAME_PERSON AS [Surname],
				   p.PATRONYMIC_PERSON AS [Patronymic],
				   s.SEX AS [Sex],
				   c.EMAIL AS [E-mail],
				   c.TELEPHONE AS [Telephone],
				   c.DOR AS [���� ��������]
			FROM Person as p join Client as c on p.ID = c.PERSONID join Sex as s on p.SEXID = s.ID
			WHERE (DATEPART ( year , getdate() ))-(DATEPART(year , DOR))=45);
GO

USE SportMagazine;
GO
SELECT* FROM dbo.Client45();
 





