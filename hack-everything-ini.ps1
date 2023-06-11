# Hack to add the config I want to Everything.

$everythingPath = `
    if ($everything = Get-Process -Name Everything | Where-Object {
        $_.SI -eq (Get-Process -PID $PID).SessionId
    }) {
    $everything = $everything | Stop-Process -PassThru
    $everything.Path
}
else {
    'C:\Program Files\Everything\Everything.exe'
}

$tempFile = New-TemporaryFile
@'
[Everything]
new_window_key=0
show_window_key=0
toggle_window_key=2239 ; Win-/
file_new_search_window_keys=334 ; Ctrl-n
'@ | Out-File -FilePath $tempFile.FullName -Encoding ascii

# Install the configuration and start Everything.
& $everythingPath -install-config $tempFile.FullName
& $everythingPath

# Clean up the temporary file.
Remove-Item -Path $tempFile.FullName -Force


exit 0

###


# Add unconfigurable value to Everything.ini and restart it to update the configuration file

#                                          | Only select processes that matches the users sessionid
$everything = Get-Process -Name Everything | Where-Object { $_.SI -eq (Get-Process -PID $PID).SessionId }

if (!($everything)) {
    Write-Output 'Everything not running, assuming executable path'
    $everythingPath = 'C:\Program Files\Everything\Everything.exe'
}
else {
    # silly way of getting the first item...
    foreach ($proc in $everything) {
        $everythingPath = $everything.Path
        break
    }
    # Stop the process, I have not found a good way of changing the configuration
    # while it's running.
    $everything | Stop-Process
}

# Create the configuration that will be merged;
$file = New-TemporaryFile
Add-Content -Path $file.FullName -Value '[Everything]'
Add-Content -Path $file.FullName -Value 'new_window_key=0'
Add-Content -Path $file.FullName -Value 'show_window_key=0'
Add-Content -Path $file.FullName -Value 'toggle_window_key=2239' # Win-/
Add-Content -Path $file.FullName -Value 'file_new_search_window_keys=334' # Ctrl-n

Start-Process -FilePath $everythingPath -ArgumentList '-install-config', $file.FullName
Start-Process -FilePath $everythingPath

Remove-Item -Path $file.FullName -Force

## need a test if I even found the process!
#Write-Output $everything.CommandLine
# this is not needed. I was just dumb..
#$everythingProc = (Get-CimInstance win32_process -Filter "ProcessId='$($everything.Id)'")
## where it ran from;k
#.ExecutablePath
## how it ran
#.CommandLine
# knirc> Add-Content -Path .\Everything.ini -value "alpha=242"
# PS C:\Windows\System32> Get-Process -Name Everything -IncludeUserName

#      WS(M)   CPU(s)      Id UserName                       ProcessName
#      -----   ------      -- --------                       -----------
#       3.02    59.19    5464 NT AUTHORITY\SYSTEM            Everything
#     119.03     3.75   59844 WASTEOFTIME\knirc              Everything

# PS C:\Users\knirc> Get-Process -Name Everything

#  NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
#  ------    -----      -----     ------      --  -- -----------
#      11     2.62       3.02       0.00    5464   0 Everything
#      32   108.47     119.27       5.48   59844   1 Everything

# PS C:\Users\knirc> Get-Process -Name Everything | ? {$_.SI -eq (Get-Process -PID $PID).SessionId}

#  NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
#  ------    -----      -----     ------      --  -- -----------
#      32   108.44     119.28       5.81   59844   1 Everything

# PS C:\Users\knirc> Get-Process -Name Everything | ? {$_.SI -eq (Get-Process -PID $PID).SessionId} | Stop-Process
# PS C:\Users\knirc>


# PS C:\Users\knirc\AppData\Roaming\Everything> Get-Process -Name Everything | ? {$_.SI -eq (Get-Process -PID $PID).SessionId} | Stop-Process
# PS C:\Users\knirc\AppData\Roaming\Everything> Get-Content .\Everything.ini | Select-String '^alpha='

# alpha=100
# alpha=242

# PS C:\Users\knirc\AppData\Roaming\Everything> ."C:\Program Files\Everything\Everything.exe"
# PS C:\Users\knirc\AppData\Roaming\Everything> # Here I use File > Exit
# PS C:\Users\knirc\AppData\Roaming\Everything> Get-Content .\Everything.ini | Select-String '^alpha='

# alpha=242

# PS C:\Users\knirc\AppData\Roaming\Everything>







# -?	Show this help.
# -admin	Run "Everything" as Administrator.
# -admin-server-share-links	Use \\Server\C$ links for ETP connections.
# -app-data	Store data in application data.
# -bookmark <name>	Open a bookmark.
# -case	Enable case matching.
# -choose-language	Show the language selection page.
# -choose-volumes	Do not automatically index volumes.
# -close	Close the current search window.
# -config <filename>	The filename of the ini file.
# -connect <user:pass@host:port>	Connect to an ETP server.
# -console	Show the debugging console.
# -copyto <filename1> <...>	Show the multi-file renamer with the specified filenames.
# -create-file-list <filename> <path>	Create a file list of a path.
# -create-file-list-exclude-files <list>	exclude the semicolon delimited wildcard filter for files.
# -create-file-list-exclude-folders <list>	exclude the semicolon delimited wildcard filter for folders.
# -create-file-list-include-only-files <list>	include only the semicolon delimited wildcard filter for files.
# -create-usn-journal <volume> <max-size-bytes> <allocation-delta-bytes>
# -db <filename>	The filename of the database.
# -debug	Show the debugging console.
# -debug-log	Log debugging information to disk
# -delete-usn-journal <volume>	Delete a USN Journal.
# -details	Show results in detail view.
# -diacritics	Enable diacritics matching.
# -disable-run-as-admin	Disable run as administrator.
# -disable-update-notification	Disable update notification on startup.
# -drive-links	Use C: links for ETP connections.
# -edit <filename>	Open a file list with the file list editor.
# -enable-run-as-admin	Enable run as administrator.
# -enable-update-notification	Enable update notification on startup.
# -exit	Exit "Everything".
# -first-instance	Only run if this is the first instance of "Everything".
# -filelist <filename>	Open a file list.
# -filename <filename>	Search for a file or folder by filename.
# -filter <name>	Select a search filter.
# -focus-bottom-result	Focus the bottom result.
# -focus-last-run-result	Focus the last run result.
# -focus-most-run-result	Focus the most run result.
# -focus-results	Focus the result list.
# -focus-top-result	Focus the top result.
# -ftp-links	Use ftp://host/C: links for ETP connections.
# -fullscreen	Show the search window fullscreen.
# -h	Show this help.
# -help	Show this help.
# -home	Open the home search.
# -install <location>	Install "Everything" to a new location.
# -install-client-service	Install the "Everything" client as a service.
# -install-config <filename>	Install the specified ini file.
# -install-desktop-shortcut	Install desktop shortcut.
# -install-efu-association	Install EFU file association.
# -install-folder-context-menu	Install folder context menus.
# -install-quick-launch-shortcut	Install Quick Launch shortcut.
# -install-run-on-system-startup	Install "Everything" from the system startup.
# -install-service	Install and start the "Everything" service.
# -install-service-pipe-name <name>	Use the specified name for the "Everything" service pipe name.
# -install-service-security-descriptor	Specify the pipe security descriptor.
# -install-start-menu-shortcuts	Install "Everything" shortcuts from the Start menu.
# -install-url-protocol	Install URL Protocol.
# -instance <name>	The name of the "Everything" instance.
# -l	Load the local database.
# -language <langID>	Set the language to the specified language ID.
# -load-delay <milliseconds>	The delay in milliseconds before loading the database.
# -local	Load the local database.
# -matchpath	Enable full path matching.
# -maximized	Maximize the search window.
# -minimized	Minimize the search window.
# -moveto <filename1> <...>	Show the multi-file renamer with the specified filenames.
# -name-part <filename>	Search for the name part of a filename.
# -newwindow	Create a new search window.
# -noapp-data	Store data in executable location.
# -nocase	Disable case matching.
# -nodb	Do not save to or load from the "Everything" database file.
# -nodiacritics	Disable diacritics matching.
# -nofullscreen	Show the search window in a window.
# -nomatchpath	Disable full path matching.
# -nomaximized	Unmaximize the search window.
# -nominimized	Unminimize the search window.
# -nonewwindow	Show an existing search window.
# -noontop	Disable always ontop.
# -noregex	Disable Regex.
# -noverbose	Display only basic debug messages.
# -nowholeword	Disable match whole word.
# -noww	Disable match whole word.
# -ontop	Enable always ontop.
# -p <path>	Search for a path.
# -parent <path>	Search for files and folders in the specified folder.
# -parentpath <path>	Search for the parent of a path.
# -path <path>	Search for a path.
# -quit	Exit "Everything".
# -read-only	Loads the database in read-only mode.
# -regex	Enable Regex.
# -reindex	Force database rebuild.
# -rename <filename1> <...>	Show the multi-file renamer with the specified filenames.
# -rescan-all	Rescan all folder indexes.
# -s <text>	Set the search.
# -search <text>	Set the search.
# -search-file-list <filename>	Search the specified text file for a list of file names.
# -select <filename>	Focus and select the specified result.
# -server-share-links	Use \\Server\C: links for ETP connections.
# -service-pipe-name <name>	connect to the service pipe with the specified name.
# -sort <name>	Set the sort to the specified name.
# -sort-ascending	Sort ascending.
# -sort-descending	Sort descending.
# -start-client-service	Start the "Everything" client service.
# -start-service	Start the "Everything" service.
# -startup	Run "Everything" in the background.
# -stop-client-service	Stop the "Everything" client service.
# -stop-service	Stop the "Everything" service.
# -svc	Run "Everything" as a service.
# -svc-pipe-name <name>	Host the pipe server with the specified name.
# -svc-security-descriptor <sd>	Host the pipe server with the security descriptor.
# -thumbnail-size <size>	Specify the size of thumbnails in pixels.
# -thumbnails	Show results in thumbnail view.
# -toggle-window	Hides the current foreground search window or shows the search window.
# -uninstall [path]	Uninstall "Everything" from the specified path.
# -uninstall-client-service	Uninstall the "Everything" client service.
# -uninstall-desktop-shortcut	Uninstall desktop shortcut.
# -uninstall-efu-association	Uninstall EFU file association.
# -uninstall-folder-context-menu	Uninstall folder context menus.
# -uninstall-quick-launch-shortcut	Uninstall Quick Launch shortcut.
# -uninstall-run-on-system-startup	Remove "Everything" from the system startup.
# -uninstall-service	Uninstall the "Everything" service.
# -uninstall-start-menu-shortcuts	Uninstall "Everything" shortcuts from the Start menu.
# -uninstall-url-protocol	Uninstall URL Protocol.
# -uninstall-user	Uninstall user files.
# -update	Save the database to disk.
# -url <[es:]search>	Set the search from an ES: URL.
# -verbose	Display all debug messages.
# -wholeword	Enable match whole word.
# -ww	Enable match whole word.
