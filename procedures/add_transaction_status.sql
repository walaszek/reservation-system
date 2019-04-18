IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'add_transaction_status'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.add_transaction_status
GO

CREATE PROCEDURE dbo.add_transaction_status
	@i_status VARCHAR(20)

AS
    INSERT INTO [dbo].[transaction_statuses]
    (
      [status]
    )
    VALUES
    (
	    @i_status
    )
    GO
GO

EXECUTE dbo.add_transaction_status @i_status = "PENDING"
EXECUTE dbo.add_transaction_status @i_status = "SUCCESS"
EXECUTE dbo.add_transaction_status @i_status = "ERROR"
EXECUTE dbo.add_transaction_status @i_status = "CANCELED"
