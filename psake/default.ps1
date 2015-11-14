properties {
	$testMessage = 'Executed Test!'
	$compileMessage = 'Executed Compile!'
	$cleanMessage = 'Executed Clean!'

	$solutionDirectory = (Get-Item $solutionFile).DirectoryName
	$outputDirectory = "$solutionDirectory\.build"
	$temporaryOutputDirectory = "$outputDirectory\temp"
}

task default -depends Test

task Init -description "Initializes the build by removing previous `
artifacts and creating output directories"`
-requiredVariables outputDirectory, temporaryOutputDirectory {
	#Remove previous build results
	if (Test-Path $outputDirectory)  {
		Write-Host "Removing output directory located at $outputDirectory"
		Remove-Item $outputDirectory -Force -Recurse
	}
	
	Write-Host "Creating output directory located at ..\build"
	New-Item $outputDirectory -ItemType Directory | Out-Null

	Write-Host "Creating temporary directory located at $temporaryOutputDirectory"
	New-Item $temporaryOutputDirectory -ItemType Directory | Out-Null

}

task Clean -description "Remove temporary files" {
	Write-Host $cleanMessage
}

task Compile -depends Init -description "Compile the code" {
	Write-Host $compileMessage
}

task Test -depends Compile, Clean -description "Run the unit tests" {
	Write-Host $testMessage
}