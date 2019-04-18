IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'add_event'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.add_event
GO

CREATE PROCEDURE dbo.add_event
	@i_parent_id INT = NULL,
	@i_conference_id INT = NULL,
	@i_name VARCHAR(100),
	@i_start_date DATETIME,
	@i_end_date DATETIME,
	@i_attendees_limit INT = 0,
	@i_price MONEY,
	@i_student_discount INT = 0
    
AS
    IF (
        (@i_conference_id IS NOT NULL AND @i_parent_id IS NULL)
        OR
        (@i_conference_id IS NULL AND @i_parent_id IS NOT NULL)
    )
	BEGIN
		IF((@i_parent_id IS NOT NULL) AND ((SELECT start_date FROM [dbo].[events] WHERE id = @i_parent_id)>@i_start_date OR (SELECT end_date FROM [dbo].[events] WHERE id = @i_parent_id)<@i_end_date))
		THROW 50004, 'Workshop longer or shorter than conference.', 1;
		INSERT INTO [dbo].[events]
		(
		 [parent_id], [conference_id], [name], [start_date], [end_date], [attendees_limit], [price], [student_discount]
		)
		VALUES
		(
		 @i_parent_id, @i_conference_id, @i_name, @i_start_date, @i_end_date, @i_attendees_limit, @i_price, @i_student_discount
		)
	END
    GO
GO

--EXECUTE dbo.add_event @i_conference_id=1, @i_name="google day 1", @i_start_date="1900-01-02 00:00:00", @i_end_date="1900-01-07 00:00:00", @i_price=250.50
--EXECUTE dbo.add_event @i_conference_id=null, @i_parent_id=1, @i_name="nowy warsztat google day 2 2", @i_start_date="1900-01-03 02:00:00", @i_end_date="1900-01-04 05:02:00", @i_price=250.50
