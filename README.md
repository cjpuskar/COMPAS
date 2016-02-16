# COMPAS

## Table of Contents

-[Synopsis](#synopsis)
-[Dependencies](#dependencies)
-[View Data](#view-data)
-[Source Target Mapping](#source-target-mapping)
-[Data Parsing](#data-parsing-/-formatting)
-[Import To SQL Server](#import-to-sql-server)
-[Questions & Comments](#questions-&-comments)


## Synopsis
Moving applicant information data from a clients system to COMPAS SQL Server environment

Source: CSV file (comma delimited)
Target: applicants.sql schema

## Dependencies

- VMWare Fusion
- Windows
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

* Source (S) into app_source (T) & source_name (T)

>>I made the assumption that app_source was something like (Job Board, intranet, Career Site) and source_name was the name of that particular job board so I parsed source (s) into app_source and source_name.

* Notes, Desired Salary, Current Salary (S) into app_salary, app_hourly (T)

>> There were several issues getting salary into the database. The first was that the salary amounts were in 1 of 3 places.
>>>Locations:
>>>> - Desired Salary
>>>> - Current Salary
>>>> - Notes

>> It was also in multiple formats.

>>>Formats:
>>>> - $75.00, $65,000.00, $40/hr INC, $40/hr or 65-70,000/year, $42-$45/hr, $65.00/hour, $80-84K

>> How I resolved this was that I noticed whenever salary was in the data, it would always be written down in the Notes field and prefixed with the word 'Rate'. Using this I was able to parse it out of the Notes field. Based on what other characters were in the string, (hr / hour / k / year) I could determine if it was an hourly or yearly rate and once I had one I could calculate the other.

* state (S) into app_state, app_province (T)

>> The source field state had both american states and canadian provinces in the same field. I used an if statement to parse them into the correct target fields. I also noticed that while most state/provinces used a 2 character abbreviation, some did not so I changed them to a 2 character abbreviation to standardized the data.

### Questions, Concerns, Observations

* site_id (S)

>> Im fairly certain we need to retain site_id in our database but I wasnt entirely sure which target field to put it in.....

* notes (S)

>> I didnt really see an applicable target field to place the notes data in but some of the pieces of info like availability, availability for interviews, and technical skills would be important things to store in the database....

>> Also the format of the notes section is making it difficult to load into SQL Server.
