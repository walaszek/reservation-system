IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'add_event_price_thresholds'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.add_event_price_thresholds
GO

CREATE PROCEDURE dbo.add_event_price_thresholds
	@i_event_id INT,
	@i_discount INT,
	@i_start_date DATETIME,
	@i_end_date DATETIME

AS
IF(NOT EXISTS (SELECT id FROM [dbo].[events] WHERE id = @i_event_id))
      THROW 50006, 'The event does not exist.', 1;
IF((SELECT parent_id FROM [dbo].[events] WHERE id = @i_event_id) IS NOT null)
      THROW 50007, 'price thresholds for workshops is forbidden.', 1;
    IF EXISTS (SELECT id FROM [dbo].[events] WHERE id = @i_event_id)
    INSERT INTO [dbo].[price_thresholds]
    (
     [event_id], [discount], [start_date], [end_date]
    )
    VALUES
    (
	  @i_event_id, @i_discount, @i_start_date, @i_end_date
    )
    GO
GO

EXECUTE dbo.add_event_price_thresholds @i_event_id = 1, @i_discount = 22, @i_start_date = '2019-10-10', @i_end_date = '2019-10-13'
EXECUTE dbo.add_event_price_thresholds @i_event_id = 2, @i_discount = 22, @i_start_date = '2019-10-10', @i_end_date = '2019-10-13'
EXECUTE dbo.add_event_price_thresholds @i_event_id = 3, @i_discount = 22, @i_start_date = '2019-10-10', @i_end_date = '2019-10-13'
EXECUTE dbo.add_event_price_thresholds @i_event_id = 4, @i_discount = 22, @i_start_date = '2019-10-10', @i_end_date = '2019-10-13'
