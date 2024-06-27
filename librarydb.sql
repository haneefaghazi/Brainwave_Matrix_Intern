CREATE DATABASE LibraryDb;
USE LibraryDb;

-- Table: book
CREATE TABLE book (
    book_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    publisher_name VARCHAR(100) NOT NULL,
    published_year INT NOT NULL
);

-- Table: authors
CREATE TABLE authors (
    book_issn_no INT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL,
    INDEX author_name_idx (author_name)  -- Add the missing index
);

-- Table: publisher
CREATE TABLE publisher (
    name VARCHAR(255) PRIMARY KEY,
    place VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15) NOT NULL
);

-- Table: book_quantity
CREATE TABLE book_quantity (
    book_id INT PRIMARY KEY,
    subject VARCHAR(255) NOT NULL,
    total_no_of_copies INT NOT NULL
);

-- Table: book_lending
CREATE TABLE book_lending (
    book_id INT,
    title VARCHAR(255) NOT NULL,
    author_name VARCHAR(255) NOT NULL,
    student_reg_no INT NOT NULL,
    issue_date DATE NOT NULL,
    return_date DATE NOT NULL,
    no_of_books_issued INT NOT NULL,
    PRIMARY KEY (book_id, student_reg_no),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Table: library_details
CREATE TABLE library_details (
    library_id INT PRIMARY KEY,
    library_branch VARCHAR(255) NOT NULL,
    library_place VARCHAR(255) NOT NULL
);


-- Inserts for the book table
INSERT INTO book (book_id, title, publisher_name, published_year)
VALUES
(1, 'Introduction to Database Systems', 'Pearson', 2020),
(2, 'Algorithms and Data Structures', 'McGraw-Hill', 2019),
(3, 'Machine Learning Basics', 'O Reilly Media', 2021),
(4, 'Web Development JavaScript', 'Packt Publishing', 2018),
(5, 'DataScience-Beginners', 'Wiley', 2022),
(6, 'Artificial Intelligence: A Modern Approach', 'Prentice Hall', 2017),
(7, 'Mobile App Development ', 'O Reilly Media', 2019),
(8, 'Cybersecurity Essentials', 'Sybex', 2020),
(9, 'Python Programming ', 'NoStarch Press', 2016),
(10, 'Computer Networks: A Top-Down Approach', 'Pearson', 2015);

-- Select from book table
SELECT * FROM book;

-- Inserts for the authors table
INSERT INTO authors (book_issn_no, author_name)
VALUES
(1, 'John Doe'),
(2, 'Alice Smith'),
(3, 'Bob Johnson'),
(4, 'Jane Austen'),
(5, 'Mary Shelley'),
(6, 'Harper Lee'),
(7, 'Douglas Adams'),
(8, 'J.D. Salinger'),
(9, 'Antoine de Saint-Exupéry'),
(10, 'Toni Morrison');


-- Select from authors table
SELECT * FROM authors;

-- Inserts for the publisher table
INSERT INTO publisher (name, place, phone_number)
VALUES
('Readers Zone', 'New York', '123-456-7890'),
('Sun India Publications', 'Mumbai', '987-654-3210'),
('Thakur Publications Lucknow', 'Lucknow', '567-890-1234'),
('E. Brydges', 'London', '456-789-0123'),
('Harding, Mavor & Jones', 'London', '345-678-9012'),
('J.B. Lippincott & Co', 'Philadelphia', '234-567-8901'),
('Pan Books', 'London', '123-234-5678'),
('Little, Brown and Company', 'New York', '987-789-0123'),
('Reynal & Hitchcock', 'New York', '567-012-3456'),
('Alfred A. Knopf', 'New York', '789-456-1230');

-- Select from publisher table
SELECT * FROM publisher;

-- Inserts for the book_lending table
INSERT INTO book_lending (book_id, title, author_name, student_reg_no, issue_date, return_date, no_of_books_issued)
VALUES
(1, 'Introduction to Database Systems', 'John Doe', 12345, '2024-02-04', '2024-02-18', 2),
(2, 'Algorithms and Data Structures', 'Alice Smith', 67890, '2024-02-05', '2024-02-19', 1),
(3, 'Machine Learning Basics', 'Bob Johnson', 54321, '2024-02-06', '2024-02-20', 3),
(4, 'Web Development JavaScript', 'Jane Austen', 98765, '2024-02-07', '2024-02-21', 1),
(5, 'DataScience-Beginners', 'Mary Shelley', 34567, '2024-02-08', '2024-02-22', 2),
(6, 'Artificial Intelligence: A Modern Approach', 'Harper Lee', 87654, '2024-02-09', '2024-02-23', 1),
(7, 'Mobile App Development ', 'Douglas Adams', 23456, '2024-02-10', '2024-02-24', 2),
(8, 'Cybersecurity Essentials', 'J.D. Salinger', 78901, '2024-02-11', '2024-02-25', 1),
(9, 'Python Programming s', 'Antoine de Saint-Exupéry', 32109, '2024-02-12', '2024-02-26', 3),
(10, 'Computer Networks: A Top-Down Approach', 'Toni Morrison', 65432, '2024-02-13', '2024-02-27', 1);

-- Select from book_lending table
SELECT * FROM book_lending;

-- Inserts for the library_details table
INSERT INTO library_details (library_id, library_branch, library_place)
VALUES
(1, 'Main Library', 'New York'),
(2, 'City Branch', 'Mumbai'),
(3, 'Downtown Branch', 'Lucknow'),
(4, 'Central Library', 'London'),
(5, 'West End Branch', 'Philadelphia'),
(6, 'North Branch', 'New York'),
(7, 'East Branch', 'New York'),
(8, 'South Branch', 'London'),
(9, 'Central City Library', 'New York'),
(10, 'Downtown Library', 'New York');

-- Select from library_details table
SELECT * FROM library_details;

-- Inserts for the book_quantity table
INSERT INTO book_quantity (book_id, subject, total_no_of_copies)
VALUES
(1, 'Database Systems',5),
(2, 'Data Structures',1),
(3, 'Machine Learning',10),
(4, 'Web Development ', 23),
(5, 'DataScience', 45),
(6, 'Artificial Intelligence', 8),
(7, 'Mobile App Development ', 3),
(8, 'Cybersecurity ', 90),
(9, 'Python ', 10),
(10, 'Computer Networks', 15);

-- Select from book_quantity table
SELECT * FROM book_quantity;

SELECT *
FROM book_quantity
WHERE total_no_of_copies < (SELECT MAX(total_no_of_copies) FROM book_quantity);

SELECT *
FROM book_quantity
WHERE total_no_of_copies > 5;

SELECT DISTINCT bl.student_reg_no, COUNT(bl.book_id) AS num_books_borrowed
FROM book_lending bl
GROUP BY bl.student_reg_no
HAVING num_books_borrowed > 3;

SELECT * FROM book;

DELETE FROM book
WHERE title = 'Python Programming s';
SELECT * FROM book;

SELECT * FROM book_quantity;

UPDATE book_quantity
SET total_no_of_copies = 20
WHERE book_id =5;
SELECT * FROM book_quantity;


