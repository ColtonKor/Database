use campaign;
-- use the view vcampaign created normalization lab
-- 1. For the 3 occupations 'STUDENT', 'TEACHER', and 'LAWYER',
-- show the occupation, and average dollar contribution rounded to an whole number
-- use the view "vcampaign"
-- Answer: The average contribution by STUDENT should be 538.
SELECT DISTINCT
	occupation, ROUND(AVG(amount))
FROM
	vcampaign
WHERE
	occupation IN ('STUDENT', 'TEACHER', 'LAWYER')
GROUP BY
	occupation;

-- 2. How many occupations have an occupation that contains the string 'lawyer'
-- Answer: 28
SELECT
	COUNT(DISTINCT occupation)
FROM
	vcampaign
WHERE
	occupation LIKE '%lawyer%';
-- 3. List all the ways that lawyers list their occupation.
SELECT DISTINCT
	occupation
FROM
	vcampaign
WHERE
	occupation LIKE '%lawyer%';
-- 4. how many contributors have the occupation listed as 'LAWYER' exactly.
-- Answer: 553
SELECT 
	COUNT(DISTINCT contbr_id)
FROM
	vcampaign
WHERE
	occupation = 'LAWYER';
-- 5. what is the average number (not amount) of contributions per zip code.
-- Answer: 95.5416
SELECT
    AVG(contributions) 
FROM (
    SELECT
        zip, COUNT(*) AS contributions
    FROM
        vcampaign
    GROUP BY
        zip
) AS zipContributions;
-- 6. list the top 20 zip codes by number of contributors in the zip code
-- use only the first 5 digits of the zip code.
SELECT 
    LEFT(zip, 5) AS zipcode, 
    COUNT(DISTINCT contbr_id) AS numContributors
FROM 
    vcampaign
GROUP BY 
    zipcode
ORDER BY 
    numContributors DESC
LIMIT 20;
	
-- 7. list the top 20 zip codes by total amount of contributions in the zip code
-- use only the first 5 digits of the zip code
SELECT 
    LEFT(vcampaign.zip, 5) AS zipcode, 
    SUM(contribution.contb_receipt_amt) AS total_contributions
FROM 
    vcampaign JOIN contribution ON vcampaign.contbr_id = contribution.contbr_id
GROUP BY 
    zipcode
ORDER BY 
    total_contributions DESC
LIMIT 20;
-- 8. show the date and amount of contribution made by 'BATTS, ERIC'. Order by amount (largest to smallest)
SELECT 
    date, amount
FROM 
    vcampaign
WHERE 
    contbr_name LIKE '%BATTS%' AND contbr_name LIKE '%ERIC%'
ORDER BY 
    amount DESC;
-- 9. list the top 20 contributors from the city of SALINAS and the total amount contributed by each contributor.
SELECT
	contbr_name, SUM(amount) AS sum
FROM
	vcampaign
WHERE
	city LIKE '%SALINAS%'
GROUP BY
	contbr_id
ORDER BY
	sum DESC;
-- 10. for each candidate, list the percentage of total contribution amount made up by contributions under $1,000
SELECT
	cand_name, 
    (SUM(amount) / 
    (SELECT SUM(amount) 
	 FROM vcampaign 
	 WHERE cand_name = vcampaign.cand_name)) * 100 AS percentage
FROM
	vcampaign
GROUP BY
	cand_name;
-- 11. for each candidate, which zip code(s) contributed the highest amount to the candidate
SELECT 
    cand_name, zip, sumAmount
FROM (
    SELECT 
        cand_name, zip, SUM(amount) AS sumAmount,
        RANK() OVER (PARTITION BY cand_name ORDER BY SUM(amount) DESC) AS ranked
    FROM 
        vcampaign
    GROUP BY 
        cand_name, zip
) AS zipContributions
WHERE 
    ranked = 1;
