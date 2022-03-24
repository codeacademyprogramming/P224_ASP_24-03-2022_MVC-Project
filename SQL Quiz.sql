Create Database P224Academy

Use P224Academy

Create Table Groups
(
	Id int primary key identity,
	Name nvarchar(255) unique
)

Create Table Students
(
	Id int primary key identity,
	Name nvarchar(255),
	SurName nvarchar(255),
	GroupId int references Groups(Id)
)

Alter Table Students Add Grade int

Insert Into Groups(Name)
Values('P224'),('P124'),('P221')

Insert Into Students(Name, SurName, GroupId, Grade)
Values('Sexavet','Aliyev',1,80),
('David','Qayibov',1,10),
('Amil','Nuriyev',1,80),
('Altan','Ibrahimli',3,80)

Select * From Students Where GroupId = 1

Select s.Name, s.SurName, s.Grade, g.Name From Students s
join Groups g
On g.Id = s.GroupId
Where s.GroupId = 1

Select g.Name, COUNT(s.Id) 'Say' From Groups g
join Students s
On s.GroupId = g.Id
Group By g.Name

Create View usv_ShowAllStudents
As
Select s.Name,s.SurName, g.Name 'Qrup', s.Grade From Students s
Join Groups g
On s.GroupId = g.Id

Select * from usv_ShowAllStudents

Create Procedure usp_GetStudentsByGrade
@Grade int
As
Begin
	Select * from usv_ShowAllStudents s Where s.Grade > @Grade
End

exec usp_GetStudentsByGrade 30

Create Function GetStudetnCountByGroupName
(@GroupName nvarchar(255))
returns int
As
Begin
	declare @Count int
	Select @Count = COUNT(*) From usv_ShowAllStudents s Where s.Qrup = @GroupName Group By s.Qrup
	return @Count
End

Select dbo.GetStudetnCountByGroupName('P224') 'Say'