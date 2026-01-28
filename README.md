Below is a **clean, professional README.md** you can paste directly into GitHub.
It’s written to **signal real-world data engineering + healthcare domain knowledge**, not a toy dbt project.

---

# Medicare Advantage Risk Adjustment Analytics Pipeline

## Overview

This project implements an **end-to-end analytics pipeline for Medicare Advantage (MA) risk adjustment** using **PostgreSQL + dbt**.
The pipeline transforms raw medical and pharmacy claims data into **member-level HCC-based risk scores**, following industry-standard healthcare data modeling practices.

The project is designed to mirror how **CMS Risk Adjustment Factor (RAF)** analytics are built in production environments.

---

## Objectives

* Clean and standardize raw claims data
* Map diagnosis and drug codes to hierarchical condition categories (HCCs)
* Aggregate HCCs at the member level
* Calculate simplified member risk scores
* Enforce data quality through automated tests

---

## Tech Stack

* **Database:** PostgreSQL
* **Transformation:** dbt Core
* **Language:** SQL
* **Orchestration:** dbt CLI
* **Version Control:** Git / GitHub

---

## Data Sources

### Raw Tables

* `members`
* `medical_claims`
* `pharmacy_claims`

### Mapping Tables

* `icd_to_hcc` – maps ICD-10 diagnosis codes to CMS HCCs
* `ndc_to_rxhcc` – maps NDC drug codes to RX HCCs
* `plan_type_map` – maps Medicare Advantage plan codes

Mapping tables are loaded using **dbt seeds** for reproducibility.

---

## Project Structure

```text
models/
├── staging/
│   └── postgres/
│       ├── stg_members.sql
│       ├── stg_med_claims.sql
│       └── stg_pharmacy_claims.sql
│
├── core/
│   ├── core_member.sql
│   ├── core_med_claims.sql
│   └── core_pharmacy_claims.sql
│
├── marts/
│   ├── member_hccs.sql
│   └── member_risk_scores.sql
│
seeds/
├── icd_to_hcc.csv
├── ndc_to_rxhcc.csv
└── plan_type_map.csv
```

---

## Data Modeling Approach

### 1. Staging Layer

* Type casting
* Trimming and null handling
* Schema normalization
* Minimal business logic

### 2. Core Layer

* Cleaned canonical tables
* Primary and foreign key enforcement
* Conformed dimensions (members, claims)

### 3. Mart Layer

* Business logic
* Healthcare domain modeling
* Analytics-ready outputs

---

## Key Models

### `member_hccs`

* One row per **member–HCC**
* Derived from medical and pharmacy claims
* Deduplicated HCCs per member

### `member_risk_scores`

* One row per member
* Aggregates HCCs into a simplified RAF-style risk score
* Includes:

  * `hcc_count`
  * `risk_score`

---

## Data Quality & Testing

This project uses **dbt tests** extensively:

* `not_null`
* `unique`
* `relationships`
* Referential integrity across dimensions and marts

Run all tests with:

```bash
dbt test
```

---

## How to Run the Project

1. Install dependencies

```bash
uv add dbt-core dbt-postgres
```

2. Configure your database connection in `profiles.yml`

3. Load seed data

```bash
dbt seed
```

4. Run transformations

```bash
dbt run --select staging core marts
```

5. Validate data

```bash
dbt test
```

---

## Example Output

```sql
select *
from member_risk_scores
order by risk_score desc
limit 10;
```

Produces ranked members by risk severity based on HCC burden.

---

## Notes & Simplifications

* RAF scoring is **simplified for demonstration purposes**
* CMS interaction factors and normalization are out of scope
* The architecture supports easy extension to:

  * Age/sex normalization
  * Interaction HCCs
  * Multi-year risk scoring

---

## Why This Project Matters

This project demonstrates:

* Real-world healthcare analytics modeling
* Production-grade dbt structure
* Strong data quality enforcement
* Clear separation of concerns
* Medicare Advantage domain understanding

It is suitable for:

* Data engineering portfolios
* Healthcare analytics roles
* dbt-focused analytics engineering interviews

---

## Future Enhancements

* Add CMS interaction logic
* Normalize risk scores by age/gender
* Build Looker / Power BI dashboards
* Introduce incremental models
* Add multi-year risk tracking


