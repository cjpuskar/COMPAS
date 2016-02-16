USE staffconsol1
GO

INSERT INTO dbo.build_app_conn (app_ID, build_ID)

SELECT ID, build_ID FROM dbo.applicants;