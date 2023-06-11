<#
.SYNOPSIS
Set the default audio devices to my preferred device

.DESCRIPTION
Windows has a tendency to select newly added devices as the communications
device. This short script sets the selected and default devices back to my
desired device.

.AUTHOR
Thomas Nilsson

.VERSION
0.1
#>

# Getting the list is very slow, read it once to improve performance
$audioDevices = Get-AudioDevice -List
$recording = $audioDevices | Where-Object { $_.Name -like '*AG06/AG03*' -and $_.type -eq 'Recording' }
$playback = $audioDevices | Where-Object { $_.Name -like '*AG06/AG03*' -and $_.type -eq 'Playback' }

# "splatting"
$playbackCommunication = @{
	ID                = $playback.ID
	CommunicationOnly = $true
}

$playbackDefault = @{
	ID          = $playback.ID
	DefaultOnly = $true
}

$recordingCommunication = @{
	ID                = $recording.ID
	CommunicationOnly = $true
}

$recordingDefault = @{
	ID          = $recording.ID
	DefaultOnly = $true
}

foreach ($device in $audioDevices) {
	if ($device.Type -eq 'Playback') {
		if ($device.ID -ne $playback.ID) {
			if ($device.DefaultCommunication) {
				Set-AudioDevice @playbackCommunication
			}
			elseif ($device.Default) {
				Set-AudioDevice @playbackDefault
			}
		}
	}
	elseif ($device.Type -eq 'Recording') {
		if ($device.ID -ne $recording.ID) {
			if ($device.DefaultCommunication) {
				Set-AudioDevice @recordingCommunication
			}
			elseif ($device.Default) {
				Set-AudioDevice @recordingDefault
			}
		}
	}
}
