IF OBJECT_ID('[dbo].[attendes_on_reservations]', 'U') IS NOT NULL
DROP TABLE [dbo].[attendes_on_reservations]
GO

CREATE TABLE [dbo].[attendes_on_reservations] (
	attendee_id INT NOT NULL,
	reservation_id INT NOT NULL
)
GO

IF OBJECT_ID('[dbo].[attendees]', 'U') IS NOT NULL
DROP TABLE [dbo].[attendees]
GO

CREATE TABLE [dbo].[attendees] (
	id INT IDENTITY(1,1) NOT NULL,
	name VARCHAR(25) NOT NULL,
  CONSTRAINT [PK_ATTENDEES] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

IF OBJECT_ID('[dbo].[reservations]', 'U') IS NOT NULL
DROP TABLE [dbo].[reservations]
GO

CREATE TABLE [dbo].[reservations] (
	id INT IDENTITY(1,1) NOT NULL,
	customer_id INT NOT NULL,
	event_id INT NOT NULL,
  date DATETIME NOT NULL,
	transaction_id INT NOT NULL,
	regular_attendees_count INT NOT NULL,
	student_attendees_count INT NOT NULL,
  CONSTRAINT [PK_RESERVATIONS] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

IF OBJECT_ID('[dbo].[customers]', 'U') IS NOT NULL
DROP TABLE [dbo].[customers]
GO

CREATE TABLE [dbo].[customers] (
	id INT IDENTITY(1,1) NOT NULL,
	name VARCHAR(25) NOT NULL,
	vat_id VARCHAR(12),
	phone_number VARCHAR(14) NOT NULL,
	e_mail VARCHAR(255) NOT NULL,
  CONSTRAINT [PK_CUSTOMERS] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

IF OBJECT_ID('[dbo].[transactions]', 'U') IS NOT NULL
DROP TABLE [dbo].[transactions]
GO

CREATE TABLE [dbo].[transactions] (
	id INT IDENTITY(1,1) NOT NULL,
	amount MONEY NOT NULL,
	status_id INT NOT NULL,
  CONSTRAINT [PK_TRANSACTIONS] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

IF OBJECT_ID('[dbo].[transaction_statuses]', 'U') IS NOT NULL
DROP TABLE [dbo].[transaction_statuses]
GO

CREATE TABLE [dbo].[transaction_statuses] (
	id INT IDENTITY(1,1) NOT NULL,
	status VARCHAR(20) NOT NULL,
  CONSTRAINT [PK_TRANSACTION_STATUSES] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

IF OBJECT_ID('[dbo].[price_thresholds]', 'U') IS NOT NULL
DROP TABLE [dbo].[price_thresholds]
GO

CREATE TABLE [dbo].[price_thresholds] (
	event_id INT NOT NULL,
	discount INT NOT NULL,
	start_date DATETIME NOT NULL,
	end_date DATETIME NOT NULL
)
GO

IF OBJECT_ID('[dbo].[events]', 'U') IS NOT NULL
DROP TABLE [dbo].[events]
GO

CREATE TABLE [dbo].[events] (
	id INT IDENTITY(1,1) NOT NULL,
	parent_id INT,
	conference_id INT,
	name VARCHAR(100) NOT NULL,
	start_date DATETIME NOT NULL,
	end_date DATETIME NOT NULL,
	attendees_limit INT NOT NULL,
	price MONEY NOT NULL,
	student_discount INT NOT NULL,
  CONSTRAINT [PK_EVENTS] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

IF OBJECT_ID('[dbo].[conferences]', 'U') IS NOT NULL
DROP TABLE [dbo].[conferences]
GO

CREATE TABLE [dbo].[conferences] (
	id INT IDENTITY(1,1) NOT NULL,
	name VARCHAR(100) NOT NULL,
	start_date DATETIME NOT NULL,
	end_date DATETIME NOT NULL,
  CONSTRAINT [PK_CONFERENCES] PRIMARY KEY CLUSTERED
  (
  [id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

ALTER TABLE [events] WITH CHECK ADD CONSTRAINT [events_fk0] FOREIGN KEY ([parent_id]) REFERENCES [events]([id])
ON UPDATE NO ACTION
GO
ALTER TABLE [events] CHECK CONSTRAINT [events_fk0]
GO

ALTER TABLE [events] WITH CHECK ADD CONSTRAINT [events_fk1] FOREIGN KEY ([conference_id]) REFERENCES [conferences]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [events] CHECK CONSTRAINT [events_fk1]
GO

ALTER TABLE [reservations] WITH CHECK ADD CONSTRAINT [reservations_fk0] FOREIGN KEY ([customer_id]) REFERENCES [customers]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [reservations] CHECK CONSTRAINT [reservations_fk0]
GO
ALTER TABLE [reservations] WITH CHECK ADD CONSTRAINT [reservations_fk1] FOREIGN KEY ([event_id]) REFERENCES [events]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [reservations] CHECK CONSTRAINT [reservations_fk1]
GO
ALTER TABLE [reservations] WITH CHECK ADD CONSTRAINT [reservations_fk2] FOREIGN KEY ([transaction_id]) REFERENCES [transactions]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [reservations] CHECK CONSTRAINT [reservations_fk2]
GO

ALTER TABLE [transactions] WITH CHECK ADD CONSTRAINT [transactions_fk0] FOREIGN KEY ([status_id]) REFERENCES [transaction_statuses]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [transactions] CHECK CONSTRAINT [transactions_fk0]
GO




ALTER TABLE [price_thresholds] WITH CHECK ADD CONSTRAINT [price_thresholds_fk0] FOREIGN KEY ([event_id]) REFERENCES [events]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [price_thresholds] CHECK CONSTRAINT [price_thresholds_fk0]
GO

ALTER TABLE [attendes_on_reservations] WITH CHECK ADD CONSTRAINT [attendes_on_reservations_fk0] FOREIGN KEY ([attendee_id]) REFERENCES [attendees]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [attendes_on_reservations] CHECK CONSTRAINT [attendes_on_reservations_fk0]
GO
ALTER TABLE [attendes_on_reservations] WITH CHECK ADD CONSTRAINT [attendes_on_reservations_fk1] FOREIGN KEY ([reservation_id]) REFERENCES [reservations]([id])
ON UPDATE CASCADE
GO
ALTER TABLE [attendes_on_reservations] CHECK CONSTRAINT [attendes_on_reservations_fk1]
GO

