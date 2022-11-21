USE w65551_FIRMA

Select * FROM DEPARTAMENTY
Select * FROM PRACOWNICY
--1
Select [NAZWISKO], [STANOWISKO]
from [dbo].[PRACOWNICY]
--2
select max(pensja)-min(pensja) roznica
from PRACOWNICY 
--8
Select Nazwa From DEPARTAMENTY Where Lokalizacja='Krakow'
--3
Select count(identyfikator) from Pracownicy 
Select count(identyfikator) from Pracownicy Where stanowisko='Sprzedawca'
--4
Select nazwisko,imie From Pracownicy Where pensja>3000
--5
Select top 1 data_zatrud From Pracownicy Order by data_zatrud 
--6
Select nazwisko FROM Pracownicy where data_zatrud Like '%-05-%'
Select DATEDIFF(yy,min(DATA_ZATRUD),GETDATE()) as roznica from PRACOWNICY
--SELECT YEAR(min(DATA_ZATRUD))-YEAR(2022-10-18)) as roznica from PRACOWNICY
--7
--Select nazwisko FROM Pracownicy, DEPARTAMENTY WHERE Pracownicy.KOD_dzialu=DEPARTAMENTY.KOD_dzialu AND DEPARTAMENTY.Nazwa='Sprzedaz'
Select nazwisko,nazwa from PRACOWNICY inner join DEPARTAMENTY on PRACOWNICY.KOD_dzialu=DEPARTAMENTY.KOD_dzialu
Select nazwisko,nazwa From Pracownicy inner join Departamenty on Pracownicy.KOD_dzialu=Departamenty.KOD_dzialu Where Nazwa='Sprzedaz'
--w ka¿dym dziale ilu pracownikow
select count(IDENTYFIKATOR), KOD_dzialu from PRACOWNICY group by KOD_dzialu 
--podaj ile pracowników w dziale z wyj¹tkiem dzia³u 20
select count(IDENTYFIKATOR), KOD_dzialu from PRACOWNICY where KOD_dzialu!=20 group by KOD_dzialu 
--podaj nazwe dzia³u w którym jest co najmniej 4 pracownikow 
select nazwa from DEPARTAMENTY inner join Pracownicy on DEPARTAMENTY.KOD_dzialu=Pracownicy.KOD_dzialu group by nazwa having count(IDENTYFIKATOR)>=4

--który pracownik ma najd³u¿sze nazwisko(znalezc maksymalna dlugosc nazwisko)
--select top 1 nazwisko from Pracownicy ORDER  by LEN(nazwisko) DESC
Select nazwisko From Pracownicy WHERE LEN(nazwisko) = (Select max(len(nazwisko)) From Pracownicy)

--kto zarabia najwiêcej
select nazwisko from Pracownicy
where pensja=(select max(PENSJA) from PRACOWNICY)

--podaj kierownika która zarz¹dza dzia³em z krakowa
Select nazwisko, Lokalizacja From Pracownicy inner join DEPARTAMENTY on PRACOWNICY.KOD_dzialu=DEPARTAMENTY.KOD_dzialu where stanowisko='Kierownik' AND Lokalizacja='Krakow'

--podaj nazwê dzia³u w którym pracuje co najmniej 3 pracowników
select nazwa from DEPARTAMENTY inner join Pracownicy on DEPARTAMENTY.KOD_dzialu=Pracownicy.KOD_dzialu group by nazwa having count(IDENTYFIKATOR)>=3

--podaj nazwiska pracowników którzy zarabiaj¹ miêdzy 2000 a 3000 tys (between)
Select nazwisko From Pracownicy Where pensja Between 2000 AND 3000

--podaj nazwisko pracownika który nie ma prowizji
Select nazwisko From Pracownicy Where prowizja IS NULL

--podaj nazwisko pracownika ktory najdluzej pracuje
Select top 1 nazwisko From Pracownicy Order BY data_zatrud 
