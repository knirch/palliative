# Create an instance of the Core Audio API
$audioSessionManager = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{BCDE0395-E52F-467C-8E3D-C4579291692E}"))

# Get the audio session enumerator
$audioSessionEnumerator = $audioSessionManager.GetSessionEnumerator()

# Iterate through each audio session
foreach ($audioSession in $audioSessionEnumerator) {
	# Get the process ID of the audio session
	$processID = $audioSession.GetProcessId()

	# Get the audio session control
	$audioSessionControl = $audioSession.QueryInterface([Type]::GetTypeFromCLSID([Guid]"{BFA971F1-4D5E-40BB-935E-967039BFBEE4}"))

	# Get the session volume and mute status
	$sessionVolume = $audioSessionControl.QueryInterface([Type]::GetTypeFromCLSID([Guid]"{C158AEDA-2EFD-4EAF-EDB9-2DEA9A66E8AD}"))
	$volume = $sessionVolume.GetMasterVolume()
	$mute = $sessionVolume.GetMute()

	# Get the session display name
	$displayName = $audioSessionControl.GetDisplayName()

	# Output the information
	Write-Output "Process ID: $processID"
	Write-Output "Display Name: $displayName"
	Write-Output "Volume: $volume"
	Write-Output "Mute: $mute"
	Write-Output "-----------------------"
}
