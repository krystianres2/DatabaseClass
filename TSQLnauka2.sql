Select * From PRACOWNICY 
select * From DEPARTAMENT
create proc zad1 (@nazwa varchar(20))
as
begin
Delete From PRACOWNICY where Id_depart=(Select Id_depart From DEPARTAMENT where Nazwa=@nazwa) 
end

exec zad1 'Ksiegowosc'

create trigger zad2 on PRACOWNICY 
after insert 
as begin
if (Select count(Id_pracownika) From PRACOWNICY where Kierownik=(Select Kierownik From inserted))>5
begin
delete From PRACOWNICY where Id_pracownika=(Select Id_pracownika From inserted)
print 'Kierownik moze miec 5 podwladnych'
end
end

insert into PRACOWNICY(Id_pracownika,Nazwisko,Imie,Kierownik) VALUES(15,'Nowak', 'Jan',1)
insert into PRACOWNICY(Id_pracownika,Nazwisko,Imie,Kierownik) VALUES(16,'Nowak', 'Jan',1)

drop trigger zad2

update PRACOWNICY set Zarobki=Zarobki*1.1 where Id_pracownika=2

select * From PRACOWNICY
declare @zarobki decimal(10,2)
declare @id int
declare @staz int
declare kur1 cursor for select Id_pracownika From PRACOWNICY
open kur1
fetch from kur1 into @id
while @@FETCH_STATUS=0
begin
set @staz=(select DATEDIFF(yy, Data_zatrud, GETDATE()) From PRACOWNICY where Id_pracownika=@id)
Update PRACOWNICY set Zarobki=
case
when @staz>=50 then Zarobki*1.5
when @staz BETWEEN 40 AND 49 then Zarobki*1.4
when @staz BETWEEN 30 AND 39 then Zarobki*1.3
when @staz BETWEEN 20 AND 29 then Zarobki*1.2
when @staz BETWEEN 10 AND 19 then Zarobki*1.1
when @staz BETWEEN 0 AND 9 then Zarobki
end where Id_pracownika=@id
fetch next from kur1 into @id
end
close kur1
deallocate kur1

select * From PRACOWNICY
 

 Create table USUNIECI_PRACOWNICY(
 imie varchar(30),
 nazwisko varchar(30),
 stanowisko varchar(30),
 data_zatrudnienia date,
 kierownik int,
 kiedy_usuniety date
 )
 
 Delete  From PRACOWNICY where Id_pracownika=1

 alter trigger zad22 on PRACOWNICY
 after delete
 as begin
 insert into  USUNIECI_PRACOWNICY
 VALUES((Select imie From deleted),(Select nazwisko From deleted), (Select Stanowisko From deleted),
(Select Data_zatrud From deleted), (Select Kierownik From deleted), CURRENT_TIMESTAMP )
 end
 drop trigger zad22

 Delete  From PRACOWNICY where Id_pracownika =2
 Select * From USUNIECI_PRACOWNICY 

