DROP VIEW IF EXISTS [dbo].[individual_customers]
GO

CREATE VIEW dbo.individual_customers
AS   
    SELECT id, name, phone_number, e_mail FROM customers WHERE vat_id IS NULL
GO

-- SELECT * FROM individual_customers;
