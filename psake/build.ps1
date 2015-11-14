cls

Remove-Module [p]sake

#Import-Module ..\packages\psake.*\tools\psake.psm1
$psakeModule = ((Get-ChildItem ("..\packages\psake.4.4.2\tools\psake.psm1")).FullName | Sort-Object $_ | select -Last 1)

Import-Module $psakeModule

#Invoke-psake -buildFile .\default.ps1 -taskList Test -properties @{ "testMessage" = "What am I doing? "}
Invoke-psake -buildFile .\default.ps1 `
			 -taskList Test `
			 -properties @{"testMessage"="Testing"}`
			 -parameters @{"solutionFile" = "..\psake.sln"}
