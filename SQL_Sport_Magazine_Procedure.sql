--1. �������� ��������� ���������� ������ ���������� � ���� �������
USE SportMagazine1
GO

CREATE PROCEDURE All_Product
AS
SELECT p.NAME_PRODUCT AS [�������� ��������],
	   p.QUANTITY AS [���������� ��������],
	   p.COST_PRICE AS [���� �������],
	   p.PRICE AS [���� ����������],
	   m.MANUFACTURER AS [�������������],
	   t.TYPE_OF_GOODS AS [�������� ������]
FROM Product p, Manufacturer m, TypeOfGoods t
WHERE m.id = p.id AND m.id = t.id;
GO
EXEC All_Product;

--2. �������� ��������� ���������� ������ ���������� � ������ ����������� ����. 
--��� ������ ��������� � �������� ���������. ��������, ���� � �������� ��������� ������� �����, ����� �������� ��� �����, 
--������� ���� � �������
USE SportMagazine
GO

CREATE PROCEDURE All_Info_Group_Product
	@Type_Of_Goods varchar(50)
AS
SELECT p.NAME_PRODUCT AS [�������� ��������],
	   p.QUANTITY AS [���������� ��������],
	   p.COST_PRICE AS [���� �������],
	   p.PRICE AS [���� ����������],
	   m.MANUFACTURER AS [�������������],
	   t.TYPE_OF_GOODS AS [�������� ������]
FROM Product p, Manufacturer m, TypeOfGoods t
WHERE m.id = p.id AND m.id = t.id AND t.TYPE_OF_GOODS = @Type_Of_Goods;
GO
EXEC All_Info_Group_Product;

EXECUTE All_Info_Group_Product @Type_Of_Goods = '�����'

--3. �������� ��������� ���������� ���-3 ����� ������ ��������. ���-3 ������������ �� ���� �����������
USE SportMagazine
GO


CREATE PROCEDURE Top3_Old_Client
AS
SELECT TOP 3 p.NAME_PERSON AS [Name],
	   p.SURNAME_PERSON AS [Surname],
	   p.PATRONYMIC_PERSON AS [Patronymic],
	   s.SEX AS [Sex],
	   c.EMAIL AS [E-mail],
	   c.TELEPHONE AS [Telephone],
	   c.DISCOUNT AS [Discount],
	   c.MAILING_LIST AS [Mailing list availability],
	   c.DOR AS [Registration date]
FROM Person as p join Client as c on p.ID = c.PERSONID join Sex as s on p.SEXID = s.ID
GROUP BY p.NAME_PERSON, 
		 p.SURNAME_PERSON,
		 p.PATRONYMIC_PERSON,
		 s.SEX, 
		 c.EMAIL,
		 c.TELEPHONE, 
		 c.DOR,
		 c.DISCOUNT,
		 c.MAILING_LIST
ORDER BY c.DOR; 
GO

EXEC Top3_Old_Client;

--4. �������� ��������� ���������� ���������� � ����� �������� ��������. 
--���������� ������������ �� ����� ����� ������ �� �� �����
USE SportMagazine
GO

CREATE PROCEDURE Top1_Staff
AS
SELECT TOP 1 p.NAME_PERSON AS [���],
	   p.SURNAME_PERSON AS [�������],
	   p.PATRONYMIC_PERSON AS [��������],
	   s.SEX AS [���],
	   sa.SELLING_PRICE AS [���� ����������],
	   st.POSITION AS [���������],
	   st.DATE_OF_RECEIPT AS [���� ������ �� ������],
	   st.SALARY AS [��������],
	   SUM(sa.SELLING_PRICE) AS [�� ����� ����� ������]
FROM Person p, Staff st, Sale sa, Sex s
WHERE p.id = st.id AND sa.id = st.id AND s.id = p.id AND st.POSITION = '���������'
GROUP BY p.NAME_PERSON, 
		 p.SURNAME_PERSON,
		 p.PATRONYMIC_PERSON,
		 s.SEX, 
		 sa.SELLING_PRICE,
		 st.POSITION, 
		 st.DATE_OF_RECEIPT,
		 st.SALARY
ORDER BY SUM(sa.SELLING_PRICE) DESC;
GO
EXEC Top1_Staff;

--5. �������� ��������� ��������� ���� �� ���� ���� ����� ���������� ������������� � �������.
--�������� ������������� ��������� � �������� ���������. �� ������ ������ �������� ���������
--������ ������� yes � ��� ������, ���� ����� ����, � no, ���� ������ ���
USE SportMagazine
GO

CREATE PROCEDURE Search_Produkt_Availability 
   @Manufacturer varchar(50),
   @Quantity INT = 0
AS
SELECT @Quantity = p.QUANTITY
FROM Manufacturer m, Product p
WHERE p.id = m.id AND m.Manufacturer = @Manufacturer
IF (@Quantity > 0)
PRINT ('YES')
ELSE
PRINT ('NO')
GO
EXEC Search_Produkt_Availability;

EXECUTE Search_Produkt_Availability  @Manufacturer = 'NIKE'

--6. �������� ��������� ���������� ���������� � ����� ���������� ������������� ����� �����������.
--������������ ����� ����������� ������������ �� ����� ����� ������
USE SportMagazine
GO

CREATE PROCEDURE Search_Produkt_Popular 
AS
SELECT TOP 1 m.Manufacturer AS [�������������],
	   SUM(s.QUANTITY_SALE) AS [���������� ����������]
FROM Manufacturer m, Product p, Sale s
WHERE m.id = p.id AND p.id = s.id
GROUP BY m.Manufacturer
ORDER BY SUM(s.QUANTITY_SALE) DESC;
GO
EXEC Search_Produkt_Popular;

--7. �������� ��������� ������� ���� ��������, ������������������ ����� ��������� ����. 
--���� ��������� � �������� ���������. ��������� ���������� ���������� ��������� �������.
USE SportMagazine
GO

CREATE PROCEDURE Delete_Client 
	@Data DATE = NULL
AS
DELETE FROM Sale
Where Sale.ID in (SELECT s.ID 
					FROM Client as c join Sale as s on c.ID = s.CLIENTID
					where c.DOR > @Data);

DELETE FROM Client
Where Client.DOR > @Data

GO

EXEC Delete_Client ;

EXECUTE Delete_Client  @Data = '2010-06-15'