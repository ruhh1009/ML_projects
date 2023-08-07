# Command for creating the database
Create database alumni;

# Command to use the created database
Use alumni;

# Question3:Run SQL command to see the structure of six tables
Desc college_a_hs;
Desc college_a_se;
Desc college_a_sj;
Desc college_b_hs;
Desc college_b_se;
Desc college_b_sj;

/* Question6: Perform data cleaning on table College_A_HS and store cleaned data in 
view College_A_HS_V, Remove null values. */
CREATE VIEW College_A_HS_V AS
    SELECT 
        *
    FROM
        college_a_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL;

/* Question7: Perform data cleaning on table College_A_SE and store cleaned data in
view College_A_SE_V, Remove null values.*/
CREATE VIEW College_A_SE_V AS
    SELECT 
        *
    FROM
        college_a_se
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Location IS NOT NULL;

/* Question8: Perform data cleaning on table College_A_SJ and store cleaned data in
view College_A_SJ_V, Remove null values.*/
CREATE VIEW College_A_SJ_V AS
    SELECT 
        *
    FROM
        college_a_sj
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL;

/* Question9:Perform data cleaning on table College_B_HS and store cleaned data in
view College_B_HS_V, Remove null values.*/
CREATE VIEW College_B_HS_V AS
    SELECT 
        *
    FROM
        college_b_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL;


/* Question10:Perform data cleaning on table College_B_SE and store cleaned data in
view College_B_SE_V, Remove null values.*/
CREATE VIEW College_B_SE_V AS
    SELECT 
        *
    FROM
        college_b_se
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Location IS NOT NULL;

/* Question11: Perform data cleaning on table College_B_SJ and store cleaned data in
view College_B_SJ_V, Remove null values.*/
CREATE VIEW College_B_SJ_V AS
    SELECT 
        *
    FROM
        college_b_sj
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND Name IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL;
            
/* Question12: Make procedure to use string function/s for converting record of Name, FatherName,
MotherName into lower case for views (College_A_HS_V, College_A_SE_V, College_A_SJ_V,
College_B_HS_V, College_B_SE_V, College_B_SJ_V) */
Delimiter $$
Create Procedure College_a_hs_v_l()
Begin
Select lower(Name), lower(FatherName), lower(MotherName) from College_a_hs_v;
END $$
Delimiter //

Delimiter $$
Create Procedure College_a_se_v_l()
Begin
Select lower(Name), lower(FatherName), lower(MotherName) from College_a_se_v;
END $$
Delimiter //

Delimiter $$
Create Procedure College_a_sj_v_l()
Begin
Select lower(Name), lower(FatherName), lower(MotherName) from College_a_sj_v;
END $$
Delimiter //

Delimiter $$
Create Procedure College_b_hs_v_l()
Begin
Select lower(Name), lower(FatherName), lower(MotherName) from College_b_hs_v;
END $$
Delimiter //

Delimiter $$
Create Procedure College_b_se_v_l()
Begin
Select lower(Name), lower(FatherName), lower(MotherName) from College_b_se_v;
END $$
Delimiter //

Delimiter $$
Create Procedure College_b_sj_v_l()
Begin
Select lower(Name), lower(FatherName), lower(MotherName) from College_b_sj_v;
END $$
Delimiter //

Call College_a_hs_v_l;
Call College_a_se_v_l;
Call College_a_sj_v_l;
Call College_b_hs_v_l;
Call College_b_se_v_l;
Call College_b_sj_v_l;


/* Question 14:Write a query to create procedure get_name_collegeA using the cursor
to fetch names of all students from college A.*/
DELIMITER $$
CREATE PROCEDURE get_name_collegeA( 
       INOUT Lname TEXT(40000)
) 
BEGIN  
    DECLARE finished INT DEFAULT 0;  
    DECLARE Lnamelist VARCHAR (16000) DEFAULT "";    
    DECLARE Lnamedetails  CURSOR FOR  SELECT name FROM college_a_hs  
    UNION   
    SELECT name FROM college_a_se  
    UNION   
    SELECT name FROM college_a_sj;    
    DECLARE CONTINUE HANDLER  FOR NOT FOUND SET finished=1;    
    OPEN Lnamedetails;  
    getname1:  LOOP  
    FETCH Lnamedetails INTO Lnamelist;  
    IF finished =1 THEN   
    LEAVE getname1;  
    END IF;    
    SET Lname = CONCAT(Lnamelist,";",Lname);    
    END LOOP getname1;    
    CLOSE Lnamedetails;   
END $$
DELIMITER // ;

SET @name1="";
CALL get_name_collegeA(@name1);
SELECT @name1 Name;


/* Question15: Write a query to create procedure get_name_collegeB using the cursor
to fetch names of all students from college B.*/
DELIMITER $$
CREATE PROCEDURE get_name_collegeB(  
       INOUT Fname TEXT(40000)
) 
BEGIN  
     DECLARE finished INT DEFAULT 0;  
     DECLARE Fnamelist VARCHAR (16000) DEFAULT "";   
     DECLARE Fnamedetails  CURSOR FOR  SELECT name FROM college_b_hs  
     UNION ALL  
     SELECT name FROM college_b_se  
     UNION ALL  
     SELECT name FROM college_b_sj;   
     DECLARE CONTINUE HANDLER  FOR NOT FOUND SET finished=1;    
     OPEN Fnamedetails;  
     getname2:  LOOP  
     FETCH Fnamedetails INTO Fnamelist;  
     IF finished =1 THEN   
     LEAVE getname2;  
     END IF;    
     SET Fname = CONCAT  (Fnamelist,";",Fname);    
     END LOOP getname2;    
     CLOSE Fnamedetails;   
END $$
DELIMITER // ;

SET @name2="";
CALL get_name_collegeB(@name2);
SELECT @name2 Name;


/* Question16: Calculate the percentage of career choice of College A and College B
Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
Note: Approximate percentages are considered for career choices. */
SELECT "HigherStudies" PresentStatus,
(SELECT COUNT(*) FROM college_a_hs)/((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100 College_A_Percentage,
(SELECT COUNT(*) FROM college_b_hs)/((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100 College_B_Percentage
UNION
SELECT "Self Employed" PresentStatus,
(SELECT COUNT(*) FROM college_a_se)/((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100 College_A_Percentage,
(SELECT COUNT(*) FROM college_b_se)/((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100 College_B_Percentage
UNION
SELECT "Service Job" PresentStatus,
(SELECT COUNT(*) FROM college_a_sj)/((SELECT COUNT(*) FROM college_a_hs) + (SELECT COUNT(*) FROM college_a_se) + (SELECT COUNT(*) FROM college_a_sj))*100 College_A_Percentage,
(SELECT COUNT(*) FROM college_b_sj)/((SELECT COUNT(*) FROM college_b_hs) + (SELECT COUNT(*) FROM college_b_se) + (SELECT COUNT(*) FROM college_b_sj))*100 College_B_Percentage;


select Truncate(680,-2);





