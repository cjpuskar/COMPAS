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