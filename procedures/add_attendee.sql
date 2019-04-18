IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'add_attendee'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.add_attendee
GO

CREATE PROCEDURE dbo.add_attendee
	@i_status VARCHAR(20)

AS
    INSERT INTO [dbo].[attendees]
    (
     [status]
    )
    VALUES
    (
	@i_status
    )
    GO
GO

-- EXECUTE dbo.add_attendee @i_status=paid
