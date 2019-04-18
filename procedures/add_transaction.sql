IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'add_transaction'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.add_transaction
GO

CREATE PROCEDURE dbo.add_transaction
    @i_amount MONEY,
    @i_status_id INT,
    @o_id INT = NULl OUTPUT
    
AS
IF(NOT EXISTS (SELECT id FROM [dbo].[transaction_statuses] WHERE id = @i_status_id))
      THROW 50005, 'The status does not exist.', 1;
BEGIN
    SET NOCOUNT ON

    INSERT INTO [dbo].[transactions]
    (
     [amount],
     [status_id]
    )
    VALUES
    (
      @i_amount,
      @i_status_id
    )
    
    SET @o_id = SCOPE_IDENTITY()
END
GO

EXECUTE dbo.add_transaction @i_amount=102.04, @i_status_id=5
