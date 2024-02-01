CREATE TABLE [Dim_Date] (
  [Date_SK] int  NOT NULL,
  [FullDateAK] date  NOT NULL,
  [DayNumberOfWeek] int  NOT NULL,
  [DayNameOfWeek] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [DayNumberOfMonth] int  NOT NULL,
  [DayNumberOfYear] int  NOT NULL,
  [WeekNumberOfYear] int  NOT NULL,
  [MonthName] nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
  [MonthNumberOfYear] int  NOT NULL,
  [CalendarQuarter] int  NOT NULL,
  [CalendarYear] smallint  NOT NULL,
  CONSTRAINT [PK__Dim_Date__A4262D75D6BC5B9B] PRIMARY KEY NONCLUSTERED ([Date_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
ALTER TABLE [Dim_Date] SET (LOCK_ESCALATION = TABLE)
GO

CREATE TABLE [dim_Action] (
  [Action_SK] int NOT NULL,
  [Action] varchar(130),
  CONSTRAINT [_copy_5] PRIMARY KEY CLUSTERED ([Action_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [dim_Boro] (
  [Boro_SK] int NOT NULL,
  [Boro] varchar(13),
  CONSTRAINT [_copy_7] PRIMARY KEY CLUSTERED ([Boro_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [dim_CriticalFlag] (
  [CriticalFlag_SK] int NOT NULL,
  [criticalflag] char(14),
  CONSTRAINT [_copy_1] PRIMARY KEY CLUSTERED ([CriticalFlag_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [dim_CuisineDescription] (
  [CuisineDescription_SK] int NOT NULL,
  [CuisineDescription] varchar(30),
  CONSTRAINT [_copy_3] PRIMARY KEY CLUSTERED ([CuisineDescription_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [dim_Date] (

)
GO

CREATE TABLE [dim_Geography] (
  [Geo_SK] int NOT NULL,
  [building] nvarchar(10) NULL,
  [street] varchar(40),
  [zipcode] char(5),
  [city] varchar(50),
  [state] varchar(50),
  [country] varchar(50),
  [latitude] float(53),
  [longitude] float(53),
  [location_point] bit,
  PRIMARY KEY CLUSTERED ([Geo_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [dim_Grade] (
  [Grade_SK] int NOT NULL,
  [Grade] char(2),
  CONSTRAINT [_copy_4] PRIMARY KEY CLUSTERED ([Grade_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [dim_InspectionType] (
  [InspectionType_SK] int NOT NULL,
  [inspectiontype] varchar(59),
  CONSTRAINT [_copy_6] PRIMARY KEY CLUSTERED ([InspectionType_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [dim_Restaurant] (
  [Restaurant_SK] int NOT NULL,
  [camis] int,
  [name] nvarchar(95),
  [phone] char(12),
  CONSTRAINT [_copy_8] PRIMARY KEY CLUSTERED ([Restaurant_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [dim_Violation] (
  [Violation_SK] int NOT NULL,
  [violationcode] char(5),
  [violationdescription] nvarchar(234),
  CONSTRAINT [_copy_2] PRIMARY KEY CLUSTERED ([Violation_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

CREATE TABLE [fact_Score] (
  [Score_SK] int NOT NULL,
  [Score] int NOT NULL,
  [inspectiondate] datetime2 NOT NULL,
  [Geo_SK] int NOT NULL,
  [Restaurant_SK] int NOT NULL,
  [Boro_SK] int NOT NULL,
  [InspectionType_SK] int NOT NULL,
  [Action_SK] int NOT NULL,
  [CuisineDescription_SK] int NOT NULL,
  [Grade_SK] int NOT NULL,
  [CriticalFlag_SK] int NOT NULL,
  [RecordDate_SK] int NOT NULL,
  [Violation_SK] int NOT NULL,
  [InspectionDate_SK] int NOT NULL,
  [GradeDate_SK] int NOT NULL,
  PRIMARY KEY CLUSTERED ([Score_SK])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO

ALTER TABLE [fact_Score] ADD CONSTRAINT [fk_fact_Score_dim_Geography_1] FOREIGN KEY ([Geo_SK]) REFERENCES [dim_Geography] ([Geo_SK])
GO
ALTER TABLE [fact_Score] ADD CONSTRAINT [fk_fact_Score_dim_Restaurant_1] FOREIGN KEY ([Restaurant_SK]) REFERENCES [dim_Restaurant] ([Restaurant_SK])
GO
ALTER TABLE [fact_Score] ADD CONSTRAINT [fk_fact_Score_dim_Boro_1] FOREIGN KEY ([Boro_SK]) REFERENCES [dim_Boro] ([Boro_SK])
GO
ALTER TABLE [fact_Score] ADD CONSTRAINT [fk_fact_Score_dim_InspectionType_1] FOREIGN KEY ([InspectionType_SK]) REFERENCES [dim_InspectionType] ([InspectionType_SK])
GO
ALTER TABLE [fact_Score] ADD CONSTRAINT [fk_fact_Score_dim_Action_1] FOREIGN KEY ([Action_SK]) REFERENCES [dim_Action] ([Action_SK])
GO
ALTER TABLE [fact_Score] ADD CONSTRAINT [fk_fact_Score_dim_CuisineDescription_1] FOREIGN KEY ([CuisineDescription_SK]) REFERENCES [dim_CuisineDescription] ([CuisineDescription_SK])
GO
ALTER TABLE [fact_Score] ADD CONSTRAINT [fk_fact_Score_dim_Grade_1] FOREIGN KEY ([Grade_SK]) REFERENCES [dim_Grade] ([Grade_SK])
GO
ALTER TABLE [fact_Score] ADD CONSTRAINT [fk_fact_Score_dim_CriticalFlag_1] FOREIGN KEY ([CriticalFlag_SK]) REFERENCES [dim_CriticalFlag] ([CriticalFlag_SK])
GO
ALTER TABLE [fact_Score] ADD CONSTRAINT [fk_fact_Score_dim_Violation_1] FOREIGN KEY ([Violation_SK]) REFERENCES [dim_Violation] ([Violation_SK])
GO

CREATE VIEW [VW_dim_GradeDate] AS SELECT
	Dim_Date.DateSK as GradeDate_SK, 
	Dim_Date.GradeDate, 
	Dim_Date.DayNumberOfWeek, 
	Dim_Date.DayNameOfWeek, 
	Dim_Date.DayNumberOfMonth, 
	Dim_Date.DayNumberOfYear, 
	Dim_Date.WeekNumberOfYear, 
	Dim_Date.MonthName, 
	Dim_Date.MonthNumberOfYear, 
	Dim_Date.CalendarQuarter, 
	Dim_Date.CalendarYear
FROM
	dbo.Dim_Date d, dbo.fact_Score s
	where s.GradeDate_SK = d.Date_SK
GO

CREATE VIEW [VW_dim_InspectionDate] AS SELECT
	Dim_Date.DateSK as InspectionDate_SK, 
	Dim_Date.InspectionDate, 
	Dim_Date.DayNumberOfWeek, 
	Dim_Date.DayNameOfWeek, 
	Dim_Date.DayNumberOfMonth, 
	Dim_Date.DayNumberOfYear, 
	Dim_Date.WeekNumberOfYear, 
	Dim_Date.MonthName, 
	Dim_Date.MonthNumberOfYear, 
	Dim_Date.CalendarQuarter, 
	Dim_Date.CalendarYear
FROM
	dbo.Dim_Date d, dbo.fact_Score s
	where s.InspectionDate_SK = d.Date_SK
GO

CREATE VIEW [VW_dim_RecordDate] AS SELECT
	Dim_Date.DateSK as RecordDate_SK, 
	Dim_Date.RecordDate, 
	Dim_Date.DayNumberOfWeek, 
	Dim_Date.DayNameOfWeek, 
	Dim_Date.DayNumberOfMonth, 
	Dim_Date.DayNumberOfYear, 
	Dim_Date.WeekNumberOfYear, 
	Dim_Date.MonthName, 
	Dim_Date.MonthNumberOfYear, 
	Dim_Date.CalendarQuarter, 
	Dim_Date.CalendarYear,
FROM
	dbo.Dim_Date d, dbo.fact_Score s
	where s.RecordDate_SK = d.Date_SK
GO

