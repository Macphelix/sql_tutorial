/* This query retrieves the top 10 skills based on salary
for the role of a 'Data Analyst'. */

SELECT
    ROUND(AVG(job_postings.salary_year_avg), 2) AS avg_salary,
    COUNT(skill.skills) AS skill_count,
    skill.skills
FROM
    job_postings_fact AS job_postings
LEFT JOIN
    skills_job_dim AS skills_job
ON
    job_postings.job_id = skills_job.job_id
LEFT JOIN
    skills_dim AS skill
ON
    skills_job.skill_id = skill.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst' AND
    job_postings.salary_year_avg IS NOT NULL AND
    job_postings.job_work_from_home = TRUE
GROUP BY
     skill.skills
ORDER BY
    avg_salary DESC
LIMIT 10;