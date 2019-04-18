DROP VIEW IF EXISTS [dbo].[corporate_customers]
GO

CREATE VIEW dbo.corporate_customers
AS   
    SELECT id, name, vat_id, phone_number, e_mail FROM customers WHERE vat_id IS NOT NULL
GO

-- SELECT * FROM corporate_customers;
