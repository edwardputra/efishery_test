import pendulum, glob, os
import pandas as pd
from airflow import DAG
from sqlalchemy.engine import create_engine
from airflow.operators.python import PythonOperator
from airflow.operators.empty import EmptyOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.decorators import task

with DAG(
    dag_id            = 'efishery_task_1',
    default_args      = {'owner': 'edward', 'retries': 2},
    description       = 'Task 1 for Efishery Test',
    schedule_interval = "* 7 * * *",
    start_date        = pendulum.datetime(2022, 9, 24, tz = "Asia/Jakarta"),
    catchup           = False,
    tags              = ['efishery'],
) as dag:

    # empty operators to start and end the graph
    start_pipeline = EmptyOperator(
        task_id = f'start_pipeline',
    ) 

    end_pipeline = EmptyOperator(
        task_id = f'end_pipeline',
    ) 

    # start ingestion process
    for filename in glob.glob("dags/queries/efishery/*.sql"):
        table_name = str(os.path.basename(filename)).replace(".sql", "")

        with open(filename, 'r') as file:
            query = file.read()

        # define main ingestion function
        @task(task_id = f'ingest_table_{table_name}')
        def ingestion_function(table_name, query):
            postgres_hook = PostgresHook("efishery")
            engine = postgres_hook.get_sqlalchemy_engine()

            # execute transformation query
            data = pd.read_sql(query, con = engine)

            # ingest to dwh
            data.to_sql(table_name, con = engine, if_exists = 'append')


        ingestion_task = ingestion_function(table_name, query)

        start_pipeline >> ingestion_task >> end_pipeline