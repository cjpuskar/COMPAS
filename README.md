# COMPAS

## Table of Contents

- [Synopsis](#synopsis)
- [High Level Overview](#high-level-overview)
- [Dependencies](#dependencies)
- [View Data](#view-data)
- [Source Target Mapping](#source-target-mapping)
- [Data Parsing](#data-parsing-/-formatting)
- [Import To SQL Server](#import-to-sql-server)
- [SQL Queries](#sql-queries)
- [Questions & Comments](#questions-&-comments)


## Synopsis
Moving applicant data from a clients system to COMPAS SQL Server environment

Source: CSV file (comma delimited)
Target: applicants table (schema in applicants.sql)

## High Level Overview

1. Import and view data in Excel
2. Create a Source / Target field mapping.
3. Identify source fields where the data needs to be parsed into multiple fields.
4. Identify fields where data formatting is inconsistent.
5. Change file format delimiters to pipe.
6. Load data into a temp DB table.
7. INSERT data from temp db into applicants table as defined in source target mapping.
8. Insert build ID into applicants table.
9. Insert build ID and applicant ID into build_app_conn table.

DISCLAIMER: I realize that the purpose of this assessment is more about thought process as oppose to being 100% correct but I still thought it worth mentioning that had this been a real data migration with a real client I would have sought out more clarification on which source fields we needed to keep, which source fields needed parsed, ect. as opposed to making best guesses.


## Dependencies

- VMWare Fusion
- Windows 10
- MS SQL Server Management Studio

## View Data
The first step in the process is to import the CSV file into Excel so we can see what were working with.

This serves 2 purposes:
 1. Allows us to spot any data quality / data formatting issues.
 2. Map source fields to target fields.

Importing the CSV file into Excel:
 1. Copy and paste 1st row of CSV file.
 2. Copy and paste remainder of file.

## Source Target Mapping
Create a document to map out source fields and their corresponding target fields. This will serve as a guide for when I import the applicant data into SQL Server.

<img src="/SourceTargetMap.png">

## Data Parsing / Formatting

### Data Parsing

While viewing the data in Excel, I noticed several source fields that needed parsing in order to fill out their target field counterparts.

While I didn't parse data out for every possible opportunity (parse out country_id based off of state and provinces data, or pull technical skills out of notes field, ect) below are a few exmaples of where I did.

#### Source (S) into app_source (T) & source_name (T)

  I made the assumption that app_source was something like (Job Board, intranet, Career Site) and source_name was the name of that particular job board so I parsed source (s) into app_source and source_name.

#### Notes, Desired Salary, Current Salary (S) into app_salary, app_hourly (T)

  There were several issues getting salary into the database. The first was that the salary amounts were in 1 of 3 places.

  Locations:
  - Desired Salary
  - Current Salary
  - Notes

 It was also in multiple formats.

 Formats:
 - $75.00, $65,000.00, $40/hr INC, $40/hr or 65-70,000/year, $42-$45/hr, $65.00/hour, $80-84K

 How I resolved this was that I noticed whenever salary was in the data, it would always be written down in the Notes field and prefixed with the word 'Rate'. Using this I was able to parse it out of the Notes field. Based on what other characters were in the string, (hr / hour / k / year) I could determine if it was an hourly or yearly rate and once I had one I could calculate the other.

#### state (S) into app_state, app_province (T)

 The source field state had both american states and canadian provinces in the same field. I used an if statement to parse them into the correct target fields. I also noticed that while most state/provinces used a 2 character abbreviation, some did not so I changed them to a 2 character abbreviation to standardized the data.

## Import to SQL

  I imported the applicant_subset_dbImport.csv file into SQL Server using the Import Wizard.

  Before I imported into the DB I changed the delimter from comma to pipe.

## SQL Queries

 After importing the CSV file my database now had an applicant_subset_dbImport table.

#### Create Table Queries

 Next I ran the queries provided by Nishad to establish the applicants and build_app_conn tables.

 - applicants.sql
 - build_app_conn.sql

#### INSERT INTO queries

  Using the Source Target Map as a guide, I created an INSERT INTO query to move data from the applicant_subset_dbImport table into the applicants table.

  - insertIntoApplicants.sql
  ```sql
  USE [staffconsol1]
  GO

  SET IDENTITY_INSERT [dbo].applicants ON

  INSERT INTO [dbo].applicants (ID, app_last_name, app_first_name, app_middle_name, app_homephone, app_mobilephone, app_workphone,
  app_addr1, app_city, app_state, app_province, app_zip, app_country, app_source, source_name, app_avail_date, corpname, user_ID,
  app_create_date, app_updated_date, app_email, app_email2, app_website, app_salary, app_hourly)

  SELECT candidate_id,
  	   last_name, first_name, middle_name, phone_home, phone_cell, phone_work, address, city, app_state, app_province,
  	   zip, country_id, app_source, source_name, date_available, current_employer, owner, date_created, date_modified,
  	   email1, email2, web_site, app_salary, app_hourly

  FROM dbo.applicant_subset_dbImport

  SET IDENTITY_INSERT [dbo].applicants OFF;
  ```

  Forgot to insert build_id so lets do that next!

  - setBuildId.sql

  ```sql
  USE staffconsol1
  GO

  UPDATE dbo.applicants
  SET build_ID = 159;
  ```

And finally lets pair each applicant record with the build ID they belong to.

  - applicantsToBuildAppConn

  ```sql
  USE staffconsol1
  GO

  INSERT INTO dbo.build_app_conn (app_ID, build_ID)

  SELECT ID, build_ID FROM dbo.applicants;
  ```

## Questions & Comments

* site_id (S)

  Im fairly certain we need to retain site_id in our database but I wasnt entirely sure which target field to put it in.

* notes (S)

  I didnt really see an applicable target field to place the notes data in but some of the pieces of info like availability, availability for interviews, and technical skills would be important things to store in the database..

* address (S)

  Some of the rows in the address field have address, city, province, and country combined while others only have the street address.

* Lookup fields

  Several fields look theyre lookups which means we would also have to import those tables into our compas database in a full fledged data integration.
