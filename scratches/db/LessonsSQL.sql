# lessons
drop table lessons;
create table lessons
(
  id int auto_increment,
  userID int not null,
  courseID int not null,
  date date not null CHECK ( DAYOFWEEK(date) != 1 ),
  slot int not null CHECK (slot >= 1 AND slot <= 4),
  status enum("done", "booked", "cancelled") not null,
  FOREIGN KEY (userID) REFERENCES users(id) ON DELETE CASCADE ,
  FOREIGN KEY (courseID) REFERENCES courses(id) ON DELETE CASCADE ,
  PRIMARY KEY (id),
  UNIQUE (courseID, date, slot),
  UNIQUE (userID, date, slot)
);

create unique index lessons_id_uindex
  on lessons (id);


insert into lessons (userID, courseID, date, slot, status)
VALUES (4, 1, "2019-03-14", 2, "booked");

insert into lessons (userID, courseID, date, slot, status)
VALUES (4, 2, "2019-03-14", 1, "booked");

insert into lessons (userID, courseID, date, slot, status)
VALUES (4, 2, "2019-03-15", 1, "booked");

insert into lessons (userID, courseID, date, slot, status)
VALUES (2, 1, "2019-03-15", 2, "booked");

insert into lessons (userID, courseID, date, slot, status) VALUES (1, 1, "2019-03-16", 1, "booked");
insert into lessons (userID, courseID, date, slot, status) VALUES (1, 1, "2019-03-17", 1, "booked");
insert into lessons (userID, courseID, date, slot, status) VALUES (1, 1, "2019-03-20", 1, "booked");
insert into lessons (userID, courseID, date, slot, status) VALUES (1, 1, "2019-03-23", 1, "booked");


INSERT INTO Lessons (userID, courseID, date, slot, status)
                   VALUES (1,
                           (SELECT C.id FROM Courses AS C WHERE teacherID = 1 AND subjectID = 1),
                           "2019-03-30", 1, 'booked'
                          );

INSERT INTO Lessons (userID, courseID, date, slot, status)
         VALUES (
                  ?,
                  (SELECT C.id FROM Courses AS C WHERE teacherID = ? AND subjectID = ?),
                  ?, ?, ?
                );

INSERT INTO Lessons (userID, courseID, date, slot, status)
VALUES (1,
        (SELECT C.id FROM Courses AS C WHERE teacherID = 1 AND subjectID = 1),
        DATE("2019-03-29"), 1, 'booked'
       );

SELECT * FROM lessons, courses WHERE lessons.date = date("?") AND courses.teacherID = ? AND lessons.courseID = courses.id;

SELECT lessons.slot
FROM lessons,
     courses
WHERE lessons.date = DATE("2019-02-13")
  AND courses.teacherID = 1
#   AND courses.subjectID = 1
  AND lessons.courseID = courses.id;


SELECT lessons.id as id, lessons.userID as userID, lessons.courseID as courseID, lessons.date as date, lessons.slot as slot, lessons.status as status, courses.subjectID as subjectID, courses.teacherID as teacherID, subjects.name as subjectName, teachers.surname as teacherSurname, teachers.name as teacherName
FROM lessons, subjects, teachers, courses
WHERE lessons.userID = 1 AND lessons.courseID = courses.id AND courses.subjectID = subjects.id AND courses.teacherID = teachers.id;

SELECT * FROM lessons WHERE id = ?;

SELECT lessons.id as id, lessons.userID as userID, lessons.courseID as courseID, lessons.date as date, lessons.slot as slot, lessons.status as status, courses.subjectID as subjectID, courses.teacherID as teacherID, subjects.name as subjectName, teachers.surname as teacherSurname, teachers.name as teacherName
FROM lessons, subjects, teachers, courses
WHERE lessons.id = ? AND lessons.courseID = courses.id AND courses.teacherID = teachers.id AND courses.subjectID = subjects.id;



SELECT lessons.id as id, lessons.userID as userID, lessons.courseID as courseID, lessons.date as date, lessons.slot as slot, lessons.status as status, courses.subjectID as subjectID, courses.teacherID as teacherID, subjects.name as subjectName, teachers.surname as teacherSurname, teachers.name as teacherName
FROM lessons, subjects, teachers, courses
WHERE lessons.courseID = courses.id AND courses.subjectID = subjects.id AND courses.teacherID = teachers.id;

SELECT id FROM courses WHERE subjectID = ? AND teacherID = ?;

SELECT lessons.slot, lessons.status as status FROM lessons, courses WHERE lessons.date = ? AND courses.teacherID = ? AND lessons.courseID = courses.id;

SELECT lessons.id, lessons.status
FROM lessons, courses
WHERE lessons.userID = ? AND courses.id = ? AND lessons.courseID = courses.id;

UPDATE lessons SET lessons.status = 'cancelled' WHERE lessons.courseID = ?;