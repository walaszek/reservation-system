IF OBJECT_ID (N'dbo.get_amount_of_event', N'FN') IS NOT NULL  
    DROP FUNCTION get_amount_of_event;  
GO 

CREATE FUNCTION [dbo].[get_amount_of_event] (@i_event_id INT, @i_regular_attendees_count INT = 0, @i_student_attendees_count INT = 0, @i_current_date DATETIME)
RETURNS MONEY
AS
BEGIN
    DECLARE @amount MONEY = 0;
    DECLARE @price MONEY;
    DECLARE @regular_discount INT;
    DECLARE @student_discount INT;

    SELECT @price = price, @student_discount = student_discount FROM dbo.events WHERE id = @i_event_id;
    SELECT @regular_discount = discount FROM dbo.price_thresholds WHERE event_id = @i_event_id AND start_date < @i_current_date AND end_date > @i_current_date;
    
    IF @regular_discount > 0
      SET @amount = @amount + @i_regular_attendees_count * (@price - @price * (@regular_discount / 100.0))
    ELSE
      SET @amount = @amount + @i_regular_attendees_count * @price

    IF @student_discount > 0
      SET @amount = @amount + @i_student_attendees_count * (@price - @price * (@student_discount / 100.0))
    ELSE
      SET @amount = @amount + @i_student_attendees_count * @price

    RETURN @amount;
END;
GO

-- select dbo.get_amount_of_event(1, 5, 0, '2019-10-11') as amount;