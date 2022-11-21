use w65551_FIRMA

create table PRACOWNICY(
identyfikator int identity constraint pracownicy_primary_key primary key,
imie varchar(15),
nazwisko varchar(35),
stanowisko varchar(25),
kierownik int,
data_zatrud date,
pensja decimal(10,2),
prowizja decimal(10,2),
KOD_dzialu int constraint prac_foreign_key references DZIALY on delete cascade
)

insert into DZIALY values(10,'Ksiegowoswc', 'Rzeszow')
insert into DZIALY values(20,'Badan', 'Krakow')
insert into DZIALY values(30,'Sprzedaz', 'Zamosc')
insert into DZIALY values(40,'Innowacje', 'Wroclaw')

select * from Dzialy

SET IDENTITY_INSERT pracownicy OFF;

INSERT INTO PRACOWNICY VALUES ('Kowalski','Jan','Prezes',NULL,'2002-01-01',7000.20,NULL,10);

INSERT INTO PRACOWNICY VALUES ('G³owacki','Mateusz','Kierownik',1,'2002-05-01',3210,150,40);

INSERT INTO PRACOWNICY VALUES ('Sikorski','Adam','Kierownik',1,'2002-05-01',3210,250,20);

INSERT INTO PRACOWNICY VALUES ('Nowak','Stanislaw','Kierownik',1,'2002-05-01',3210,350,30);

INSERT INTO PRACOWNICY VALUES ('Wisniewski','Marcin','Sprzedawca',4,'2007-06-27',1210,250,30);

INSERT INTO PRACOWNICY VALUES ('Kochanowski','Juliusz','Sprzedawca',4,'2005-11-22',1210,260,30);

INSERT INTO PRACOWNICY VALUES ('Charysz','Szczepan','Sprzedawca',4,'2006-12-01',1210,200,30);

INSERT INTO PRACOWNICY VALUES ('Kordecki','Adam','Laborant',3,'2002-12-11',2210,150,20);

INSERT INTO PRACOWNICY VALUES ('Kopacz','Ewa','Laborant',3,'2003-04-21',2110,150,20);

INSERT INTO PRACOWNICY VALUES ('Ziolkowska','Krystyna','Laborant',3,'2002-07-10',2510,100,20);

INSERT INTO PRACOWNICY VALUES ('Szela','Katarzyna','Konsultant',2,'2002-05-10',2810,100,40);

INSERT INTO PRACOWNICY VALUES ('Kêdzior','Jakub','Analityk',2,'2002-05-10',2710,120,40);

INSERT INTO PRACOWNICY VALUES ('Ziobro','Marlena','Konsultant',2,'2003-02-13',2610,200,40);

INSERT INTO PRACOWNICY VALUES ('Pigwa','Genowefa','Ksiegowa',1,'2002-01-02',2000,NULL,10);

--zad4
--alter table pracownicy add Adres varchar(10)
--zad5
--alter table pracownicy drop column Adres
--zad6
--update Pracownicy set pensja=pensja+100 where kod_dzialu=10 
--zad7
--exec sp_rename 'Pracownicy.nazw','nazwisko'
--exec sp_rename 'Pracownicy.nazwisko','imie'
--zad8
--exec sp_rename 'dzialy','DEPARTAMENTY'
--zad9
--delete from Pracownicy where identyfikator=14
--zad10
alter table pracownicy add constraint zarob check (pensja>=1200)

update pracownicy set pensja =1300 where identyfikator =5 

select * from Pracownicy
