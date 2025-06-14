DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += 'ALTER TABLE [' + s.name + '].[' + t.name + '] DROP CONSTRAINT [' + fk.name + '];' + CHAR(13)
FROM sys.foreign_keys fk
INNER JOIN sys.tables t ON fk.parent_object_id = t.object_id
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'gold';

EXEC sp_executesql @sql;

drop table if exists gold.Fact_Admissions
drop table if exists gold.Fact_Appointments
drop table if exists gold.Fact_Billing
drop table if exists gold.Fact_MedicinePurchases
drop table if exists gold.Fact_PatientStay
drop table if exists gold.Fact_PatientVitals
drop table if exists gold.Fact_Tests
drop table if exists gold.Agg_BedOccupancy
drop table if exists gold.Agg_DoctorPerformance
drop table if exists gold.Agg_MonthlyRevenue
drop table if exists gold.Dim_Bed
drop table if exists gold.Dim_Date
drop table if exists  GOLD.Dim_Time
drop table if exists gold.Dim_Department
drop table if exists gold.Dim_Doctor
drop table if exists gold.Dim_Medicine
drop table if exists gold.Dim_Patient
drop table if exists gold.Dim_PaymentMethod
drop table if exists gold.Dim_Room
drop table if exists gold.Dim_Supplier
drop table if exists gold.Dim_Test
