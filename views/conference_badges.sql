DROP VIEW IF EXISTS [dbo].[conference_badges]
GO

CREATE VIEW dbo.conference_badges
AS   
  SELECT
    conferences.id as conference_id,
    conferences.name as conference_name,
    attendees.name AS attendee_name,
    CASE WHEN customers.vat_id IS NOT NULL
       THEN customers.name
       ELSE NULL
    END AS company_name
    FROM attendees
    INNER JOIN attendes_on_reservations ON attendes_on_reservations.attendee_id = attendees.id
    INNER JOIN reservations ON reservations.id = attendes_on_reservations.reservation_id
    INNER JOIN transactions ON transactions.id = reservations.transaction_id
    INNER JOIN events ON events.id = reservations.event_id
    INNER JOIN conferences ON conferences.id = events.conference_id
    INNER JOIN customers ON customers.id = reservations.customer_id
    WHERE transactions.status_id = 2
GO

-- SELECT * FROM conference_badges WHERE id = 1
