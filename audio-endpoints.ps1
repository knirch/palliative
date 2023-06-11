$parentKeyPath = "HKCU:\SOFTWARE\Microsoft\Multimedia\Audio\DefaultEndpoint"

$childItems = Get-ChildItem -Path $parentKeyPath

$pnpdevices = get-pnpdevice

foreach ($childItem in $childItems) {
	$childItemName = $childItem.PSChildName
	$childItemPath = Join-Path -Path $parentKeyPath -ChildPath $childItemName

	$defaultPropertyValue = (Get-ItemProperty -Path $childItemPath)."(default)"
	$numericProperties = Get-ItemProperty -Path $childItemPath | Get-Member -MemberType NoteProperty |
		Where-Object { $_.Name -match '^\d{3}_\d{3}$' -or $_.Name -match '^\d{3}_\d{3}_p$' } |
		Select-Object -ExpandProperty Name

	$defaultPropertyValue = $defaultPropertyValue -replace "^\\\\\?\\"
	$defaultPropertyValue = $defaultPropertyValue -replace "#", "\"
	$defaultPropertyValue = $defaultPropertyValue -replace "{", "\{" -replace "}", "\}"

	$output = @{
		# 'ChildItem' = $childItemName
		'(default)' = $defaultPropertyValue
	}



	

	foreach ($propertyName in $numericProperties) {
		$propertyValue = (Get-ItemProperty -Path $childItemPath).$propertyName

	$propertyValue = $propertyValue -replace "^\\\\\?\\"
	$propertyValue = $propertyValue -replace "#", "\"
	#$propertyValue = $propertyValue -replace "{", "\{" -replace "}", "\}"

	$inputString = "SWD\MMDEVAPI\{0.0.0.00000000}.{0c815783-4477-4a70-8935-52a86c060791}\{e6327cad-dcec-4949-ae8a-991e976a79d2}"

	$part1 = Split-Path -Path $propertyValue -Parent
	$part2 = Split-Path -Path $propertyValue -Leaf

	$name = ($pnpdevices | Where-Object {$_.DeviceId -eq $part1}).Caption
	


		$output[$propertyName] = $name
	}

	$output
}
























# foreach ($s in get-childitem HKCU:\SOFTWARE\Microsoft\Multimedia\Audio\DefaultEndpoint\) {
# 	$s | get-itemproperty | get-member -membertype noteproperty
# 	# $s | foreach-object {
# 	# 	$_.PsChildName
# 	# }
# 	$s | get-itemproperty -name "(default)" | get-member 
# 	# foreach ($p in Get-ItemProperty -Path $s.pspath) {
# 	# 	$p.PsChildName
# 	# }
# }








  
