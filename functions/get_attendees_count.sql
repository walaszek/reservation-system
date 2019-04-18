IF OBJECT_ID (N'dbo.get_attendees_count', N'FN') IS NOT NULL
    DROP FUNCTION get_attendees_count;
GO

CREATE FUNCTION [dbo].[get_attendees_count] (@i_event_id INT)
RETURNS INT
AS
BEGIN
    -- status_id has to be different than CANCELED
    RETURN (ISNULL((SELECT SUM(regular_attendees_count + student_attendees_count) FROM dbo.reservations INNER JOIN transactions ON reservations.transaction_id = transactions.id WHERE event_id = @i_event_id AND transactions.status_id != 4), 0))
END;
GO

-- select dbo.get_attendees_count(3) as attendees_count;