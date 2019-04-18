IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'add_conference'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.add_conference
GO

CREATE PROCEDURE dbo.add_conference
	@i_name VARCHAR(100),
	@i_start_date DATETIME,
	@i_end_date DATETIME

AS
    INSERT INTO [dbo].[conferences]
    (
     [name], [start_date], [end_date]
    )
    VALUES
    (
     @i_name, @i_start_date, @i_end_date
    )
    GO
GO

EXECUTE dbo.add_conference @i_name="google", @i_start_date="1900-01-01 00:00:00", @i_end_date="1900-01-02 00:00:00"
