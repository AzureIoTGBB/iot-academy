IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'AverageTemperature')
BEGIN
    CREATE DATABASE [AverageTemperature]
END
GO
   USE [AverageTemperature]
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AverageTemperature' and xtype='U')
BEGIN
    CREATE TABLE AverageTemperature (
        [When] datetime PRIMARY KEY,
        [AverageTemperature] float(24)
    )
END

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'AverageTemperatureStreaming')
  BEGIN
    CREATE DATABASE [AverageTemperatureStreaming]
  END
GO
   USE [AverageTemperatureStreaming]
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AverageTemperature' and xtype='U')
BEGIN
    CREATE TABLE AverageTemperature (
        [When] datetime PRIMARY KEY,
        [AverageTemperature] float(24)
    )
END
