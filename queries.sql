-- Sleep health and lifestyle analysis


-- PROBLEM 1: OCCUPATIONS WITH WORST SLEEP

select occupation, 
       round(avg(sleep_duration), 1) as sleep_duration
from sleep_health
group by occupation
order by sleep_duration asc;


-- PROBLEM 2: LIFESTYLE FACTORS

-- bmi impact
select bmi_category,
       count(*) as no_of_people,
       round(avg(quality_of_sleep), 2) as avg_sleep_quality,
       round(avg(sleep_duration), 2) as avg_sleep_hours
from sleep_health
group by bmi_category
order by avg_sleep_quality desc;

-- daily steps impact
select case 
           when daily_steps < 5000 then 'low (<5000)'
           when daily_steps between 5000 and 8000 then 'medium (5000-8000)'
           else 'high (>8000)'
       end as steps_category,
       count(*) as no_of_people,
       round(avg(quality_of_sleep), 2) as avg_sleep_quality
from sleep_health
group by steps_category
order by avg_sleep_quality desc;

-- stress level impact
select stress_level,
       count(*) as no_of_people,
       round(avg(quality_of_sleep), 2) as avg_sleep_quality
from sleep_health
group by stress_level
order by stress_level;


-- PROBLEM 3: AGE GROUPS AT RISK

-- sleep quality by age
select age_group, 
       round(avg(quality_of_sleep), 1) as sleep_quality
from sleep_health
group by age_group
order by sleep_quality desc;

-- sleep disorders by age
select age_group, 
       sleep_disorder,
       count(*) as no_of_people
from sleep_health
group by age_group, sleep_disorder
order by age_group, sleep_disorder;


-- PROBLEM 4: ACTIVITY IMPACT BY OCCUPATION

select occupation, 
       case 
           when physical_activity_level between 0 and 30 then 'low'
           when physical_activity_level between 31 and 60 then 'medium'
           when physical_activity_level > 60 then 'high'
       end as activity_group,
       round(avg(sleep_duration), 1) as avg_sleep_duration,
       round(avg(quality_of_sleep), 1) as avg_sleep_quality
from sleep_health
group by occupation, activity_group
order by occupation, activity_group;


-- PROBLEM 5: HIGH-RISK PROFILE

-- high-risk count
select count(*) as high_risk_count
from sleep_health
where quality_of_sleep <= 6 
    and stress_level >= 7
    and (sleep_disorder != 'None' or bmi_category = 'Obese');

-- high-risk by occupation
select occupation,
       count(*) as high_risk_count
from sleep_health
where quality_of_sleep <= 6 
    and stress_level >= 7
    and (sleep_disorder != 'none' or bmi_category = 'obese')
group by occupation
order by high_risk_count desc;

-- high-risk profile summary
select count(*) as high_risk_count,
       round(avg(quality_of_sleep), 2) as avg_quality,
       round(avg(sleep_duration), 2) as avg_sleep_hours,
       round(avg(stress_level), 2) as avg_stress
from sleep_health
where quality_of_sleep <= 6 
    and stress_level >= 7
    and (sleep_disorder != 'None' or bmi_category = 'Obese');
