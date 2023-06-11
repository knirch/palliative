function Get-LevelString($level) {
    return [string]::Empty.PadLeft($level * 1, ' ')
}

function Format-List-Recursive ($indent, $object) {
    foreach ($prop in $object.psobject.properties) {
        $name = $prop.name
        $value = $prop.value

        Write-Output "$(Get-LevelString($indent)) <$name< $indent >>"
        if ([string]::IsNullOrEmpty($value)) {
            continue
        }
        if (!($value.GetType().IsVisible)) {
            continue
            Write-Host foo
        }
        #if (-not $value.GetType().IsSerializable) { continue }

        if ($name -eq 'ScriptContents' -or $name -eq 'ScriptBlock') {
            Write-Output "$(Get-LevelString($indent)) $name <... nope :) ...>"
            continue
        }

        if (-not [string]::IsNullOrEmpty($value)) {
            if ($value -is [array]) {
                Write-Output "$(Get-LevelString($indent)) ${name}:"
                $value | Format-List-Recursive $indent + 1
            }
            elseif ($value.GetType().IsSerializable) {
                Write-Output "$(Get-LevelString($indent)) ${name}: $value"
            }
            elseif ($value -is [object]) {
                Write-Output "$(Get-LevelString($indent)) ${name}:>"
                Format-List-Recursive ($indent + 1) $value
            }
            else {
                Write-Output "$(Get-LevelString($indent)) ${name}: $value"
            }
        }
    }
}

Format-List-Recursive 0 $MyInvocation
exit 0
