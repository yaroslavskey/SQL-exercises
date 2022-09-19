--1. Вывести все возможные пары строк преподавателей и групп.
SELECT T.Name +' '+ T.Surname AS Teacher, G.Name AS Group
FROM Groups AS G, Teachers AS T, Lectures AS L, GroupsLectures AS GL
WHERE T.Id = L.TeacherId AND L.Id = GL.LectureId AND GL.GroupId = G.Id;

--2. Вывести названия факультетов, фонд финансирования кафедр которых превышает фонд финансирования факультета.
SELECT F.Name AS Name Faculties
FROM Faculties AS F, Departments AS D
WHERE D.FacultyId = F.Id AND D.Financing > F.Financing 
GROUP BY F.Name;

--3. Вывести фамилии кураторов групп и названия групп, которые они курируют.
SELECT C.Surname AS Curator surname, G.Name AS Group name
FROM Curators AS C, GroupsCurators AS GC, Groups AS G
WHERE C.Id = GC.CuratorId AND GC.GroupId = G.Id;

--4. Вывести имена и фамилии преподавателей, которые читают лекции у группы “P107”.
SELECT T.Name, T.Surname
FROM Groups AS G, Teachers AS T, Lectures AS L, GroupsLectures AS GL
WHERE T.Id = L.TeacherId AND L.Id = GL.LectureId AND GL.GroupId = G.Id AND G.Name = 'P107';

--5. Вывести фамилии преподавателей и названия факультетов на которых они читают лекции.
SELECT T.Surname AS Teacher, F.Name AS Name Faculty
FROM Groups AS G, Teachers AS T, Lectures AS L, GroupsLectures AS GL, Departments AS D, Faculties AS F
WHERE T.Id = L.TeacherId AND L.Id = GL.LectureId AND GL.GroupId = G.Id AND G.DepartmentsId = D.Id AND D.FacultyId = F.Id;

--6. Вывести названия кафедр и названия групп, которые к ним относятся.
SELECT D.Name AS Name department, G.Name AS Name group
FROM Groups AS G, Departments AS D
WHERE G.DepartmentsId = D.Id;

--7. Вывести названия дисциплин, которые читает преподаватель “Samantha Adams”.
SELECT S.Name AS Дисциплина
FROM Teachers AS T, Lectures AS L, Subjects AS S
WHERE T.Id = L.TeacherId AND L.SubjectId = S.Id AND T.Name = 'Samantha' AND T.Surname = 'Adams';

--8. Вывести названия кафедр, на которых читается дисциплина “Database Theory”.
SELECT D.Name AS Кафедра
FROM Departments AS D, Groups AS G, GroupsLectures AS GL, Lectures AS L, Subjects AS S
WHERE D.Id = G.DepartmentsId AND G.Id = GL.GroupId AND GL.LectureId = L.Id AND L.SubjectId = S.Id AND S.Name = 'Database Theory';

--9. Вывести названия групп, которые относятся к факультету “Computer Science”.
SELECT G.Name AS Группа
FROM Faculties AS F, Departments AS D, Groups AS G
WHERE F.Id = D.FacultyId AND D.Id = G.DepartmentsId AND F.[Name] = 'Computer Science';

--10. Вывести названия групп 5-го курса, а также название факультетов, к которым они относятся.
SELECT G.Name AS Группа, F.Name AS Факультет
FROM Faculties AS F, Departments AS D, Groups AS G
WHERE F.Id = D.FacultyId AND D.Id = G.DepartmentsId AND G.Year = 5;

--11. Вывести полные имена преподавателей и лекции, которые они читают (названия дисциплин и групп), причем отобрать только те лекции, которые читаются в аудитории “B103”.
SELECT T.Name + ' ' + T.Surname AS Преподаватель, S.Name AS Предмет, G.Name AS Группа
FROM Teachers AS T, Lectures AS L, Subjects AS S, GroupsLectures AS GL, Groups AS G
WHERE T.Id = L.TeacherId AND L.SubjectId = S.Id AND L.Id = GL.LectureId AND GL.GroupId = G.Id AND L.LectureRoom = 'B103';