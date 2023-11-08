/* SQL Server 2019 Setup Files: 
https://www.microsoft.com/en-us/evalcenter/download-sql-server-2019 
Machine Learning Files:
https://go.microsoft.com/fwlink/?LinkId=2085686&lcid=1033
https://go.microsoft.com/fwlink/?LinkId=2085792&lcid=1033
https://go.microsoft.com/fwlink/?LinkId=2085793&lcid=1033
https://go.microsoft.com/fwlink/?LinkId=2085685&lcid=1033
*/

-- Configure External Scripting 
EXECUTE sp_configure 'external scripts enabled', '1'
GO
RECONFIGURE
GO
EXECUTE sp_configure 'external scripts enabled'
GO

-- Execute Python code:
EXECUTE sp_execute_external_script @language = N'Python', 
@script = N'
a = 10
b = 2
c = a / b
d = a * b
print(c, d)
'

