/* This query retrieves the skills that are required for the
top paying roles */

SELECT
    job_postings.job_title_short,
    job_postings.job_title,
    company_dim.name AS company_name,
    job_postings.salary_year_avg,
    skill.skills
FROM
    job_postings_fact AS job_postings
LEFT JOIN
    company_dim
ON
    job_postings.company_id = company_dim.company_id
INNER JOIN
    skills_job_dim AS skills_job
ON
    job_postings.job_id = skills_job.job_id
 INNER JOIN
    skills_dim AS skill
ON
    skills_job.skill_id = skill.skill_id
WHERE
    job_postings.salary_year_avg IS NOT NULL AND
    job_postings.job_title_short = 'Data Analyst' AND
    job_postings.job_work_from_home = TRUE
ORDER BY
    job_postings.salary_year_avg DESC
LIMIT 10;