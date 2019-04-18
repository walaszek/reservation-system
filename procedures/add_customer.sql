IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'add_customer'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.add_customer
GO

CREATE PROCEDURE dbo.add_customer
    @i_name VARCHAR(25),
    @i_vat_id VARCHAR(12) = NULL,
    @i_phone_number VARCHAR(14),
    @i_e_mail VARCHAR(255)
AS
    INSERT INTO [dbo].[customers]
    (
     [name], [vat_id], [phone_number], [e_mail]
    )
    VALUES
    (
     @i_name, @i_vat_id, @i_phone_number, @i_e_mail
    )
    GO
GO

-- EXECUTE dbo.add_customer @i_name="nowy klient", @i_vat_id="123123123", @i_phone_number="+48690112100", @i_e_mail="jakisadresemail@example.com" 
