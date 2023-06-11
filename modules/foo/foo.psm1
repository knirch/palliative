$scriptblock = {
    param($commandName, $parameterName, $stringMatch)

    Get-ChildItem -Path "C:\Program Files\$stringMatch*" | Select-Object -ExpandProperty Name
}

Register-ArgumentCompleter -CommandName Get-ProgramFilesFolder -ParameterName FolderName -ScriptBlock $scriptBlock








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
