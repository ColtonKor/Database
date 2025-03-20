use campaign;


CREATE TABLE IF NOT EXISTS candidate (
    cand_id VARCHAR(12) PRIMARY KEY,
    cand_nm VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS contributor (
    contbr_id INT AUTO_INCREMENT PRIMARY KEY,
    contbr_nm VARCHAR(50),
    contbr_city VARCHAR(40),
    contbr_st VARCHAR(40),
    contbr_zip VARCHAR(20),
    contbr_employer VARCHAR(60),
    contbr_occupation VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS contribution (
    contb_id INT AUTO_INCREMENT PRIMARY KEY,
    cand_id VARCHAR(12),
    contbr_id INT,
    contb_receipt_amt NUMERIC(8,2),
    contb_receipt_dt VARCHAR(20),
    FOREIGN KEY (cand_id) REFERENCES candidate(cand_id),
    FOREIGN KEY (contbr_id) REFERENCES contributor(contbr_id)
);

-- SELECT COUNT(*) FROM campaign;

-- create index contributor_nm on contributor(contbr_nm);




INSERT INTO contributor (contbr_nm, contbr_city, contbr_st, contbr_zip, contbr_employer, contbr_occupation)
SELECT DISTINCT contbr_nm, contbr_city, contbr_st, contbr_zip, contbr_employer, contbr_occupation
FROM campaign;


INSERT INTO candidate (cand_id, cand_nm)
SELECT DISTINCT cand_id, cand_nm
FROM campaign;


INSERT INTO contribution (cand_id, contbr_id, contb_receipt_amt, contb_receipt_dt)
SELECT 
    c.cand_id,
    cntr.contbr_id,
    c.contb_receipt_amt,
    c.contb_receipt_dt
FROM 
    campaign AS c
JOIN 
    contributor AS cntr
ON 
    c.contbr_nm = cntr.contbr_nm AND
    c.contbr_city = cntr.contbr_city AND
    c.contbr_st = cntr.contbr_st AND
    c.contbr_zip = cntr.contbr_zip AND
    c.contbr_employer = cntr.contbr_employer AND
    c.contbr_occupation = cntr.contbr_occupation;


CREATE VIEW vcampaign AS
SELECT
    cand.cand_nm AS cand_name,
    cntr.contbr_id,
    cntr.contbr_nm AS contbr_name,
    cntr.contbr_occupation AS occupation,
    cntr.contbr_city AS city,
    LEFT(cntr.contbr_zip, 5) AS zip,
    contrib.contb_receipt_amt AS amount,
    contrib.contb_receipt_dt AS date
FROM
    contribution contrib
JOIN
    candidate cand ON contrib.cand_id = cand.cand_id
JOIN
    contributor cntr ON contrib.contbr_id = cntr.contbr_id;





SELECT COUNT(*) FROM vcampaign;