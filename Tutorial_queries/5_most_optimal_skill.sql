/* This query retrieves the most optimal skills for the role of a 'Data Analyst'
 based on the demand and average salary.*/

 
WITH skills_demand AS (
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
), avg_salary AS (
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
)

SELECT
    skills_demand.skill_count,
    avg_salary.avg_salary,
    skills_demand.skills
FROM
    skills_demand
JOIN
    avg_salary
ON
    skills_demand.skills = avg_salary.skills
WHERE
    skills_demand.skill_count > 10
ORDER BY
    avg_salary DESC,
    skills_demand DESC
LIMIT 30;


-- This can be rewritten as;

SELECT
        COUNT(skill.skills) AS skill_count,
        skill.skills,
         ROUND(AVG(job_postings.salary_year_avg), 2) AS avg_salary
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
HAVING
        COUNT(skill.skills) > 10
ORDER BY
        avg_salary DESC,
        skill_count DESC
LIMIT 30;