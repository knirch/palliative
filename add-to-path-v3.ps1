param(
    $newPath
)

if (!(Test-Path $newPath -PathType Container)) {
    Write-Output ('ABORT: {0} does not exist' -f $newPath); exit 1 
}

$userPaths = [Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::User) `
    -split ';' |
    Where-Object { Test-Path $_ -PathType Container } |
    ForEach-Object { $_.TrimEnd('\') }

$userPaths += $newPath.TrimEnd('\')

$machinePaths = [Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::Machine) `
    -split ';' |
    ForEach-Object { $_.TrimEnd('\') } |
    Select-Object -Unique

# Remove machinePaths that exists in userPaths
$userPaths = $userPaths | Select-Object -Unique | Where-Object { !($machinePaths -contains $_) }

[Environment]::SetEnvironmentVariable('PATH', $userPaths -join ';', [System.EnvironmentVariableTarget]::User)

foreach ($item in $userPaths) {
    Write-Output $item 
}
