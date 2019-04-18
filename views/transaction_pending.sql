DROP VIEW IF EXISTS [dbo].[transaction_pending]
GO

CREATE VIEW dbo.transaction_pending
AS   
  SELECT
    reservations.id as reservation_id,
    transactions.amount as transaction_amount,
    customers.name as customer_name
    
    FROM reservations
    INNER JOIN transactions ON transactions.id = reservations.transaction_id
    INNER JOIN customers ON customers.id = reservations.customer_id
    WHERE (transactions.status_id = 1 or transactions.status_id = 3)
GO

-- SELECT * FROM individual_customers;
