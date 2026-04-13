/* This query retrieves the skills that are most in demand for the 
role of a 'Data Analyst'. */

SELECT
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
    job_postings.job_work_from_home = TRUE AND
    job_postings.salary_year_avg IS NOT NULL
GROUP BY
     skill.skills
ORDER BY
    skill_count DESC
LIMIT 10;