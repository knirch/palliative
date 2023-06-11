param(
    $newPath
)

if (!(Test-Path $newPath -PathType Container)) {
    Write-Output ('ABORT: {0} does not exist' -f $newPath); exit 1 
}

$userPaths = New-Object System.Collections.Generic.HashSet[string]

foreach ($item in [Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::User).split(';')) {
    if (Test-Path $item -PathType Container) {
        $userPaths.Add($item.TrimEnd('\')) | Out-Null
    } 
}      

[void]$userPaths.Add($newPath.TrimEnd('\')) 

# Remove machinePaths that exists in userPaths
$userPaths = $userPaths | Select-Object -Unique | Where-Object { !($machinePaths -contains $_) }

[Environment]::SetEnvironmentVariable('PATH', $userPaths -join ';', [System.EnvironmentVariableTarget]::User)

foreach ($item in $userPaths) {
    Write-Output $item 
}
