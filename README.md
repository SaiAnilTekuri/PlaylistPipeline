# ETL Pipeline for Spotify Data to Snowflake

In today's data-driven world, the ability to efficiently extract, transform, and load (ETL) data is crucial for businesses to gain actionable insights. In this project, I built an ETL pipeline using AWS services to fetch data from the Spotify API, transform it, and load it into Snowflake for analysis. The entire process is monitored using Amazon CloudWatch.

## Project Overview

The goal of this project is to create a seamless ETL pipeline that:
1. Extracts data from Spotify using the Spotify API.
2. Transforms the data using AWS Glue and Apache Spark.
3. Loads the transformed data into Snowflake for analysis.
4. Monitors the pipeline using Amazon CloudWatch.

---

## Step 1: Data Extraction

The first step in the pipeline is data extraction. We use the **Spotify API** to pull data related to user activity, playlists, and song metadata. This raw data is then stored in **Amazon S3** for further processing.

The **Spotify API** provides access to a variety of data, including:
- **Albums data**: Information about album name, artist, url etc.
- **Song metadata**: Details about songs such as album, genre, song name, artist, url, duration etc.
- **Artist metadata**: Details about songs such as artist name, album, url etc.

The extracted data is stored in **Amazon S3**, which acts as a scalable and secure storage solution for the raw data.

<img width="960" alt="Screenshot 2025-01-28 224237" src="https://github.com/user-attachments/assets/fe53157a-9e29-40f6-8ae6-80f89c134c2b" />


---

## Step 2: Data Transformation

Once the data is extracted, it needs to be cleaned and transformed. I used **AWS Glue** for this purpose. AWS Glue is a fully managed ETL service that makes it easy to prepare and load data for analysis.

### Data Transformation with AWS Glue and Apache Spark

#### Why AWS Glue?
AWS Glue is a serverless ETL service that simplifies data transformation tasks. It integrates seamlessly with AWS services like S3 and Snowflake, and uses **Apache Spark** under the hood for distributed data processing.

#### How we used Apache Spark in AWS Glue:
1. **Data Cleaning**:
   - Removed duplicate records.
   - Handled missing values (e.g., filling in default values or removing incomplete records).
   - Filtered out irrelevant data (e.g., removing test data or non-essential fields).

2. **Data Formatting**:
   - Converted JSON/XML data into structured tabular formats like CSV.
   - Standardized date formats and other fields for consistency.

3. **Partitioning and Optimization**:
   - Partitioned data by specific criteria (e.g., by date or user ID) to improve query performance in Snowflake.

4. **Error Handling**:
   - Implemented logging and alerts for transformation errors using **Amazon CloudWatch**.

#### AWS Glue Workflow
- **Glue Jobs**: Created Glue Jobs to run the Spark transformation scripts. These jobs can be triggered by events (e.g., new data uploaded to S3) or scheduled at specific intervals.
- **Glue Triggers**: Set up triggers to automate the ETL process, such as starting the transformation process when new data is uploaded to S3.

  <img width="960" alt="Screenshot 2025-01-28 224506" src="https://github.com/user-attachments/assets/8647b23b-64a0-47b2-a994-58976de6894d" />


---

## Step 3: Data Loading

After transformation, the data is loaded into **Snowflake**, a cloud-based data warehousing service designed for high performance and scalability. Snowflake allows for efficient storage and querying of large datasets, making it ideal for this project.

### Data Loading Process:
- The transformed data is first written back to **S3** in an optimized format.
- Snowflake's **COPY INTO** command is used to load data from S3 into Snowflake tables.
- Snowflake's automatic clustering and partitioning features ensure efficient data storage and fast querying.

<img width="960" alt="Screenshot 2025-01-28 224342" src="https://github.com/user-attachments/assets/07dc93b6-f693-463a-a158-4b0a7044accd" />


<img width="960" alt="Screenshot 2025-01-28 224548" src="https://github.com/user-attachments/assets/4c0c6059-2b73-43b5-83db-c607f3da8e4a" />


---

## Step 4: Monitoring with Amazon CloudWatch

Throughout the ETL process, **Amazon CloudWatch** is used for real-time monitoring and logging. It provides insights into the performance of the pipeline, including:
- **Metrics**: Execution time of Glue Jobs, the number of records processed, and errors encountered.
- **Logs**: Detailed logs for debugging and troubleshooting.

CloudWatch ensures that the ETL pipeline runs smoothly and alerts us to any issues that may arise.

---

## Technologies Used

- **AWS S3**: Scalable storage for raw data.
- **Spotify API**: Data extraction source for user activity, playlists, and song metadata.
- **AWS Glue**: Managed ETL service for data transformation.
- **Apache Spark**: Distributed processing framework used for transforming data.
- **Snowflake**: Cloud data warehouse for storing and analyzing the transformed data.
- **Amazon CloudWatch**: Monitoring and logging for pipeline performance.

---

## Conclusion

This project demonstrates the power of AWS services to build an efficient and scalable ETL pipeline. By leveraging **AWS Glue**, **Apache Spark**, and **Snowflake**, we can extract, transform, and load large volumes of data with ease. Additionally, **Amazon CloudWatch** provides valuable insights into the pipeline’s performance, helping ensure smooth operations.

Feel free to explore the code and implementation details in this repository.

---
