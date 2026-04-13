/*This query retrieves the top 10 highest paying job postings,
for the job title 'Data Analyst'and can also work from anywhere.*/

SELECT 
    job_title_short,
    job_title,
    company_dim.name AS company_name,
    salary_year_avg,
    job_location
FROM 
    job_postings_fact
LEFT JOIN
    company_dim
ON
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
ORDER BY
    salary_year_avg DESC
LIMIT 10;