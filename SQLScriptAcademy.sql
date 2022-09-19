--1. ������� ��� ��������� ���� ����� �������������� � �����.
SELECT T.Name +' '+ T.Surname AS Teacher, G.Name AS Group
FROM Groups AS G, Teachers AS T, Lectures AS L, GroupsLectures AS GL
WHERE T.Id = L.TeacherId AND L.Id = GL.LectureId AND GL.GroupId = G.Id;

--2. ������� �������� �����������, ���� �������������� ������ ������� ��������� ���� �������������� ����������.
SELECT F.Name AS Name Faculties
FROM Faculties AS F, Departments AS D
WHERE D.FacultyId = F.Id AND D.Financing > F.Financing 
GROUP BY F.Name;

--3. ������� ������� ��������� ����� � �������� �����, ������� ��� ��������.
SELECT C.Surname AS Curator surname, G.Name AS Group name
FROM Curators AS C, GroupsCurators AS GC, Groups AS G
WHERE C.Id = GC.CuratorId AND GC.GroupId = G.Id;

--4. ������� ����� � ������� ��������������, ������� ������ ������ � ������ �P107�.
SELECT T.Name, T.Surname
FROM Groups AS G, Teachers AS T, Lectures AS L, GroupsLectures AS GL
WHERE T.Id = L.TeacherId AND L.Id = GL.LectureId AND GL.GroupId = G.Id AND G.Name = 'P107';

--5. ������� ������� �������������� � �������� ����������� �� ������� ��� ������ ������.
SELECT T.Surname AS Teacher, F.Name AS Name Faculty
FROM Groups AS G, Teachers AS T, Lectures AS L, GroupsLectures AS GL, Departments AS D, Faculties AS F
WHERE T.Id = L.TeacherId AND L.Id = GL.LectureId AND GL.GroupId = G.Id AND G.DepartmentsId = D.Id AND D.FacultyId = F.Id;

--6. ������� �������� ������ � �������� �����, ������� � ��� ���������.
SELECT D.Name AS Name department, G.Name AS Name group
FROM Groups AS G, Departments AS D
WHERE G.DepartmentsId = D.Id;

--7. ������� �������� ���������, ������� ������ ������������� �Samantha Adams�.
SELECT S.Name AS ����������
FROM Teachers AS T, Lectures AS L, Subjects AS S
WHERE T.Id = L.TeacherId AND L.SubjectId = S.Id AND T.Name = 'Samantha' AND T.Surname = 'Adams';

--8. ������� �������� ������, �� ������� �������� ���������� �Database Theory�.
SELECT D.Name AS �������
FROM Departments AS D, Groups AS G, GroupsLectures AS GL, Lectures AS L, Subjects AS S
WHERE D.Id = G.DepartmentsId AND G.Id = GL.GroupId AND GL.LectureId = L.Id AND L.SubjectId = S.Id AND S.Name = 'Database Theory';

--9. ������� �������� �����, ������� ��������� � ���������� �Computer Science�.
SELECT G.Name AS ������
FROM Faculties AS F, Departments AS D, Groups AS G
WHERE F.Id = D.FacultyId AND D.Id = G.DepartmentsId AND F.[Name] = 'Computer Science';

--10. ������� �������� ����� 5-�� �����, � ����� �������� �����������, � ������� ��� ���������.
SELECT G.Name AS ������, F.Name AS ���������
FROM Faculties AS F, Departments AS D, Groups AS G
WHERE F.Id = D.FacultyId AND D.Id = G.DepartmentsId AND G.Year = 5;

--11. ������� ������ ����� �������������� � ������, ������� ��� ������ (�������� ��������� � �����), ������ �������� ������ �� ������, ������� �������� � ��������� �B103�.
SELECT T.Name + ' ' + T.Surname AS �������������, S.Name AS �������, G.Name AS ������
FROM Teachers AS T, Lectures AS L, Subjects AS S, GroupsLectures AS GL, Groups AS G
WHERE T.Id = L.TeacherId AND L.SubjectId = S.Id AND L.Id = GL.LectureId AND GL.GroupId = G.Id AND L.LectureRoom = 'B103';