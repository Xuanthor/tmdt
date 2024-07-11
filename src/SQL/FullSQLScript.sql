USE [UserDB]  /*Change your database name if you want*/
GO
/****** Object:  Table [dbo].[MsgTable]    Script Date: 25-Jan-17 1:24:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MsgTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChatMsg] [nvarchar](max) NOT NULL,
	[MsgSender] [nvarchar](50) NOT NULL,
	[MsgReceiver] [nvarchar](50) NOT NULL,
	[RecevierSeen] [int] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserDatabase]    Script Date: 25-Jan-17 1:24:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDatabase](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](50) NOT NULL,
	[OnlineStatus] [int] NULL,
PRIMARY KEY CLUSTERED
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[MsgTable] ADD  DEFAULT ((0)) FOR [RecevierSeen]
GO
ALTER TABLE [dbo].[MsgTable]  WITH CHECK ADD  CONSTRAINT [FK_MsgReceiver_Username] FOREIGN KEY([MsgReceiver])
REFERENCES [dbo].[UserDatabase] ([Username])
GO
ALTER TABLE [dbo].[MsgTable] CHECK CONSTRAINT [FK_MsgReceiver_Username]
GO
ALTER TABLE [dbo].[MsgTable]  WITH CHECK ADD  CONSTRAINT [FK_MsgSender_Username] FOREIGN KEY([MsgSender])
REFERENCES [dbo].[UserDatabase] ([Username])
GO
ALTER TABLE [dbo].[MsgTable] CHECK CONSTRAINT [FK_MsgSender_Username]
GO
/****** Object:  StoredProcedure [dbo].[AddMsgToTable]    Script Date: 25-Jan-17 1:24:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddMsgToTable]
@msg nvarchar(MAX),
@SenderName nvarchar(50),
@ReciverName nvarchar(50)
as
begin
	Insert into msgtable (chatMsg, MsgSender, msgReceiver) values(@msg, @SenderName, @ReciverName)
end
GO
/****** Object:  StoredProcedure [dbo].[ProcIsUserExist]    Script Date: 25-Jan-17 1:24:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ProcIsUserExist]
@Uname nvarchar(50),
@EId nvarchar(50)
as
begin
	Declare @Ucount int
	Declare @EmailCount int
	Declare @returnId int

	select @EmailCount = COUNT(*) from UserDatabase where Email = @EId
	select @Ucount = COUNT(*) from UserDatabase where Username = @Uname


	if @Ucount = 0 and @EmailCount = 0
	begin
		set @returnId = 0 /* User Does not exist*/
	end
	else if @Ucount <> 0  and  @EmailCount <> 0
	begin
		set @returnId = -1 /* Both email & usermane are exist*/
	end
	else if @Ucount = 0  and  @EmailCount <> 0
	begin
		set @returnId = -2 /*only Email is exist*/
	end
	else
	begin
		set @returnId = -3 /*only username is exist*/
	end

	select @returnId as ReturnCode
end
GO




USE [UserDB]
GO

INSERT INTO [dbo].[UserDatabase] ([Username], [Email], [Password], [Country], [OnlineStatus])
VALUES ('john_doe', 'john@example.com', 'password123', 'USA', 1);

INSERT INTO [dbo].[UserDatabase] ([Username], [Email], [Password], [Country], [OnlineStatus])
VALUES ('jane_smith', 'jane@example.com', 'password456', 'Canada', 0);

INSERT INTO [dbo].[UserDatabase] ([Username], [Email], [Password], [Country], [OnlineStatus])
VALUES ('alice_wang', 'alice@example.com', 'password789', 'China', 1);

USE [UserDB]
GO

INSERT INTO [dbo].[MsgTable] ([ChatMsg], [MsgSender], [MsgReceiver], [RecevierSeen])
VALUES ('Hello Jane!', 'john_doe', 'jane_smith', 0);

INSERT INTO [dbo].[MsgTable] ([ChatMsg], [MsgSender], [MsgReceiver], [RecevierSeen])
VALUES ('Hi John!', 'jane_smith', 'john_doe', 0);

INSERT INTO [dbo].[MsgTable] ([ChatMsg], [MsgSender], [MsgReceiver], [RecevierSeen])
VALUES ('Hello Alice!', 'jane_smith', 'alice_wang', 0);


USE [UserDB]
GO

EXEC [dbo].[AddMsgToTable] @msg = 'Hello John!', @SenderName = 'jane_smith', @ReciverName = 'john_doe';
EXEC [dbo].[AddMsgToTable] @msg = 'How are you?', @SenderName = 'john_doe', @ReciverName = 'jane_smith';
