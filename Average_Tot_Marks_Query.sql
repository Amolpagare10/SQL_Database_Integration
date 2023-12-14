SELECT
    StudentId,
    (AVG(MarksObtained) * 100) AS 'Average %'
FROM
    competeny_wise
GROUP BY
    StudentID, Subject;
    
