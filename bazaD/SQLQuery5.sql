select * From wypozyczenie
--1
Select tytul,autor.nazwisko, czytelnik.nazwisko, convert(varchar,data_wypozyczenia,1) data_wypozyczenia, convert(varchar,data_zwrotu,5) data_zwrotu
From ksiazka inner join autor_ksiazki on ksiazka.id_ksiazka=autor_ksiazki.id_ksiazka inner join autor on autor_ksiazki.id_autor=autor.id_autor inner join egzemplarz on ksiazka.id_ksiazka=egzemplarz.id_ksiazka
inner join wypozyczenie on egzemplarz.id_egzemplarz=wypozyczenie.id_egzemplarz inner join czytelnik on wypozyczenie.id_czytelnik=czytelnik.id_czytelnik
--2
select nazwisko,imie
From czytelnik inner join wypozyczenie on czytelnik.id_czytelnik=wypozyczenie.id_czytelnik Where data_zwrotu Is NOT NULL

AVG(DATEDIFF(dd,data_wypozyczenia, data_zwrotu)) 

--4
Select imie, nazwisko,
case 
when data_zwrotu IS NOt Null then (dateDiff(dd,data_wypozyczenia, data_zwrotu)-90)*0.20
when data_zwrotu Is Null then (DateDiff(dd,data_wypozyczenia, Getdate())-90)*0.20
end kara
from wypozyczenie inner join czytelnik on wypozyczenie.id_czytelnik=czytelnik.id_czytelnik
--5
select nazwa, ilosc*cena, MONTH(data), Year(data) from 
wydawnictwo inner join faktura on wydawnictwo.id_wydawnictwo=faktura.id_wydawnictwo
inner join pozycja_faktury on faktura.id_faktura=pozycja_faktury.id_faktura
group by MONTH(data), YEAR(data)

select nazwa, ilosc*cena from 
wydawnictwo w1 inner join faktura f1 on w1.id_wydawnictwo=f1.id_wydawnictwo
inner join pozycja_faktury on f1.id_faktura=pozycja_faktury.id_faktura where MONTH(data)in
(select MONTH(data) from
wydawnictwo w2 inner join faktura f2 on w1.id_wydawnictwo=f2.id_wydawnictwo
inner join pozycja_faktury on f2.id_faktura=pozycja_faktury.id_faktura
where w1.id_wydawnictwo=w2.id_wydawnictwo and year(f1.data)=year(f2.data)
group by MONTH(data), YEAR(data)
)
--8
Select imie, nazwisko,
case 
when data_zwrotu IS NOt Null then (dateDiff(dd,data_wypozyczenia, data_zwrotu)-90)*0.20
when data_zwrotu Is Null then (DateDiff(dd,data_wypozyczenia, Getdate())-90)*0.20
end kara
from wypozyczenie inner join czytelnik on wypozyczenie.id_czytelnik=czytelnik.id_czytelnik

Select * From (
select id_czytelnik,
case 
when data_zwrotu Is Not Null then Sum((dateDiff(dd,data_wypozyczenia, data_zwrotu)-90)*0.20)
when data_zwrotu Is Null then Sum((DateDiff(dd,data_wypozyczenia, Getdate())-90)*0.20)
end kara
from wypozyczenie Group By id_czytelnik
)As result 


Select id_czytelnik, Sum((DATEDIFF(dd,data_wypozyczenia,data_zwrotu)-90)*0.20) From wypozyczenie Where data_zwrotu Is not null Group by id_czytelnik
Select id_czytelnik, Sum((DATEDIFF(dd,data_wypozyczenia,GETDATE())-90)*0.20)  From wypozyczenie where data_zwrotu Is null Group by id_czytelnik
--7
Select * From pozycja_faktury
Select id_faktura, rok_wydania, max(cena*ilosc) From pozycja_faktury Group By rok_wydania, id_faktura
--6
select * From wypozyczenie
Select Count(id_pracownik_wyp) From wypozyczenie Group By id_pracownik_wyp
Select AVG(a) From(Select Count(id_pracownik_wyp)a From wypozyczenie Group By id_pracownik_wyp)t;
Select AVG(a) From(Select count(id_pracownik_wyp)a From wypozyczenie Group by id_pracownik_wyp)b;
Select id_pracownik_wyp From wypozyczenie
Where(Select Count(id_pracownik_wyp) From wypozyczenie Group By id_pracownik_wyp)<All (Select AVG(a) From(Select count(id_pracownik_wyp)a From wypozyczenie Group by id_pracownik_wyp)b);
Select id_pracownik_wyp From wypozyczenie Group By id_pracownik_wyp
--9
Select * From czytelnik Order By nazwisko, imie Desc 
--10
Select AVG(wynagrodzenie) From pracownik
--11
Select tytul From ksiazka inner join autor_ksiazki on ksiazka.id_ksiazka=autor_ksiazki.id_ksiazka inner join autor on autor_ksiazki.id_autor=autor.id_autor Where imie Like '%Eliza%' AND nazwisko Like '%Orzeszkowa%'
--12
Select COUNT(id_egzemplarz) From egzemplarz inner join ksiazka on egzemplarz.id_ksiazka=ksiazka.id_ksiazka Where tytul Like '%Potop%'
--13
Select * From autor_ksiazki
Select id_autor From autor_ksiazki Group By id_autor Having COUNT(id_ksiazka)>2
--14
Select tytul, rok_wydania, nazwa From ksiazka inner join egzemplarz on ksiazka.id_ksiazka=egzemplarz.id_ksiazka inner join wydawnictwo on egzemplarz.id_wydawnictwo=wydawnictwo.id_wydawnictwo
--15
Select id_egzemplarz ,COUNT(id_egzemplarz) From wypozyczenie Group by id_egzemplarz
--16


