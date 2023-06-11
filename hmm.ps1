Get-Process | ForEach-Object {
    $members = Get-Member -InputObject $_
    foreach ($member in $members) {
        $type = $member.MemberType
        $name = $member.Name
        $value = $_.($name)
        $_ | Add-Member -Name k.$name -MemberType NoteProperty -Value $value -PassThru
    }
    $_
} | Out-GridView
