select * from stg_Churn


Select Gender, Count (Gender) as TotalCount,
Count (Gender) * 100.0 / (Select Count(*) from stg_Churn) as Percentage
From stg_Churn
Group By Gender

SELECT Contract, Count (Contract) as TotalCount,
Count (Contract) * 1.0/ (Select Count(*) from Stg_Churn) as Percentage
from Stg_Churn
Group by Contract

SELECT Customer_Status, Count (Customer_Status) as TotalCount, Sum (Total_Revenue) as TotalRev, 
Sum(Total_Revenue) / (Select sum(Total_Revenue) from Stg_Churn) * 100 as RevPercentage 
from Stg_Churn
Group by Customer_Status

SELECT State, Count (State) as TotalCount,
Count (State) * 100.0 / (Select Count(*) from Stg_Churn) as Percentage
from Stg_Churn
Group by State
Order by Percentage desc

Select Distinct  Internet_Type
From stg_Churn



SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    ISNULL(Value_Deal, 'None') AS Value_Deal,
    Phone_Service,
    ISNULL(Multiple_Lines, 'No') As Multiple_Lines,
    Internet_Service,
    ISNULL(Internet_Type, 'None') AS Internet_Type,
    ISNULL(Online_Security, 'No') AS Online_Security,
    ISNULL(Online_Backup, 'No') AS Online_Backup,
    ISNULL(Device_Protection_Plan, 'No') AS Device_Protection_Plan,
    ISNULL(Premium_Support, 'No') AS Premium_Support,
    ISNULL(Streaming_TV, 'No') AS Streaming_TV,
    ISNULL(Streaming_Movies, 'No') AS Streaming_Movies,
    ISNULL(Streaming_Music, 'No') AS Streaming_Music,
    ISNULL(Unlimited_Data, 'No') AS Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    ISNULL(Churn_Category, 'Others') AS Churn_Category,
    ISNULL(Churn_Reason , 'Others') AS Churn_Reason

INTO [db_Churn].[dbo].[prod_Churn]
FROM [db_Churn].[dbo].[stg_Churn];

-- Drop the views if they exist
IF OBJECT_ID('vw_ChurnData', 'V') IS NOT NULL
    DROP VIEW vw_ChurnData;
GO

IF OBJECT_ID('vw_JoinData', 'V') IS NOT NULL
    DROP VIEW vw_JoinData;
GO

-- Recreate the views
CREATE VIEW vw_ChurnData AS
SELECT *
FROM prod_Churn
WHERE Customer_Status IN ('Churned', 'Stayed');
GO

CREATE VIEW vw_JoinData AS
SELECT *
FROM prod_Churn
WHERE Customer_Status = 'Joined';
GO

select @@SERVERNAME