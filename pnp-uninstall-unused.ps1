# $PSVersionTable.PSVersion

# $devices = $devices | ForEach-Object { Write-Output $_ }
# $devices = $devices | ForEach-Object { Write-Output $_.Class }
# $devices = $devices | ForEach-Object { Write-Output $_.InstanceId }
# $devices = $devices | Format-List
# $devices = $devices | Format-Table
# $devices = $devices | Select-Object DeviceName
# $devices = $devices | Select-Object Name, Class, InstanceId
# $devices = $devices | Sort-Object -Descending Class
# $devices = $devices | Sort-Object Class
# $devices = $devices | Where-Object { ! $_.present -and $_.Class -eq 'AudioEndpoint' }
# $devices = $devices | Where-Object { ! $_.present }
# $devices = $devices | Where-Object { $_.Class -and $_.Class -ne 'Bluetooth' }
# $devices = $devices | Where-Object { $_.Class -eq 'AudioEndpoint' }
# $devices = $devices | Where-Object { $_.Class -ne 'Bluetooth' -and $_.Class }
# $devices = $devices | Where-Object { $_.Class -ne 'Bluetooth' }
# $devices = $devices | Where-Object { $_.InstanceId -eq 'BTH\MS_BTHBRB\8&155AC7C&3&1' }
# $devices = Get-PnpDevice -Class 'Hidden'
# $devices | Write-Output

$devices = Get-PnpDevice | Where-Object { ! $_.present }
# $devices = $devices | Where-Object { $_.Class -eq 'SoftwareDevice' }

$devices | ForEach-Object {
    $inf = (Get-PnpDeviceProperty -InstanceId $_.InstanceId -KeyName DEVPKEY_Device_DriverInfPath).Data
    pnputil /remove-device $_.InstanceId
    if ($inf -like 'oem*') {
        pnputil /delete-driver $inf /uninstall
    }
}

# pnputil /remove-device $_.InstanceId -Confirm
# if ($inf) {
#     pnputil /delete-driver $inf /uninstall
# }

# pnputil /remove-device "SWD\MMDEVAPI\{0.0.1.00000000}.{1273E398-125F-43C7-9B0F-69B19B53F9A2}"
# pnputil /remove-device "SWD\MMDEVAPI\{0.0.1.00000000}.{1273E398-125F-43C7-9B0F-69B19B53F9A2}" /delete-driver /uninstall
# pnputil /remove-device "SWD\MMDEVAPI\{0.0.1.00000000}.{CF4001DE-8ED0-4C45-869F-A3867A9E33DA}" /delete-driver /uninstall


# oooh, cool, found it here: https://woshub.com/how-to-remove-unused-drivers-from-driver-store/#h2_1
# Get-CimInstance Win32_PnPSignedDriver | select DeviceName, DeviceClass, Manufacturer, DriverVersion, DriverDate, InfName | Out-GridView
