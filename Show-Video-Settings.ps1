# :: Based on a comment on;
# :: https://superuser.com/questions/1287366/open-webcam-settings-dialog-in-windows

# First solution
# function listCameras {
#     begin {
#         $output = ffmpeg.exe -list_devices true -f dshow -i dummy -hide_banner 2>&1 | Where-Object { $_ -match '^\[' }
#         $output | Group-Object -Property { [Math]::Floor($output.IndexOf($_) / 2) } | ForEach-Object {
#             $regex = '"([^"]+)"'
#             $name = [regex]::Match($_.Group[0], $regex)
#             $device_name = [regex]::Match($_.Group[1], $regex)
#             if (!($name.Success -or $device_name.Success)) { throw "unexpected ffmpeg output" }
#             [PSCustomObject] @{
#                 name   = $name.Groups[1].Value
#                 device = $device_name.Groups[1].Value
#             }
#         }
#     }
# }
# listCameras | Where-Object { $_.name -eq "USB Video Device" } | ForEach-Object {
#     $dev = $_.device
#     ffmpeg -f dshow -show_video_device_dialog true -i video="$dev"
# }

param(
    $myArg
)

function Register-MyCommandTabCompletion {
    [CmdletBinding()]
    param()

    $scriptBlock = {
        # Define your tab completion logic here
    }

    Register-ArgumentCompleter -CommandName $MyInvocation.Name -ParameterName '*' -ScriptBlock $scriptBlock
}

Register-MyCommandTabCompletion

function showVideoConfig {
    param($cameraName)
    $Output = ffmpeg.exe -list_devices true -f dshow -i dummy -hide_banner 2>&1 | Where-Object { $_ -match '^\[' }
    foreach ($Camera in $Output | Group-Object -Property { [Math]::Floor($Output.IndexOf($_) / 2) }) {
        $Name = [regex]::Match($Camera.Group[0], '"([^"]+)"')
        $DeviceName = [regex]::Match($Camera.Group[1], '"([^"]+)"')
        if (!($Name.Success -or $DeviceName.Success)) {
            throw 'unexpected ffmpeg output' 
        }
        if ($Name.Groups[1].Value -eq $cameraName) {
            $device = $DeviceName.Groups[1].Value
            ffmpeg -f dshow -show_video_device_dialog true -i video="$device"
            return 0
        }
    }
    Write-Output "No camera matching $cameraName was found"
    return 1
}

Write-Host foo { foo
}

showVideoConfig $myArg
