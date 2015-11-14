cls

Remove-Module [p]sake

#Import-Module ..\packages\psake.*\tools\psake.psm1
$psakeModule = ((Get-ChildItem (".\packages\psake*\tools\psake.psm1")).FullName | Sort-Object $_ | select -Last 1)

Import-Module $psakeModule

#Invoke-psake -buildFile .\default.ps1 -taskList Test -properties @{ "testMessage" = "What am I doing? "}
Invoke-psake -buildFile .\psake\default.ps1 `
			 -taskList Test `
			 -framework 4.5.2 `
			 -properties @{ 
				 "buildConfiguration"="Release"
				 "buildPlatform"="Any CPU"}`
			 -parameters @{"solutionFile" = "..\psake.sln"}

Write-Host "Build exit code:" $LASTEXITCODE

#Propagating the exit code so that builds actually fail when there is a problem
exit $LASTEXITCODE