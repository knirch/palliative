@echo off

:: Based on a comment on;
:: https://superuser.com/questions/1287366/open-webcam-settings-dialog-in-windows

:: ffmpeg -list_devices true -f dshow -i dummy -hide_banner

:: "Microsoft® LifeCam Cinema(TM)" (video)
set cam="@device_pnp_\\?\usb#vid_045e&pid_075d&mi_00#8&e059ae4&0&0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\global"
set cam="@device_pnp_\\?\usb#vid_045e&pid_075d&mi_00#8&e059ae4&1&0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\global"

:: Kiyo Pro
set cam="@device_pnp_\\?\usb#vid_1532&pid_0e05&mi_00#7&2695a81&0&0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\global"

:: "DroidCam Source 3" (video)
:: set cam="@device_pnp_\\?\root#media#0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\global"

:: "Snap Camera" (video)
:: set cam="@device_pnp_\\?\root#camera#0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\global"

:: "DroidCam Source 2" (video)
:: set cam="@device_sw_{860BB310-5D01-11D0-BD3B-00A0C911CE86}\{9E2FBAC0-C951-4AA8-BFA9-4B196644964C}"

:: "OBS Virtual Camera" (video)
:: set cam="@device_sw_{860BB310-5D01-11D0-BD3B-00A0C911CE86}\{A3FCE0F5-3493-419F-958A-ABA1250EC20B}"

:: "WOPP" (video)
:: set cam="@device_sw_{860BB310-5D01-11D0-BD3B-00A0C911CE86}\{D550C587-BB18-172F-9E8B-4291AD2A40FD}"

:: ??? Kanske min kontors-kina-cam
:: set cam="@device_pnp_\\?\usb#vid_0458&pid_6006&mi_00#7&1a3e2012&0&0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\global"

ffmpeg -f dshow -show_video_device_dialog true -i video=%cam% 
pause
