IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'add_reservation'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.add_reservation
GO

CREATE PROCEDURE dbo.add_reservation
	@i_customer_id INT,
	@i_date DATETIME,
	@i_event_id INT,
	@i_regular_attendees_count INT = 0,
	@i_student_attendees_count INT = 0

AS
    IF(NOT EXISTS (SELECT id FROM [dbo].[customers] WHERE id = @i_customer_id))
      THROW 50001, 'The customer does not exist.', 1;

    IF(NOT EXISTS (SELECT id FROM [dbo].[events] WHERE id = @i_event_id))
      THROW 50002, 'The event does not exist.', 1;

    DECLARE @current_date DATETIME = GETUTCDATE();
    DECLARE @transaction_id INT;
    DECLARE @parent_id INT = NULL;

    DECLARE @attendees_count INT = (SELECT dbo.get_attendees_count(@i_event_id));
    DECLARE @attendees_limit INT = 0;

    SELECT @attendees_limit = attendees_limit, @parent_id = parent_id FROM [dbo].[events] WHERE id = @i_event_id;

    DECLARE @amount MONEY = (SELECT dbo.get_amount_of_event(@i_event_id, @i_regular_attendees_count, @i_student_attendees_count, @current_date));

    IF ((@i_regular_attendees_count + @i_student_attendees_count + @attendees_count) > @attendees_limit)
      THROW 50003, 'The event attendes limit reached.', 1;
    
    IF (@parent_id IS NOT NULL)
      EXECUTE dbo.add_reservation @i_customer_id=@i_customer_id, @i_date=@i_date, @i_event_id=@parent_id, @i_regular_attendees_count=@i_regular_attendees_count, @i_student_attendees_count=@i_student_attendees_count

    BEGIN
      EXECUTE dbo.add_transaction @i_amount = @amount, @i_status_id = 1, @o_id = @transaction_id OUTPUT;

      INSERT INTO [dbo].[reservations]
      (
        [customer_id], [date], [event_id], [regular_attendees_count], [student_attendees_count], [transaction_id]
      )
      VALUES
      (
        @i_customer_id, @i_date,	@i_event_id, @i_regular_attendees_count, @i_student_attendees_count, @transaction_id
      )
    END
GO

-- EXECUTE dbo.add_reservation @i_customer_id=1, @i_date="1900-01-01 00:00:00", @i_event_id=3, @i_regular_attendees_count=1, @i_student_attendees_count=0
