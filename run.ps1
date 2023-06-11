param(
    $newPath
)

if (!(Test-Path $item -PathType Container)) {
    Write-Output "ABORT: $newPath does not exists"
    exit 1
}

$userPaths = New-Object System.Collections.Generic.HashSet[string]

foreach ($item in [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User).split(";")) {
    if (Test-Path $item -PathType Container) {
        $userPaths.Add($item.TrimEnd("\")) | Out-Null
    }
}

[void]$userPaths.Add($newPath.TrimEnd("\"))

foreach ($item in [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine).split(";")) {
    ($userPaths.Remove($item.TrimEnd("\")) ) >$null
}

[Environment]::SetEnvironmentVariable("PATH", $userPaths -join ";", [System.EnvironmentVariableTarget]::User)

exit 0

## Lessons learned;
#
# [void]cmd
# cmd | Out-Null
# (cmd) >$null

$userPaths = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User) `
    -split ";" `
| Where-Object { Test-Path $_ -PathType Container } `
| ForEach-Object { $_.TrimEnd("\") } `
| Select-Object -Unique

$userPaths.Add("C:\Program Files\gVim")

$machinePaths = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine) `
    -split ";" `
| ForEach-Object { $_.TrimEnd("\") } `
| Select-Object -Unique

$userPaths = $userPaths | Where-Object { $machinePaths -notcontains $_ }

[Environment]::SetEnvironmentVariable("PATH", $userPaths -join ";", [System.EnvironmentVariableTarget]::User)
