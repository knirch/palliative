$userPaths = [Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::User) -split ';' |
    Where-Object { Test-Path $_ -PathType Container } |
    ForEach-Object { $_.TrimEnd('\') } |
    Select-Object -Unique

$machinePaths = [Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine) -split ';' |
    Where-Object { Test-Path $_ -PathType Container } |
    ForEach-Object { $_.TrimEnd('\') } |
    Select-Object -Unique

$userPaths = $userPaths | Where-Object { !($machinePaths -contains $_) }

[Environment]::SetEnvironmentVariable('PATH', $userPaths -join ';', [System.EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable('PATH', $machinePaths -join ';', [System.EnvironmentVariableTarget]::Machine)
