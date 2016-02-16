USE [staffconsol1]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[applicants](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[app_first_name] [varchar](255) NULL,
	[app_last_name] [varchar](255) NULL,
	[app_addr1] [varchar](255) NULL,
	[app_addr2] [varchar](255) NULL,
	[app_city] [varchar](255) NULL,
	[app_state] [varchar](50) NULL,
	[app_zip] [varchar](50) NULL,
	[app_email] [varchar](255) NULL,
	[app_sponsor] [int] NULL,
	[build_ID] [int] NULL,
	[app_ssn] [varchar](255) NULL,
	[app_depends] [varchar](50) NULL,
	[app_status] [varchar](50) NULL,
	[app_exempt] [bit] NULL,
	[app_workphone] [varchar](255) NULL,
	[app_homephone] [varchar](255) NULL,
	[app_mobilephone] [varchar](255) NULL,
	[app_pager] [varchar](255) NULL,
	[app_resume] [text] NULL,
	[app_email2] [varchar](255) NULL,
	[app_flag] [varchar](50) NULL,
	[app_salary] [varchar](255) NULL,
	[app_hourly] [varchar](255) NULL,
	[app_updated_date] [datetime] NULL,
	[app_updated_auth] [int] NULL,
	[app_create_date] [datetime] NULL,
	[consein] [varchar](255) NULL,
	[corpname] [varchar](255) NULL,
	[corpaddr1] [varchar](255) NULL,
	[corpaddr2] [varchar](255) NULL,
	[corpcity] [varchar](50) NULL,
	[corpstate] [varchar](50) NULL,
	[corpzip] [varchar](50) NULL,
	[user_ID] [int] NULL,
	[HCMID] [varchar](50) NULL,
	[prohireID] [int] NULL,
	[app_fax] [varchar](50) NULL,
	[vend_rep] [int] NULL,
	[quick_title] [varchar](50) NULL,
	[app_citizen] [varchar](50) NULL,
	[app_source] [varchar](255) NULL,
	[source_name] [varchar](255) NULL,
	[linkedin] [varchar](255) NULL,
	[app_image] [varchar](50) NULL,
	[app_website] [varchar](255) NULL,
	[app_country] [varchar](50) NULL,
	[app_province] [varchar](50) NULL,
	[custom1] [varchar](100) NULL,
	[custom2] [varchar](100) NULL,
	[app_archive] [bit] NULL,
	[archive_date] [datetime] NULL,
	[archive_user] [int] NULL,
	[app_check] [text] NULL,
	[app_avail_date] [date] NULL,
	[custom1_name] [varchar](50) NULL,
	[custom2_name] [varchar](50) NULL,
	[last_act] [datetime] NULL,
	[last_act_auth] [int] NULL,
	[mgr_link] [int] NULL,
	[app_li_ID] [varchar](50) NULL,
	[app_headline] [varchar](max) NULL,
	[app_birthdate] [varchar](255) NULL,
	[app_middle_name] [varchar](255) NULL,
	[temp_buildID] [int] NULL,
	[old_ID] [int] NULL,
 CONSTRAINT [PK_applicants] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO