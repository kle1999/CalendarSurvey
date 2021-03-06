USE [calendarsurvey]
GO
/****** Object:  Table [dbo].[operation]    Script Date: 07/29/2013 13:56:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[operation](
	[id] [int] NOT NULL,
	[operation] [nvarchar](50) NULL,
	[operationLink] [nvarchar](50) NULL,
	[description] [nvarchar](500) NULL,
	[role] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[investigators]    Script Date: 07/29/2013 13:56:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[investigators](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[piName] [nvarchar](50) NULL,
	[role] [int] NULL,
	[lName] [nvarchar](50) NULL,
	[fName] [nvarchar](50) NULL,
	[degree] [nvarchar](50) NULL,
	[votingMember] [bit] NULL,
	[userName] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[department] [nvarchar](50) NULL,
	[startDate] [nvarchar](50) NULL,
	[endDate] [nvarchar](50) NULL,
	[isLoginCalendarBegin] [bit] NULL,
	[smoke] [bit] NULL,
	[drink] [bit] NULL,
	[alcohol] [bit] NULL,
	[confirmAnswer] [bit] NULL,
	[ecig] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[events]    Script Date: 07/29/2013 13:56:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[events](
	[eventID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eventDate] [datetime] NULL,
	[eventText] [nvarchar](4000) NULL,
	[userAutoID] [nvarchar](50) NULL,
	[drink] [nvarchar](50) NULL,
	[smoke] [nvarchar](50) NULL,
	[dataTouch] [bit] NULL,
	[ecig] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 07/29/2013 13:56:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[autoID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userID] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NULL,
	[role] [nvarchar](50) NULL,
	[lName] [nvarchar](50) NULL,
	[fName] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[calculateDate] [bit] NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userProperty]    Script Date: 07/29/2013 13:56:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userProperty](
	[autoID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userAutoID] [nvarchar](50) NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempTableSearch]    Script Date: 07/29/2013 13:56:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tempTableSearch](
	[userAutoID] [int] NULL,
	[lName] [nvarchar](50) NULL,
	[fName] [nvarchar](50) NULL,
	[userName] [nvarchar](50) NULL,
	[eventID] [int] NOT NULL,
	[eventDate] [datetime] NULL,
	[eventText] [nvarchar](4000) NULL,
	[drink] [nvarchar](50) NULL,
	[smoke] [nvarchar](50) NULL,
	[ecig] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spCustomerLogin]    Script Date: 07/29/2013 13:56:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spCustomerLogin]
    (
        @userID      nvarchar(50),
        @Password   nvarchar(50),
        @autoID int OUTPUT
    )
    AS
    SELECT
        @autoID = autoID
    FROM
       users
    WHERE
       userID = @userID
      AND
        Password = @Password
    IF @@Rowcount < 1
    SELECT
        @autoID = 0
GO
/****** Object:  StoredProcedure [dbo].[CustomerLogin]    Script Date: 07/29/2013 13:56:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CustomerLogin] 
	-- Add the parameters for the stored procedure here
	 @userName      nvarchar(50),
        @Password   nvarchar(50),
        @ID int OUTPUT
AS
SELECT
        @ID = ID
    FROM
        investigators
    WHERE
       userName = @userName
      AND
        Password = @Password
    IF @@Rowcount < 1
    SELECT
        @ID = 0
GO
/****** Object:  StoredProcedure [dbo].[CustomerDetail]    Script Date: 07/29/2013 13:56:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CustomerDetail]
	-- Add the parameters for the stored procedure here
	    @ID int,
		@userName   nvarchar(50) OUTPUT,
        @FullName   nvarchar(50) OUTPUT,
        @lName   nvarchar(50) OUTPUT,
        @fName   nvarchar(50) OUTPUT,
        @Email      nvarchar(50) OUTPUT,
        @startDate  nvarchar(50) OUTPUT,
		@endDate  nvarchar(50) OUTPUT,
	    @role	int OUTPUT,
        @address	nvarchar(200) OUTPUT,
        @phone nvarchar(50) OUTPUT,
        @degree	nvarchar(50) OUTPUT,
        @drink	int OUTPUT,
       @smoke	int OUTPUT
	
AS
  SELECT
		@userName = userName,
        @FullName = piName,
        @lName = lName,
        @fName = fName,
        @Email    = Email,
        @startDate = startDate,
	    @endDate = endDate,
		@role	=role,
        @address	=address,
        @phone	=phone,
        @degree	=degree,
        @drink=drink,
        @smoke=smoke
	

    FROM
        investigators
    WHERE
        ID = @ID
GO
/****** Object:  StoredProcedure [dbo].[CalendarDetails]    Script Date: 07/29/2013 13:56:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalendarDetails] 
	-- Add the parameters for the stored procedure here
	@eventID int,
			@eventText   nvarchar(4000) OUTPUT,
        @eventDate   nvarchar(50) OUTPUT,
	@drink nvarchar(50) Output,
              @smoke nvarchar(50) Output

AS
SELECT
		@eventText = eventText,
        @eventDate = eventDate,
	@drink=drink,
	@smoke=smoke
        
    FROM
        events
    WHERE
        eventID = @eventID
GO
/****** Object:  Default [DF_events_dataTouch]    Script Date: 07/29/2013 13:56:47 ******/
ALTER TABLE [dbo].[events] ADD  CONSTRAINT [DF_events_dataTouch]  DEFAULT ((0)) FOR [dataTouch]
GO
/****** Object:  Default [DF_investigators_smoke]    Script Date: 07/29/2013 13:56:47 ******/
ALTER TABLE [dbo].[investigators] ADD  CONSTRAINT [DF_investigators_smoke]  DEFAULT (0) FOR [smoke]
GO
/****** Object:  Default [DF_investigators_drink]    Script Date: 07/29/2013 13:56:47 ******/
ALTER TABLE [dbo].[investigators] ADD  CONSTRAINT [DF_investigators_drink]  DEFAULT (0) FOR [drink]
GO
/****** Object:  Default [DF_investigators_confirmAnswer]    Script Date: 07/29/2013 13:56:47 ******/
ALTER TABLE [dbo].[investigators] ADD  CONSTRAINT [DF_investigators_confirmAnswer]  DEFAULT (0) FOR [confirmAnswer]
GO
