#$comPorts = [System.IO.Ports.SerialPort]::GetPortNames()

$vendor = "D010"
$product = "1601"

$comPort = (Get-CimInstance -Query "SELECT * from win32_serialport where pnpdeviceid like '%VID_$vendor&PID_$product%'").deviceid

write-host $comPort


$serialPort = New-Object System.IO.Ports.SerialPort
$serialPort.PortName = $comPort

# $serialPort.BaudRate = 115200 
# $serialPort.Parity = "None"  
# $serialPort.DataBits = 8  
# $serialPort.StopBits = "One"


$serialPort.isopen

$serialPort.Open()

$serialPort.isopen
$data = "2"
$serialPort.WriteLine($data)
