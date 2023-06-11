function FruitArgumentCompleter {
    param (
        $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters
    )
    $possibleValues = @{
        Apple  = @('Gala', 'Honeycrisp', 'GrannySmith')
        Banana = @('Cavendish', 'LadyFinger', 'Manzano')
        Orange = @('Mandarin', 'Navel', 'Blood')
    }

    if ($fakeBoundParameters.ContainsKey('Variety') -and [string]::IsNullOrEmpty($fakeBoundParameters['Fruit'])) {
        $fruitMatchesArray = [System.Collections.ArrayList]::new()
        foreach ($key in $possibleValues.Keys) {
            if ($possibleValues[$key] -contains $fakeBoundParameters['Variety']) {
                $fruitMatchesArray.Add($key) | Out-Null
            }
        }
        $fruitMatchesArray
    }
    else {
        $possibleValues.Keys | Where-Object { $_ -like "$wordToComplete*" }
    }
}

function VarietyArgumentCompleter {
    param (
        $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters
    )
    $possibleValues = @{
        Apple  = @('Gala', 'Honeycrisp', 'GrannySmith')
        Banana = @('Cavendish', 'LadyFinger', 'Manzano')
        Orange = @('Mandarin', 'Navel', 'Blood')
    }

    if ($fakeBoundParameters.ContainsKey('Fruit')) {
        $possibleValues[$fakeBoundParameters.Fruit] | Where-Object {
            $_ -like "$wordToComplete*"
        }
    }
    else {
        $possibleValues.Values | ForEach-Object { $_ }
    }
}

Register-ArgumentCompleter -CommandName 'foo' -ParameterName 'Fruit' -ScriptBlock ${function:FruitArgumentCompleter}
Register-ArgumentCompleter -CommandName 'foo' -ParameterName 'Variety' -ScriptBlock ${function:VarietyArgumentCompleter}

param (
    [Parameter(Mandatory = $true)]
    $Fruit,
    [Parameter(Mandatory = $true)]
    $Variety
)

"You selected the fruit $Fruit and variety of $Variety."















# [CmdLetBinding()]
# param (
#     [Parameter(Mandatory = $true)]
#     [ArgumentCompleter({ FruitArgumentCompleter @args })]
#     $Fruit,
#     [Parameter(Mandatory = $true)]
#     [ArgumentCompleter({ VarietyArgumentCompleter @args })]
#     $Variety
# )

# "You selected the fruit $Fruit and variety of $Variety."
# function FruitArgumentCompleter {
#     param ( $commandName,
#         $parameterName,
#         $wordToComplete,
#         $commandAst,
#         $fakeBoundParameters )
#     $possibleValues = @{
#         Apple  = @('Gala', 'Honeycrisp', 'GrannySmith')
#         Banana = @('Cavendish', 'LadyFinger', 'Manzano')
#         Orange = @('Mandarin', 'Navel', 'Blood')
#     }
#     if ($fakeBoundParameters.ContainsKey('Variety') -and [string]::IsNullOrEmpty($fakeBoundParameters['Fruit'])) {
#         $fruitMatchesArray = [System.Collections.ArrayList]::new()
#         foreach ($key in $possibleValues.Keys) {
#             if ($possibleValues[$key] -contains $fakeBoundParameters['Variety']) {
#                 $fruitMatchesArray.Add($key) | Out-Null
#             }
#         }
#         $fruitMatchesArray
#     }
#     else {
#         $possibleValues.Keys | ForEach-Object { $_ } | Where-Object { $_ -like "$wordToComplete*" }
#     }
# }

# function VarietyArgumentCompleter {
#     param ( $commandName,
#         $parameterName,
#         $wordToComplete,
#         $commandAst,
#         $fakeBoundParameters )
#     Out-Host 'foobar'
#     $possibleValues = @{
#         Apple  = @('Gala', 'Honeycrisp', 'GrannySmith')
#         Banana = @('Cavendish', 'LadyFinger', 'Manzano')
#         Orange = @('Mandarin', 'Navel', 'Blood')
#     }
#     if ($fakeBoundParameters.ContainsKey('Fruit')) {
#         $possibleValues[$fakeBoundParameters.Fruit] | Where-Object {
#             $_ -like "$wordToComplete*"
#         }
#     }
#     else {
#         $possibleValues.Values | ForEach-Object { $_ }
#     }
# }




# param ( [Parameter(Mandatory = $true)] [ValidateSet( 'adoptstate', 'bandwidthctl', 'checkmediumpwd', 'clonemedium', 'clonevm', 'closemedium', 'cloud', 'cloudprofile', 'controlvm', 'convertfromraw', 'createmedium', 'createvm', 'debugvm', 'dhcpserver', 'discardstate', 'encryptmedium', 'encryptvm', 'export', 'extpack', 'getextradata', 'guestcontrol', 'guestproperty', 'hostonlyif', 'hostonlynet', 'import', 'list', 'mediumio', 'mediumproperty', 'metrics', 'modifymedium', 'modifynvram', 'modifyvm', 'movevm', 'natnetwork', 'registervm', 'setextradata', 'setproperty', 'sharedfolder', 'showmediuminfo', 'showvminfo', 'signova', 'snapshot', 'startvm', 'storageattach', 'storagectl', 'unattended', 'unregistervm', 'updatecheck', 'usbdevsource', 'usbfilter')] [string] $Command, [Parameter(Mandatory = $true)] [ValidateSet('Small', 'Medium', 'Large')] [string] $Size) "Creating a $Size widget of color $Color."
# & 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe' @args


# # Vgc
# [ValidateSet(
#     'bridgedifs',
#     'cloudnets',
#     'cloudprofiles',
#     'cloudproviders',
#     'cpu-profiles',
#     'dhcpservers',
#     'dvds',
#     'extpacks',
#     'floppies',
#     'groups
#     'hddbackends',
#     'hdds',
#     'hostcpuids',
#     'hostdrives',
#     'hostdvds',
#     'hostfloppies',
#     'hostinfo',
#     'hostonlyifs',
#     'hostonlynets',
#     'intnets',
#     'natnets',
#     'ostypes',
#     'runningvms',
#     'screenshotformats',
#     'systemproperties',
#     'usbfilters',
#     'usbhost',
#     'vms',
#     'webcams'
# )]

# Register-ArgumentCompleter -CommandName vbox -ParameterName Fruit -ScriptBlock ${function:FruitArgumentCompleter}
# Register-ArgumentCompleter -CommandName vbox -ParameterName Variety -ScriptBlock ${function:VarietyArgumentCompleter}
