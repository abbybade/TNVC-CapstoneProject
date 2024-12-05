DROP TABLE IF EXISTS companies;

CREATE TABLE companies (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL UNIQUE,
    industry VARCHAR(255),
    region VARCHAR(255),
    first_participation_year INT,
    best_result VARCHAR(255),
    initial_funds NUMERIC(15, 2),
    initial_employees INT,
    tamu_affiliated BOOLEAN,
    spinout BOOLEAN,
    college_entity VARCHAR(255),
    sponsor_tamu_research BOOLEAN
);

SELECT * FROM etl.summary;

---- 2. summary table:
CREATE TABLE etl.summary (
    company_id SERIAL PRIMARY KEY,
    company TEXT,
    tamus_affiliated BOOLEAN,
    tamus_spinout BOOLEAN,
    best_result TEXT,
    first_part_year INTEGER,
    initial_funds NUMERIC,
    last_known_status TEXT,
    tnvc_prize_cash NUMERIC,
    spons_research NUMERIC,
    tamus_spons_res NUMERIC,
    dilutive NUMERIC,
    non_dilutive NUMERIC,
    detail_total NUMERIC,
    total_nodetail NUMERIC,
    grand_total NUMERIC,
    tamus_funds NUMERIC,
    tees_funds NUMERIC,
    employees INTEGER,
    lic_fees_roys NUMERIC
);
--- 3.prizes table:

CREATE TABLE etl.prizes (
    prize_id SERIAL PRIMARY KEY,
    company TEXT,
    type TEXT,
    auxiliary_column TEXT,
    amount NUMERIC,
    year INTEGER,
    description TEXT
);

select * from etl.prizes 

--- 4. sr table:
CREATE TABLE etl.sr (
    sr_id SERIAL PRIMARY KEY,
    company_name TEXT,
    tamus_company BOOLEAN,
    buss_w_tamus BOOLEAN,
    value NUMERIC,
    source TEXT,
    added_by TEXT,
    date DATE,
    comments TEXT
);

select * from etl.sr


--- 5 tamusr table:

CREATE TABLE etl.tamusr (
    tamusr_id SERIAL PRIMARY KEY,
    company TEXT,
    tamu_dept TEXT,
    contract_value NUMERIC,
    original_data_company TEXT,
    original_data_tamu_department TEXT
);

--- 6 Create licfr Table

CREATE TABLE etl.licfr (
    licfr_id SERIAL PRIMARY KEY,
    company_id INTEGER REFERENCES etl.companies(company_id) ON DELETE CASCADE,
    company TEXT,
    tamus_company BOOLEAN,
    tees_company BOOLEAN,
    research_institution VARCHAR(100),  -- Setting VARCHAR with a length of 100
    tees_res_institution BOOLEAN,
    tamus_res_institution BOOLEAN,
    tamus_tees_res_institution BOOLEAN,
    aux_column TEXT,
    value NUMERIC,
    source TEXT,
    added_by TEXT,
    date DATE,
    comments TEXT
);

select * from etl.licfr;

--- 7 Create funds Table

CREATE TABLE etl.funds (
    fund_id SERIAL PRIMARY KEY,
    company_id INTEGER REFERENCES etl.companies(company_id) ON DELETE CASCADE,
    company TEXT,
    type TEXT,
    aux_column TEXT,
    value NUMERIC,
    date_added DATE,
    added_by TEXT,
    source TEXT,
    comments TEXT,
    verified TEXT
);


select * from etl.funds;

--- 8 Create the status table 

CREATE TABLE etl.status (
    status_id SERIAL PRIMARY KEY,
    company_id INTEGER REFERENCES etl.companies(company_id),
    company TEXT,
    status_record TEXT,
    date DATE,
    added_by TEXT,
    source TEXT,
    comments TEXT
);
select * from etl.status;


--- 9 create the employee table 

CREATE TABLE etl.employees (
    employee_id SERIAL PRIMARY KEY,
    company_id INTEGER REFERENCES etl.companies(company_id),
    company TEXT,
    value INTEGER,
    date DATE,
    added_by TEXT,
    source TEXT,
    comments TEXT
);

select * from etl.employees;

--- 10 create the contacts table:


CREATE TABLE etl.contacts (
    contact_id SERIAL PRIMARY KEY,
    company_id INTEGER REFERENCES etl.companies(company_id),
    company TEXT,
    first_name TEXT,
    last_name TEXT,
    entry TEXT,
    comments TEXT,
    survey_2019 BOOLEAN,
    company_last_status NUMERIC,
    first_participation_year INTEGER,
    multiple_year INTEGER,
    best_result TEXT
);

select * from etl.contacts;

--- 11 create the industry_region table

CREATE TABLE etl.industry_region (
    industry_region_id SERIAL PRIMARY KEY,
    company_id INTEGER REFERENCES etl.companies(company_id),
    company TEXT,
    first_participation_year INTEGER,
    application_category TEXT,
    sub_category TEXT,
    flight_room TEXT,
    final_industry TEXT,
    region TEXT
);

select * from etl.industry_region;
