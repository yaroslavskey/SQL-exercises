
--�������� ��������������� ������� � ��������� ������������� ��������� ��������
--� ������� execution plans (������ ����������) ��� ���� ��������.

--1. �������� 2 clustered (����������������) ������� ��� ��� ������, ��� ��� ����������.
--��� ��� ��� ���� ������ � ���� ��� �������� ���������� �����,
--��� ������ ���������� ������, ������� ������ ��� ����� ������.
USE SportMagazine;
GO

ALTER TABLE HistoryStaff
DROP CONSTRAINT [PK__HistoryS__3214EC27637CEA74];

CREATE UNIQUE CLUSTERED INDEX IdHS ON HistoryStaff (ID ASC);

SELECT POSITION AS [�������], DATE_OF_RECEIPT AS [����]
FROM HistoryStaff HS
WHERE HS.ID = 3
----------------------------------------------------------------------------------------
USE SportMagazine;
GO

DROP INDEX [IdHS] ON HistoryStaff;  

CREATE UNIQUE CLUSTERED INDEX IdHiSt ON HistoryStaff (SALARY ASC);

SELECT POSITION AS [�������], SALARY AS [��]
FROM HistoryStaff HS
WHERE SALARY > 100

--2. �������� 2 nonclustered (������������������) ������� ��� ��� ������, ��� ��� ����������.
USE SportMagazine;
GO
CREATE NONCLUSTERED INDEX TelephoneIndex ON Client (TELEPHONE ASC);

SELECT TELEPHONE AS [�������]
FROM Client c
WHERE c.TELEPHONE LIKE '99%'
----------------------------------------------------------------------------------------
USE SportMagazine;
GO
CREATE NONCLUSTERED INDEX PriceIndex ON Product (Price ASC);

SELECT Price AS [����]
FROM Product p
WHERE p.PRICE > 450

--3. �������� 2 composite (�����������) ������� � ������ ��������� ���� ������.
USE SportMagazine;
GO
CREATE NONCLUSTERED INDEX TelephoneDorIndex ON Client (TELEPHONE ASC, DOR ASC);

SELECT TELEPHONE AS [�������], DOR [���� �����������]
FROM Client c
WHERE c.TELEPHONE LIKE '99%' AND DOR > '2015-01-01'
----------------------------------------------------------------------------------------
USE SportMagazine;
GO
CREATE NONCLUSTERED INDEX QuantityDateIndex ON Sale (QUANTITY_SALE ASC, DATE_OF_SALE ASC);

SELECT QUANTITY_SALE AS [����������], DATE_OF_SALE [���� �������]
FROM Sale s
WHERE s.QUANTITY_SALE >= 2 AND DATE_OF_SALE > '2021-12-31'

--4. �������� 2 indexes with included columns (������� � ����������� ���������). 
USE SportMagazine;
GO
CREATE NONCLUSTERED INDEX TelephoneDorDiscountIndex ON Client (TELEPHONE ASC, DOR ASC) INCLUDE (DISCOUNT);

SELECT TELEPHONE AS [�������], DOR [���� �����������], DISCOUNT [�������]
FROM Client c
WHERE c.TELEPHONE LIKE '99%' AND DOR > '2015-01-01'
----------------------------------------------------------------------------------------
USE SportMagazine;
GO
CREATE NONCLUSTERED INDEX QuantityDateSelPriceIndex ON Sale (QUANTITY_SALE ASC, DATE_OF_SALE ASC) INCLUDE (SELLING_PRICE);

SELECT QUANTITY_SALE AS [����������], DATE_OF_SALE [���� �������], SELLING_PRICE [���� �������]
FROM Sale s
WHERE s.QUANTITY_SALE >= 2 AND DATE_OF_SALE > '2021-12-31'

--5. �������� 2 filtered indexes (��������������� �������). 
USE SportMagazine;
GO
CREATE INDEX TDiscountIndex ON Client (DISCOUNT) WHERE DISCOUNT >= 25;

USE SportMagazine;
GO

USE SportMagazine;
GO
SELECT *
FROM Client c
WHERE c.DISCOUNT >= 25 AND c.DOR > '2008-01-01'


USE SportMagazine;
GO
CREATE INDEX DDiscountIndex ON Product (QUANTITY) WHERE QUANTITY >= 25;

USE SportMagazine;
GO
--SET SHOWPLAN_ALL ON 
USE SportMagazine;
GO
SELECT *
FROM Product p
WHERE p.QUANTITY >= 25 AND p.PRICE > 10
--SET SHOWPLAN_ALL OFF