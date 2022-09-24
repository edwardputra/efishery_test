# EFishery Technical Test
## [Edward Pratama Putra](https://www.linkedin.com/in/edwardputra/) - Data Engineer


### Project Structure:
- Task 1
-- Airflow DAG -> efishery_task_1.py
-- Transformation queries inside *efishery/queries/* folder
-- DWH export result -> task_1.sql
- Task 2
-- Python code -> efishery_task_2.py
-- JSON dataset

### Assumptions And Environment

- Airflow 2.3.4 for task 1
- Two external libraries used for task 2: pandas and jellyfish
- PostgreSQL are used for both transactional DB and DW
- As task 2 involves manual input data, the result is simply a best effort approximation via transformation and aggregation of the raw data

### Task 1 Explanation
- The alternative DWH schema can be seen in: https://dbdiagram.io/d/632f14547b3d2034ffa7b80d
- The key difference between the given schema and my proposed schema is the addition of product dimension, seeing as the stakeholders might want to filter the fact table by product, in order to gain metrics such as most popular product and highest grossing product
- Another alternative that I can propose is to use fact constellation schema instead of star schema if more data are needed in the DWH, as the use of star schema is limited to certain number of dimensions. Another alternative is to use Snowflake schema if the dimensions are of varying granularity. However, for the current condition, star schema is sufficient
- The transformation is done via queries executed inside Python operator
- Date IDs are generated using hash function in order to ensure uniqueness and replicability accross tables

### Task 2 Explanation
- You can run the code using the following command
    > python efishery_task_2 soal-2.json

- The transformations and data cleaning conducted have also been explained through inline comments
