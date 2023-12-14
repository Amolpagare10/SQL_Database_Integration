SET @location_param = 'ALL';
SET @month_param = 'ALL';
SET @class_param = 'ALL';
SET @branch_code_param = 'ALL';
SET @first_name_param = 'ALL';
SET @last_name_param = 'ALL';

SET @sql = CONCAT(
    'SELECT 
        atm.StudentId,
        dem.First_Name,
        dem.Last_Name,
        atm.average_total_marks AS `Average Marks`,
        dem.Location,
        Gender,
        Branch_code,
        dem.Class,
        Division,
        Academic_Year,
        dem.month,
        dem.Branch_Category,
        dem.Date_of_Joining,
        Internal_ID,
        dem.city
    FROM average_total_marks atm
    RIGHT JOIN demographics dem
        ON atm.StudentId = dem.Child_ID  
    WHERE atm.StudentId IS NOT NULL ',
    IF(@location_param != 'ALL', 
        CONCAT('AND Location = "', @location_param, '"'), 
        ''
    ),
    IF(@month_param != 'ALL', 
        CONCAT('AND Month = "', @month_param, '" '), 
        ''
    ),
    IF(@class_param != 'ALL', 
        CONCAT('AND Class = "', @class_param, '" '), 
        ''
    ),
    IF(@branch_code_param != 'ALL', 
        CONCAT('AND Branch_code = "', @branch_code_param, '" '), 
        ''
    ),
    IF(@first_name_param != 'ALL', 
        CONCAT('AND dem.First_Name = "', @first_name_param, '" '), 
        ''
    ),
    IF(@last_name_param != 'ALL', 
        CONCAT('AND dem.Last_Name = "', @last_name_param, '" '), 
        ''
    ),
    ' 
    ORDER BY 
        FIELD(dem.Month, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"),
        FIELD(LOWER(dem.Class), "jr.kg", "sr.kg", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"),
        dem.First_Name ASC'
);

PREPARE dynamic_query FROM @sql;
EXECUTE dynamic_query;
DEALLOCATE PREPARE dynamic_query;
