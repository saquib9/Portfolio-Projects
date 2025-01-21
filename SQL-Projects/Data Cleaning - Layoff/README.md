# Data Cleaning with SQL - Layoffs 2022 Dataset

This project demonstrates a comprehensive data cleaning process on the **Layoffs 2022 Dataset** sourced from [Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-2022). The goal is to clean and standardize the data for further analysis, ensuring accuracy and consistency.

---

## Steps Performed:

### 1. **Initial Setup**
- **Dataset Loaded**: `world_layoffs.layoffs`
- Created a staging table `world_layoffs.layoffs_staging` to preserve the original dataset while performing data cleaning on a duplicate table.

---

### 2. **Data Cleaning Steps**

#### A. Removing Duplicates
- **Approach**:
  - Checked for duplicates using the `ROW_NUMBER()` function with `PARTITION BY`.
  - Ensured legitimate entries (e.g., multiple layoffs for the same company) were not mistakenly removed.
  - Deleted rows where duplicates were confirmed.
- **Execution**:
  - Used a Common Table Expression (CTE) and a `DELETE` query.
  - Added a `row_num` column to simplify duplicate removal.

#### B. Standardizing Data
- **Industry Column**:
  - Populated missing `industry` values by referencing other rows with the same `company` name.
  - Set blanks in the `industry` column to `NULL` for consistency.
  - Standardized variations like `'Crypto Currency'` and `'CryptoCurrency'` to `'Crypto'`.
- **Country Column**:
  - Removed trailing periods from country names (e.g., `'United States.'` → `'United States'`).
- **Date Column**:
  - Converted date strings to `DATE` format using `STR_TO_DATE()` and updated the column datatype.

#### C. Handling Null Values
- **Null Analysis**:
  - Retained null values in `total_laid_off`, `percentage_laid_off`, and `funds_raised_millions` for easier calculations during exploratory data analysis (EDA).

#### D. Removing Irrelevant Data
- Deleted rows where both `total_laid_off` and `percentage_laid_off` were `NULL`.
- Dropped the temporary `row_num` column after completing duplicate removal.

---

## Final Data Overview
- The cleaned dataset is stored in `world_layoffs.layoffs_staging2`.
- Key changes:
  - Duplicates removed.
  - Industry and country fields standardized.
  - Dates converted to proper `DATE` format.
  - Irrelevant rows removed.

---

## Prerequisites
- A SQL environment with the dataset loaded into a schema named `world_layoffs`.

---

## How to Use
1. Clone this repository or copy the SQL queries into your SQL environment.
2. Load the dataset into your schema (`world_layoffs`).
3. Execute the SQL scripts step-by-step for a detailed walkthrough of the cleaning process.

---

## Tools Used
- **SQL**: Primary language for data cleaning and transformation.
- **Kaggle Dataset**: Layoffs 2022 data sourced for this project.

---

## Learnings
- Effective use of CTEs and window functions for duplicate detection and removal.
- Practical approaches to handling null values and standardizing data for consistency.
- Experience in transforming raw data into clean, analysis-ready datasets.

---

## References
- [Kaggle - Layoffs 2022 Dataset](https://www.kaggle.com/datasets/swaptr/layoffs-2022)
