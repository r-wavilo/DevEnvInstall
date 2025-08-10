Add-Type -AssemblyName System.IO.Compression

$ErrorActionPreference = "Stop"

function ExtractZip {
	param (
		[string]$zipFilePath,
		[string]$destination,
		[switch]$removeZipContentsRootDir
	)
	
	$zipFile = Get-Item $zipFilePath
	
	# Open a read-only file stream
	$zipFileStream = $zipFile.OpenRead()

	# Instantiate ZipArchive
	$zipArchive = [System.IO.Compression.ZipArchive]::new($zipFileStream)

	# Iterate over all entries and pick the ones you like
	foreach($entry in $zipArchive.Entries){
		if (![string]::IsNullOrEmpty($entry.Name)) {   # skip directories
			try {
				
				# Get zip archive entry path and possibly alter it
				$processedEntryFullName = $entry.FullName
				if ($removeZipContentsRootDir) {
					$pos = $processedEntryFullName.IndexOf('/')
					$processedEntryFullName = $processedEntryFullName.Remove(0, $pos+1)
				}
				
				$fullDest = [System.IO.Path]::Combine($destination, $processedEntryFullName)
				#Write-Host "Attempting to create '$fullDest'"
				
				# Create directory
				$fullDestDir = [System.IO.Path]::GetDirectoryName($fullDest)
				[System.IO.Directory]::CreateDirectory($fullDestDir) | Out-Null

				# Create new file on disk, open writable stream
				$targetFileStream = $(
					New-Item -Path $fullDest -ItemType File -Force
				).OpenWrite()

				# Open stream to compressed file, copy to new file stream
				$entryStream = $entry.Open()
				$entryStream.CopyTo($targetFileStream)
			}
			finally {
				# Clean up
				$targetFileStream,$entryStream |ForEach-Object Dispose
			}
		}
	}
	
	# Clean up
	$zipArchive,$zipFileStream |ForEach-Object Dispose
}

function DownloadAndInstallProgram {
	param (
		[string]$sourceUrl,
		[string]$dstInstallDirName,
		[switch]$removeZipContentsRootDir
	)

	$targetFileName = [System.IO.Path]::GetFileName($sourceUrl)
	Write-Host "targetFileName: $targetFileName"

	$downloadsPath = (New-Object -ComObject Shell.Application).Namespace('shell:Downloads').Self.Path

	$dstFilePath = [System.IO.Path]::Combine($downloadsPath, $targetFileName)
	Write-Host "dstFilePath: $dstFilePath"

	# Download file if it does not exist locally
	if (![System.IO.File]::Exists($dstFilePath))
	{
		# Download file
		Invoke-WebRequest -Uri $sourceUrl -OutFile $dstFilePath
	}

	$dstInstallDir = [System.IO.Path]::Combine($HOME, $dstInstallDirName)
	Write-Host "dstInstallDir: $dstInstallDir"

	# Create install directory if it does not exist
	if (![System.IO.Directory]::Exists($dstInstallDir))
	{
		[System.IO.Directory]::CreateDirectory($dstInstallDir)
	}

	# Unzip contents into install directory
	# $extractedPaths = Expand-Archive  -Force -PassThru -Path $dstFilePath -DestinationPath $dstInstallDir
	ExtractZip -zipFilePath $dstFilePath -destination $dstInstallDir -removeZipContentsRootDir
	#Write-Host "Extracted $extractedPaths"

	$currentUserPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::User)
	if ($currentUserPath -notlike "*;$dstInstallDir*") {
			# If the new path is not found, append it
			$updatedPath = "$currentUserPath;$dstInstallDir"
			[System.Environment]::SetEnvironmentVariable("Path", $updatedPath, [System.EnvironmentVariableTarget]::User)
			Write-Host "Path '$dstInstallDir' added to user's PATH environment variable."
		} else {
			Write-Host "Path '$dstInstallDir' already exists in user's PATH environment variable."
	}

	Write-Host "Program installed to $dstInstallDir"
}