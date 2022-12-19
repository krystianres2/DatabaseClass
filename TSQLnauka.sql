Select * From PRACOWNICY
Create proc zad1 
as
update PRACOWNICY set Zarobki=
case 
when zarobki<3000 then zarobki*1.2
when zarobki>3000 then zarobki*0.9
else zarobki
end
exec zad1
Select * From PRACOWNICY

create proc zad2(@d int, @data date output) 
as 
select @data=min(Data_zatrud) From PRACOWNICY where Id_depart=@d

declare @data2 date
exec zad2 20,@data2 output
select @data2
--
create proc zad22(@d int)
as
begin
declare @data date
select @data=min(Data_zatrud) From PRACOWNICY where Id_depart=@d
return @data 
end
--
declare @data2 date
exec @data2=zad22 @d=20
select @data2

Select * From PRACOWNICY
Select * From DEPARTAMENT

create proc zad4(@nazwa varchar(20), @kwota decimal(10,2) output)
as
select @kwota=max(Zarobki) From PRACOWNICY inner join DEPARTAMENT on PRACOWNICY.Id_depart=DEPARTAMENT.Id_depart where Nazwa=@nazwa

declare @kwota2 decimal(10,2)
exec zad4 Badan,@kwota2 output
select @kwota2

create trigger zad45 on PRACOWNICY
after update
as begin
if update(Zarobki)
begin
declare @nowaPensja decimal(10,2), @staraPensja decimal(10,2)
Select @nowaPensja=Zarobki From inserted 
Select @staraPensja=Zarobki From deleted
if @nowaPensja<@staraPensja
rollback
end
end

drop trigger zad45

Update PRACOWNICY set Zarobki=2800 where Id_pracownika in(4,5)
Select * From PRACOWNICY

Create trigger zad5 on PRACOWNICY 
after insert, update
as
begin
declare @new decimal(10,2)
select @new=Prowizja from inserted
if @new is NULL
begin
Update PRACOWNICY set Prowizja=10 where Id_pracownika in(Select Id_pracownika from inserted)
end
end

update Pracownicy set prowizja =null where Id_pracownika in(4,5)
Select * From PRACOWNICY
drop trigger zad5

create table REJESTR (
kto varchar(30),
kogo varchar(20),
kiedy date
)

create trigger zad6 on PRACOWNICY
after delete
as
begin
Insert into rejestr VALUES(SUSER_NAME(),(Select nazwisko From deleted),GetDate())
end
Delete From PRACOWNICY where Id_pracownika=5
Select * From rejestr

drop trigger zad6

select * From PRACOWNICY
begin transaction zad8
declare @zarobki1 decimal(10,2)
declare @zarobki2 decimal(10,2)
declare @zarobki3 decimal(10,2)
declare @roz1 decimal(10,2)
declare @roz2 decimal(10,2)
declare @out varchar(90)
Select @zarobki1= sum(Zarobki) From PRACOWNICY
Update PRACOWNICY set Zarobki=(Zarobki*1.1) where Id_depart =(Select Id_depart From DEPARTAMENT where Nazwa Like 'Sprzedaz')
Select @zarobki2= sum(Zarobki) From PRACOWNICY
save transaction p1
Update PRACOWNICY set Zarobki=(Zarobki*1.1) where Stanowisko not Like 'Prezes' AND Id_depart not in(Select Id_depart From DEPARTAMENT where Nazwa Like 'Sprzedaz')
Select @zarobki3= sum(Zarobki) From PRACOWNICY
rollback transaction p1
select @roz1=@zarobki2-@zarobki1
select @roz2=@zarobki3-@zarobki1
Select @out='Po podwyzce w dziale sprzedazy: '+ cast(@roz1 as varchar(20))+ ' po pozostalych podwyzkach: '+ cast(@roz2 as varchar(20))
print @out
commit transaction

select * From PRACOWNICY

Create table Pracownik(
ID_Pracownik int identity (1,1) Primary key,
imie varchar(20),
nazwisko varchar(20),
pesel varchar(11),
plec varchar(1)
)

Create trigger zad16 on Pracownik
after insert
as begin
update Pracownik set plec=
case
when (select SUBSTRING(pesel,10,1) From inserted) in (0,2,4,6,8) then 'K' else 'M'
end where ID_Pracownik = (Select ID_Pracownik From inserted)
end

insert into Pracownik (imie,nazwisko,pesel) values ('Jan', 'Nowak','12345678901')
insert into pracownik (imie,nazwisko,pesel) values ('Jan', 'Nowak','12345678931')
select * from Pracownik

drop trigger zad16

create trigger zad26 on Pracownicy
after insert
as begin
if(select count(Id_pracownika) From PRACOWNICY where Kierownik=(Select Kierownik From inserted))>5
begin
delete From PRACOWNICY where Id_pracownika=(select Id_pracownika from inserted)
print 'Keirownik ma za duzo pracownikow'
end
end
insert into PRACOWNICY(Id_pracownika,Nazwisko,imie, Kierownik) VALUES(18,'Jan','Nowak', 2)
insert into PRACOWNICY(Id_pracownika,Nazwisko,imie, Kierownik) VALUES(16,'Jan','Nowak', 2)
insert into PRACOWNICY(Id_pracownika,Nazwisko,imie, Kierownik) VALUES(17,'Jan','Nowak', 2)
drop trigger zad26

Create table LOG_ZMIAN(
nr int identity (1,1) primary key,
operacja varchar(2),
kto varchar(30),
host varchar(30),
kiedy datetime
)

create trigger zad36 on Pracownicy
after insert, update, delete
as begin
insert into LOG_ZMIAN VALUES(
(case 
when exists(Select * From inserted) AND exists(Select * From deleted) then 'U'
when exists(Select * From inserted) then 'I'
when exists(Select * From deleted) then 'D'
else null
end), SUSER_NAME(),HOST_NAME(), CURRENT_TIMESTAMP 
)
end

insert into PRACOWNICY(Id_pracownika,Nazwisko,imie, Kierownik) VALUES(19,'Jan','Nowak', 1)
Select * From LOG_ZMIAN
drop trigger zad36

update PRACOWNICY set Zarobki=2000 where Id_pracownika in(15,16,17,19)
select * From PRACOWNICY

declare @pula decimal(10,2)
set @pula=1000
declare @podwyzka decimal(10,2)
declare @id int
declare @zarobki decimal(10,2)
declare kur1 cursor for select Id_pracownika From PRACOWNICY Order by Zarobki
open kur1
fetch from kur1 into @id
while @@FETCH_STATUS=0 AND @pula>0
begin
set @zarobki=(select Zarobki From PRACOWNICY where Id_pracownika=@id)
set @podwyzka=@zarobki*0.05
set @zarobki+=@podwyzka
update PRACOWNICY set Zarobki=@zarobki Where Id_pracownika=@id
set @pula-=@podwyzka
fetch next from kur1 into @id
end
close kur1
deallocate kur1

Select * From PRACOWNICY
