-- To Create a New Database File (Blank): touch students.db
-- To Run sqlite3: sqlite3 students.db
-- To Exit sqlite3: Send EOF character via Ctrl+D

-- Creating Tables for Keeping Track of Students, Classes, and Instructors

-- people
CREATE TABLE people (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

-- courses
CREATE TABLE courses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  code TEXT NOT NULL,
  title TEXT NOT NULL
);

-- students
CREATE TABLE students (
  person_id INTEGER NOT NULL,
  course_id INTEGER NOT NULL
);

-- instructors
CREATE TABLE instructors (
  person_id INTEGER NOT NULL,
  course_id INTEGER NOT NULL
);


-- Inserting Data Into Tables

-- Add people 
    INSERT INTO people (name) VALUES ("Alice");
    INSERT INTO people (name) VALUES ("Boaz");
    INSERT INTO people (name) VALUES ("Charlie");
    INSERT INTO people (name) VALUES ("David");
    INSERT INTO people (name) VALUES ("Erin");
    INSERT INTO people (name) VALUES ("Fiona");
    INSERT INTO people (name) VALUES ("Greg");
    INSERT INTO people (name) VALUES ("Helen");
    INSERT INTO people (name) VALUES ("Irene");
    INSERT INTO people (name) VALUES ("Jason");
    INSERT INTO people (name) VALUES ("Stuart");
    
    -- Add courses
    INSERT INTO courses (code, title) VALUES ("CS50", "Introduction to Computer Science");
    INSERT INTO courses (code, title) VALUES ("ECON 10a", "Principles of Economics");
    INSERT INTO courses (code, title) VALUES ("CS51", "Abstraction and Design in Computation");
    INSERT INTO courses (code, title) VALUES ("CS121", "Introduction to Theoretical Computer Science");
    INSERT INTO courses (code, title) VALUES ("CS182", "Artificial Intelligence");
    
    -- Add instructors
    INSERT INTO instructors (person_id, course_id) VALUES (4, 1);
    INSERT INTO instructors (person_id, course_id) VALUES (10, 2);
    INSERT INTO instructors (person_id, course_id) VALUES (11, 3);
    INSERT INTO instructors (person_id, course_id) VALUES (2, 4);
    
    -- Add students
    INSERT INTO students (person_id, course_id) VALUES (1, 1);
    INSERT INTO students (person_id, course_id) VALUES (3, 1);
    INSERT INTO students (person_id, course_id) VALUES (5, 1);
    INSERT INTO students (person_id, course_id) VALUES (6, 1);
    INSERT INTO students (person_id, course_id) VALUES (3, 2);
    INSERT INTO students (person_id, course_id) VALUES (6, 2);
    INSERT INTO students (person_id, course_id) VALUES (7, 2);
    INSERT INTO students (person_id, course_id) VALUES (8, 2);
    INSERT INTO students (person_id, course_id) VALUES (7, 3);
    INSERT INTO students (person_id, course_id) VALUES (8, 3);
    INSERT INTO students (person_id, course_id) VALUES (9, 3);
    INSERT INTO students (person_id, course_id) VALUES (1, 4);
    INSERT INTO students (person_id, course_id) VALUES (9, 4);


-- Exercises

-- What is Alice's student id?
    SELECT id FROM people WHERE name = "Alice";
    
    -- What is the course title for CS51?
    SELECT title FROM courses WHERE code = "CS51";
    
    -- What are the course codes and titles for all of the CS courses?
    -- (Assume that all CS courses have a course code that begins with 'CS')
    SELECT code, title FROM courses WHERE code LIKE "CS%";
    
    -- How many courses are there?
    SELECT COUNT(*) FROM courses;
    
    -- How many students are taking CS50?
    
        -- First, do this in two steps:
        SELECT id FROM courses WHERE code = "CS50"; -- finds that the id is 1
        SELECT COUNT(*) FROM students WHERE course_id = 1; -- using the course id from previous step
    
        -- Then, combine into a single nested query:
        SELECT COUNT(*) FROM students WHERE course_id = (SELECT id FROM courses WHERE code = "CS50");
    
        -- Then, show the same result from joining tables:
        SELECT COUNT(*) FROM students JOIN courses ON students.course_id = courses.id WHERE code = "CS50";
    
    -- What are the names of all of the instructors? Generate a table with all instructors' names and the course they teach.
    SELECT name, title FROM people JOIN instructors ON people.id = instructors.person_id JOIN courses ON instructors.course_id = courses.id;
    
    -- What are the names of all of the students taking CS50?
    
        -- First, do this using JOINs:
        SELECT name FROM people JOIN students ON people.id = students.person_id JOIN courses ON students.course_id = courses.id WHERE code = "CS50";
    
        -- Then, do this with nested queries:
        SELECT name FROM people WHERE id IN (SELECT person_id FROM students WHERE course_id = (SELECT id FROM courses WHERE code = "CS50"));

-- Updating and Deleting

-- Alice wants to switch from CS50 into CS51.
    
        -- First, do this as a multi-step process.
        SELECT id FROM people WHERE name = "Alice"; -- Alice is student 1
        SELECT id FROM courses WHERE code = "CS50"; -- CS50 is course 1
        SELECT id FROM courses WHERE code = "CS51"; -- CS51 is course 3
        UPDATE students SET course_id = 3 WHERE person_id = 1 AND course_id = 1;
    
        -- Then, show nested query.
        UPDATE students SET course_id = (SELECT id FROM courses WHERE code = "CS51") WHERE person_id = (SELECT id FROM people WHERE name = "Alice") AND course_id = (SELECT id FROM courses WHERE code = "CS50");
    
    -- CS182 was cancelled.
    
        DELETE FROM courses WHERE code = "CS182";
