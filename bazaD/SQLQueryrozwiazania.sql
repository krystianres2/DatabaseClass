Select * From autor_ksiazki
Select id_ksiazka From autor_ksiazki Group By id_ksiazka having count(id_autor)<2;

Select autor_ksiazki.id_ksiazka From autor_ksiazki inner join ksiazka on autor_ksiazki.id_ksiazka=ksiazka.id_ksiazka Group By autor_ksiazki.id_ksiazka having count(id_autor)<2;
--poprawne
Select tytul From ksiazka k1 where k1.id_ksiazka in(Select autor_ksiazki.id_ksiazka From autor_ksiazki inner join ksiazka on autor_ksiazki.id_ksiazka=ksiazka.id_ksiazka Group By autor_ksiazki.id_ksiazka having count(id_autor)<2);
--

-- tytuly ksiazek ktore nie byly wypozyczone

--poprawne
Select tytul From ksiazka inner join egzemplarz on ksiazka.id_ksiazka=egzemplarz.id_ksiazka where id_egzemplarz in(Select distinct id_egzemplarz From egzemplarz
except
Select distinct id_egzemplarz From wypozyczenie)
--

select k.tytul from ksiazka as k
where k.tytul not in (select distinct(k.tytul) from wypozyczenie as w
left join egzemplarz as e
on w.id_egzemplarz = e.id_egzemplarz
left join ksiazka as k
on e.id_ksiazka = k.id_ksiazka)
and k.id_ksiazka in (select distinct(id_ksiazka) from egzemplarz)
Select * From wypozyczenie
Select * From egzemplarz
Select * From ksiazka


Select distinct id_egzemplarz From egzemplarz
except
Select distinct id_egzemplarz From wypozyczenie

select k.tytul from ksiazka as k
where k.tytul not in (select distinct(k.tytul) from wypozyczenie as w
left join egzemplarz as e
on w.id_egzemplarz = e.id_egzemplarz
left join ksiazka as k
on e.id_ksiazka = k.id_ksiazka)----
Select tytul From ksiazka inner join egzemplarz on ksiazka.id_ksiazka=egzemplarz.id_ksiazka 

Select distinct id_ksiazka From egzemplarz where id_egzemplarz in(Select distinct id_egzemplarz From wypozyczenie)

--poprawne
Select tytul From ksiazka where id_ksiazka not in(Select distinct id_ksiazka From egzemplarz where id_egzemplarz in(Select distinct id_egzemplarz From wypozyczenie))
--

