#include-once
#include <GUIConstantsEx.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>

;~ Tạo nên Window
$GUI_width = 350
$GUI_height = 150
$GUI_x = @DesktopWidth/4
$GUI_y = @DesktopHeight/4
$GUI = GUICreate("Viad - Viber - Ver 24/05/2014",$GUI_width,$GUI_height,$GUI_x,$GUI_y)

; Tạo label
$L_Name_width = $GUI_width-160
$L_Name_height = 20
$L_Name_x = 190
$L_Name_y = 5
$L_Name = GUICtrlCreateLabel("",$L_Name_x,$L_Name_y,$L_Name_width,$L_Name_height)

; Tạo label
$L_TotalSMS_width = $GUI_width-50
$L_TotalSMS_height = 20
$L_TotalSMS_x = 190
$L_TotalSMS_y = $L_TotalSMS_height + 2
$L_TotalSMS = GUICtrlCreateLabel("",$L_TotalSMS_x,$L_TotalSMS_y,$L_TotalSMS_width,$L_TotalSMS_height)

;~ Tạo Danh Sách Học Sinh
;~ $V_Phone_width = $GUI_width- 200
;~ $V_Phone_height = $GUI_height - 60
;~ $V_Phone_x = 190
;~ $V_Phone_y = $L_Name_y + 30
;~ $V_Phone = GUICtrlCreateListView("Id|Phone|Status",$V_Phone_x,$V_Phone_y,$V_Phone_width,$V_Phone_height)

$L_Project_width = 47
$L_Project_height = 20
$L_Project_x = 7
$L_Project_y = 7
$L_Project = GUICtrlCreateLabel("Dự án:",$L_Project_x,$L_Project_y,$L_Project_width,$L_Project_height)

$I_Project_width = 40
$I_Project_height = $L_Project_height
$I_Project_x = $L_Project_width
$I_Project_y = $L_Project_y - 2
$I_Project = GUICtrlCreateInput(0,$I_Project_x,$I_Project_y,$I_Project_width,$I_Project_height,$ES_NUMBER)

$L_AppID_width = 40
$L_AppID_height = 20
$L_AppID_x = $I_Project_width + $I_Project_x + 5
$L_AppID_y = $L_Project_y
$L_AppID = GUICtrlCreateLabel("App ID:",$L_AppID_x,$L_AppID_y,$L_AppID_width,$L_AppID_height)

$I_AppID_width = 40
$I_AppID_height = $L_AppID_height
$I_AppID_x = $L_AppID_width + $L_AppID_x + 5
$I_AppID_y = $L_Project_y - 2
$I_AppID = GUICtrlCreateInput(0,$I_AppID_x,$I_AppID_y,$I_AppID_width,$I_AppID_height,$ES_NUMBER)

$L_Delay_width  = 35
$L_Delay_height = 20
$L_Delay_x 		= $L_Project_x
$L_Delay_y 		= $L_AppID_y  + $L_AppID_height + 5
$L_Delay 		= GUICtrlCreateLabel("Delay:",$L_Delay_x,$L_Delay_y,$L_Delay_width,$L_Delay_height)

$I_Delay_width = 40
$I_Delay_height = $L_Delay_height
$I_Delay_x = $L_Delay_x + $L_Delay_width + 5
$I_Delay_y = $L_Delay_y - 2
$I_Delay = GUICtrlCreateInput(5,$I_Delay_x,$I_Delay_y,$I_Delay_width,$I_Delay_height,$ES_NUMBER)

$B_LoadProject_width  = 80
$B_LoadProject_height = $L_AppID_height
$B_LoadProject_x 	  = $L_Project_x
$B_LoadProject_y 	  = $L_Delay_height + $I_Delay_width
$B_LoadProject 		  = GUICtrlCreateButton("1. Load Dự án",$B_LoadProject_x,$B_LoadProject_y,$B_LoadProject_width,$B_LoadProject_height)

$B_StartSpam_width  = 60
$B_StartSpam_height = 30
$B_StartSpam_x 	    = 7
$B_StartSpam_y      = $B_LoadProject_y + $B_StartSpam_height
$B_StartSpam 		= GUICtrlCreateButton("2. Start",$B_StartSpam_x,$B_StartSpam_y,$B_StartSpam_width,$B_StartSpam_height)

$B_Download_width 	= 80
$B_Download_height 	= 30
$B_Download_x 	    = $B_StartSpam_width + 33
$B_Download_y       = $B_StartSpam_y
$B_Download 		= GUICtrlCreateButton("Download ảnh",$B_Download_x,$B_Download_y,$B_Download_width,$B_Download_height)

$L_MessageHub_width 	= $GUI_width
$L_MessageHub_height 	= 30
$L_MessageHub_x 		= 7
$L_MessageHub_y 		= $GUI_height - 20
$L_MessageHub = GUICtrlCreateLabel("App đã sẵn sàng",$L_MessageHub_x,$L_MessageHub_y,$L_MessageHub_width,$L_MessageHub_height)

GUISetState()