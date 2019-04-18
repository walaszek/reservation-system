IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'add_attendee_to_reservation'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.add_attendee_to_reservation
GO

CREATE PROCEDURE dbo.add_attendee_to_reservation
	@i_attendee_id INT,
  @i_reservation_id INT

AS
    INSERT INTO [dbo].[add_attendee_to_reservation]
    (
     [attendee_id],
     [reservation_id],
    )
    VALUES
    (
	    @i_attendee_id
      @i_reservation_id
    )
    GO
GO

-- EXECUTE dbo.add_attendee_to_reservation @i_attendee_id = 1, @i_reservation_id = 1
