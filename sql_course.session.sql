SELECT 
        job_posted.no_of_job_posted,
        company_name.name, 
CASE 
        WHEN no_of_job_posted < 10 THEN 'Small' 
        WHEN no_of_job_posted > 50 THEN 'Large' 
        ELSE 'Medium' 
        END AS size_category 
FROM( 
    SELECT 
        job_post.company_id, 
        COUNT(job_post.job_id) AS no_of_job_posted 
    FROM 
        job_postings_fact AS job_post 
    GROUP BY 
        job_post.company_id 
    ) AS job_posted 
    LEFT JOIN 
        company_dim AS company_name 
    ON 
        job_posted.company_id = company_name.company_id 
    ORDER BY 
        no_of_job_posted DESC



        CREATE TABLE january_job_postings AS
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

        CREATE TABLE february_job_postings AS
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

        CREATE TABLE march_job_postings AS
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

        
CREATE TABLE q1_job_postings AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) IN (1, 2, 3);


WITH skills_required AS (
    SELECT
            q1_jobs.job_id,
            q1_jobs.job_title_short,
            skills_dim.skills,
            skills_dim.type,
            q1_jobs.salary_year_avg
    FROM    q1_job_postings AS q1_jobs
    LEFT JOIN
            skills_job_dim AS skills_job
    ON
            q1_jobs.job_id = skills_job.job_id
    LEFT JOIN
            skills_dim
    ON
            skills_dim.skill_id = skills_job.skill_id
    WHERE
            salary_year_avg > 70000 AND
            q1_jobs.job_title_short = 'Data Analyst'
    ORDER BY
            salary_year_avg DESC

)
SELECT * FROM skills_required