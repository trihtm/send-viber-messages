#include <GuiListView.au3>;NoShow

;~ Hàm thoát chương trình
HotKeySet("{Esc}","ExitTool")

Func ExitTool()
	Exit
EndFunc

Func GetComputerUnique()
	$name=@ComputerName

	Message("Unique "&$name)

	Return $name
EndFunc

Func StartViber()

	Local $path = IniRead($ConfigFile,"PATH","FULL","Not Found")

	Message("Viber đang được khởi động. Xin vui lòng chờ.")

	RunWait ($path,"", @SW_MINIMIZE)

EndFunc

Func SendKey($Key)

	; ControlSend($DetectViber,'','',$Key)

	Send($Key)

EndFunc

Func Download()

	Message("Tiến hành download ảnh")

	$PATH = $Image

	Message($PATH)

	Local $download = InetGet($PATH,"C:\Temp\Viber\"&$Param_Project&".jpg", 1, 1)

	Do
	    Sleep(250)
	Until InetGetInfo($download, 2) ; Check if the download is complete.

	InetClose($download) ; Close the handle to release resources.

	Message("Download thành công")

EndFunc


Func SearchColor($Color)

	$pos = ControlGetPos ($DetectViber,"","")

	$coordinates = PixelSearch(@DesktopWidth - $pos[2], 0, @DesktopWidth, $pos[3], $Color)

	If Not @error Then
		Return True
	EndIf

	Return False

EndFunc

Func GetColor($x, $y)

	Return HEX(PixelGetColor($x,$y),6)

EndFunc

Func CheckNetwork()
   WinActivate($DetectViber)

   If GetColor(126, 81) = 'ADADAD' Then

		CommitError() ; rot mang

		Exit

	EndIf
EndFunc

Func Handler($IDRunning, $TxtSend, $SDT)

    CheckNetwork()

	Message("Spam SĐT "&$SDT)

	WinMove($DetectViber, '', 250, 0, 772, 560)
	WinActivate($DetectViber)

	Sleep(200)

	InputNumber($SDT)

	$Count = 0

	Do
	    CheckNetwork()

		$Count = $Count + 1

	    Message("Chờ phản hồi từ Viber lần thứ "& $Count)

		Sleep(1000)

		If SearchColor(0xAAE0F7) Then

			SendMessage($TxtSend)

			If $Image <> "" Then
				Sleep(1000)
				SendImage()
				Sleep(5000)
			EndIf

			$Check = PreventErrorMessage()

			If $Check Then

				$DataPhones[$IDRunning] = AssignPhone($IDRunning,$SDT,2) ; network

				Message("Lỗi network "&$SDT)

			Else

				$Time = 0
				$Send = True

				Message("Chờ tin nhắn được gửi đi")

				Do
				   CheckNetwork()
				    $coord = PixelSearch(332, 128, 749, 502, 0xAAE0F7)

					$Time = $Time + 1

					If $Time = 10 Then

						$DataPhones[$IDRunning] = AssignPhone($IDRunning,$SDT,2)

						$Send = False

						ExitLoop
					EndIf

					Sleep(1200)
				Until IsArray($coord)

				If $Send Then
					$DataPhones[$IDRunning] = AssignPhone($IDRunning,$SDT,0)

					Message("Spam thành công "&$SDT)
				EndIf

				Do
				    CheckNetwork()
					DeleteLog()

					Sleep(2000)
				Until GetColor(242, 103) = 'E5E5E5'

			EndIf

			ExitLoop
		EndIf

		$Check = PreventErrorMessage()

		If $Check Then

			$DataPhones[$IDRunning] = AssignPhone($IDRunning,$SDT,1) ; không có viber

			Message("Lỗi network hoặc ko có Viber "&$SDT)

			ExitLoop
		Endif

	Until $Count >= 10

	ShowView()
EndFunc

Func SendImage()

   Message("Bắt đầu gửi ảnh")

	$PATH = "C:\Temp\Viber\"&$Param_Project&".jpg"

	; 1366 ,768
	; 945 , 530
	; 772 , 560

	ClipPut($PATH)

	LeftCLick(345,500)

	Sleep(500)

	Do
		; Cho den khi co popup
	Until WinExists($DetectSendFile) = 1

	If WinExists($DetectSendFile) Then

	  If WinActivate($DetectSendFile) Then

		 ControlClick($DetectSendFile, "", "[CLASS:Edit; INSTANCE:1]")

		 Sleep(500)

		 Send ("^a")

		 Sleep(500)

		 Send ("^v")

		 Sleep(500)

		 ControlClick($DetectSendFile, "", "[CLASS:Button; INSTANCE:2]")

	  EndIf

	  Sleep(500)

	  WinClose($DetectSendFile)
   EndIf

   Sleep(500)

   WinActivate($DetectViber)

   Message("Đã submit gửi ảnh")

EndFunc

Func LeftClick($x,$y)
	Sleep(500)

	ControlClick($DetectViber,"","","left",1,$x,$y)
EndFunc

Func RightClick($x,$y)
	Sleep(500)

	ControlClick($DetectViber,"","","right",1,$x,$y)
EndFunc

Func DeleteLog()

	Message("Tiến hành xóa log")

	LeftCLick(100,70) ; 730 , 110

	Sleep(500)
	SendKey ("{Delete}")

	Sleep(500)
	SendKey ("{Enter}")

EndFunc

Func Commit()

	Message("Tiến hành Commit dữ liệu lên Viad")

	; Build TxtContent
	Local $TxtContent = ""

	For $start = 1 to UBound($Phones)-1

		Local $Data  = $DataPhones[$start]

		$TxtContent &= $Data[1]
		$TxtContent &= "_"
		$TxtContent &= $Data[2]
		$TxtContent &= "@"

	Next

	; $BuildLink = "http://sms.ketnoimail.com/UpdateViber.Asp?TxtProjectId="&$Param_Project&"&TxtProjectTableName="&$TxtTableName&"&TxtContent="&$TxtContent
	$BuildLink = "http://sms.ketnoimail.com/UpdateViber.Asp?TxtProjectId="&$Param_Project&"&TxtProjectTableName="&$TxtTableName&"&TxtContent="&$TxtContent&"&TxtCheck=1"

	Local $result 	= InetRead($BuildLink)

	ConsoleWrite($BuildLink)

EndFunc


Func PreventErrorMessage()

	Sleep(500)

	Opt("WinTitleMatchMode", 3)

	Local $Exists = WinExists("Viber")

	If $Exists Then
		SendKey("{ENTER}")
	EndIf

	Return $Exists

EndFunc

Func InputNumber($SDT)
	ClipPut($SDT)

	SendKey ("^d")
	SendKey ("^a")
	SendKey ("^v")

	LeftClick(200,270)
EndFunc

Func SendMessage($Message)

	LeftClick(430,500)

	ClipPut($Message)

	SendKey ("^v")
	SendKey ("{Enter}")
	SendKey ("{Enter}")

EndFunc

Func AssignPhone($ID,$Phone,$Status)

	If $Status = 2 And $TxtLastStatus = 2 Then
		$TxtBug = $TxtBug + 1
	Else
		$TxtBug = 0
	EndIf

	$TxtLastStatus = $Status

	Dim $Array[3]

	$Array[0] = $ID
	$Array[1] = $Phone
	$Array[2] = $Status

	Return $Array

EndFunc

Func ShowView()

;~ 	_GUICtrlListView_DeleteAllItems($V_Phone)

	If Not IsArray($Phones) Then

		Message("Không có dữ liệu điện thoại.")

	Else
;~ 		For $start = 1 to UBound($Phones)-1
;~
;~ 			GUICtrlCreateListViewItem(_ArrayToString($DataPhones[$start], '|'),$V_Phone)

;~ 		Next
	Endif

EndFunc

Func LoadProject()

	Message("Tiến hành tải dữ liệu dự án")

	$Lock_LoadPhone = True
	$Param_Project  = 0

	Local $Project  = GUICtrlRead($I_Project)
	Local $AppID 	= GUICtrlRead($I_AppID)
	Local $LDelay 	= GUICtrlRead($I_Delay)

	IniWriteSection($INI, $SECTION, "projectid="& $Project & @LF & "appid="& $AppID & @LF & "delay="& $LDelay & @LF &"Key3=Value3")

	Local $Unique 	= GetComputerUnique()
	Local $Link 	= "http://sms.ketnoimail.com/infoviber.asp?TxtProjectId="&$Project&"&TxtDevice="&$Unique

	Local $result = ""
	Local $count = 1

	While StringLen($result) <= 0

		 If $count >= 5 Then
			MsgBox(0, "Viber", "Da bi dung , goi lay SDT 5 lan")

			Exit
		 EndIf

		 $result 	= InetRead($Link)

		 Message("Call API Get Mobile Done. Length = "& StringLen($result))

		 If(StringLen($result) <= 0) Then
			Sleep(2000)
		 Else
			ExitLoop
		 EndIf

		 $count = $count + 1
	WEnd

	$result = _XMLFileOpen($result)

	$status = _XMLGetValue("/viber/status")

	$Image  = _XMLGetValue("/viber/img")

	Message("Tải dữ liệu dự án thành công")

	Switch $status

		Case 1
			$projectstatus =  _XMLGetValue("/viber/projectstatus")

			Switch $projectstatus
				Case 0
					Message("Dự án đã bị khóa. Vui lòng mở khóa trên web quản lý Viber")
				Case 1
					Message("Dự án chưa sẵn sàng. Vui lòng bật trên web quản lý Viber")
				Case 2
					GUICtrlSetData($L_Name,_XMLGetValue("/viber/projecttitle"))
					GUICtrlSetData($L_TotalSMS,"Total SMS: "& _XMLGetValue("/viber/projectsmstotal"))

					$TxtTableName   = _XMLGetValue("/viber/projectdbname")
					$Lock_LoadPhone = False
					$Param_Project  = $Project

				Case 3
					Message("Dự án đã tạm dừng. Vui lòng bật trên web quản lý Viber")
				Case 9
					Message("Dự án đã chạy xong")
				Case Else
					Message("Có lỗi xảy ra, không lấy được thông tin")

			EndSwitch


		Case 2
			Message("Không có dự án này")
		Case 3
			Message("Chưa truyền Project ID")
		Case 4
			Message("Chưa nhập nội dung. Vui lòng nhập trên web quản lý Viber")
		Case Else
			Message("Có lỗi xảy ra. Không tải được dự án")

	EndSwitch

EndFunc

Func LoadPhoneFromCloud()

	Local $TxtOrder = 0

	Message("Tiến hành tải dữ liệu điện thoại")

	$TxtApp = $TxtApp + 1

	Local $Unique 	= GetComputerUnique()
	Local $Link 	= "http://sms.ketnoimail.com/infoviberlist.asp?TxtProjectId="&$Param_Project&"&TxtApp="&$TxtApp&"&TxtOrder="&$TxtOrder&"&TxtDevice="&$Unique

	Local $result = ""
	Local $count = 1

	While StringLen($result) <= 0

		 If $count >= 5 Then
			MsgBox(0, "Viber", "Da bi dung , goi lay SDT 5 lan")

			Exit
		 EndIf

		 $result 	= InetRead($Link)

		 Message("Call API Get Mobile Done. Length = "& StringLen($result))

		 If(StringLen($result) <= 0) Then
			Sleep(2000)
		 Else
			ExitLoop
		 EndIf

		 $count = $count + 1
	WEnd

    $result = _XMLFileOpen($result)

	$status = _XMLGetValue("/viber/status")

	Message("Tải dữ liệu điện thoại thành công |"&$status)

	Switch $status

		Case 1
			Message("Chưa truyền mã dự án hoặc mã dự án không tồn tại")
		Case 2
			Message("Chưa truyền mã dự án hoặc mã dự án không tồn tại")
		Case 3
			Message("Chưa tạo nội dung. Vui lòng tạo trên web quản lý Viber")
		Case 9
			Message("Chưa tạo nội dung. Vui lòng tạo trên web quản lý Viber")
		Case 4
			Message("Không tồn tại trạng thái")
		Case 5
			Message("Dự án bị khóa. Vui lòng kiểm tra trên web quản lý Viber")
		Case 6
			Message("Dự án chưa bật. Vui lòng kiểm tra trên web quản lý Viber")
		Case 7
			Message("Dự án đã tạm dừng. Vui lòng kiểm tra trên web quản lý Viber")
		Case 8
			Message("Dự án đã gửi xong. Vui lòng kiểm tra trên web quản lý Viber")
		Case 10
			Message("Danh sách điện thoại của dự án đã hết")
		Case 11
			; Message("Lỗi hệ thống. Vui lòng liên hệ Trihtm")
			Return LoadPhoneFromCloud()
		Case 12
			Message("Lỗi chế độ. Vui lòng kiểm tra lại trên app")
		Case 13
			Message("Case 13. Tải lại dữ liệu dự án")

			Return LoadPhoneFromCloud()
		Case 14
			Message("Case 14. Tải lại dữ liệu dự án")

			Return LoadPhoneFromCloud()
		Case 0

			$ConfigMessage = _XMLGetField("/viber/contents/content")

			$Phones = _XMLGetField("/viber/phones/phone")

			DIM $DataPhones[UBound($Phones)]

			Message("Tiến hành hiển thị dữ liệu điện thoại")

			If Not IsArray($Phones) Then

				Message("Không có dữ liệu điện thoại.")

			Else
				For $start = 1 to UBound($Phones)-1

					$DataPhones[$start] = AssignPhone($start,$Phones[$start],3)

				Next

				ShowView()

				Message("Hiển thị dữ liệu thành công. Chuẩn bị spam.")

				Return True

			EndIf
		Case Else
			Message("Lỗi hệ thống. Vui lòng liên hệ Trihtm")


	EndSwitch

	Return False
EndFunc

Func StartSpam()

	if $Lock_Spam Then
		Message("Đang spam. Không thể thực hiện lệnh này.")

		Return 0
	EndIf

	if $Lock_LoadPhone Then

		Message("Bạn phải load dự án trước.")

	Else

		$Check = LoadPhoneFromCloud()

		ConsoleWrite($Check)

		If $Check Then

			Sleep(1000)

			If Not IsArray($Phones) Then

				Message("Không có dữ liệu điện thoại.")

			Else

				$Lock_Spam = True

			   Local $Delay = GUICtrlRead($I_Delay)
			   $Delay = $Delay * 1000

				For $start = 1 to UBound($Phones)-1

					If $TxtBug >= 10 Then

						CommitError()

						Exit

					 EndIf

					 Handler($start, $ConfigMessage[$start], $Phones[$start])

				 	 Message("Sleeping "& $Delay)

					 Sleep($Delay)

				Next

				Commit()

				Sleep(1000)

				$Lock_Spam = False

				StartSpam()

			EndIf
		EndIf

	EndIf

EndFunc

Func Message($Mess)

	ConsoleWrite($Mess&@LF)

	GUICtrlSetData($L_MessageHub,$Mess)
EndFunc

Func _Restore()
	$k = IniRead($INI, $SECTION, 'projectid', '0')

	GUICtrlSetData($I_Project,$k)

	$k = IniRead($INI, $SECTION, 'appid', 1)

	GUICtrlSetData($I_AppID, $k)

	$k = IniRead($INI, $SECTION, 'delay', 5)

	GUICtrlSetData($I_Delay, $k)
EndFunc

Func _CheckFile()

	If Not FileExists($INI) Then

		$open= FileOpen($INI,34)

		If @error Then
			MsgBox(0,$title,'Không thể tạo tập tin dữ liệu'&@CR& _
			'Vui lòng xem lại nơi đặt chương trình')
			Exit
		EndIf

		FileClose($open)

		IniWriteSection($INI,$SECTION,'')
	EndIf

EndFunc

Func CommitError()
	Local $Link = "http://api2.ketnoimail.com/applog.asp?"

	$Link &= "TxtProjectId="&$Param_Project
	$Link &= "&TxtProjectTitle="&GUICtrlRead($L_Name)
	$Link &= "&TxtAppName=VIBER"
	$Link &= "&TxtAppType="&GUICtrlRead($I_AppID)

	Local $result 	= InetRead($Link)

	$result = _XMLFileOpen($result)

	$status = _XMLGetValue("/app/status")

	If $status <> 0 Then
		MsgBox(0,"","Cập nhật thông tin lên máy chủ thất bại")
	EndIf

	Message($status)

	MsgBox(0,"","Rớt mạng. Stop Viber")

EndFunc