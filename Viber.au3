#include <Function.au3>
#include <GUI.au3>
#Include <WinAPI.au3>
#include <_XMLDomWrapper.au3>

Opt("MouseCoordMode",2)
Opt("PixelCoordMode",2)

Global $DetectViber	= "[CLASS:Qt5QWindow]"
Global $DetectSendFile	= "[CLASS:#32770]"
Global $ConfigFile 	= "viber.ini"

Global $Running = True
Global $Phones
Global $DataPhones
Global $ConfigMessage

Global $Lock_LoadPhone = True
Global $Lock_Spam = False
Global $Param_Project  = 0
Global $TxtApp = 1
Global $TxtTableName = "Not Found"
Global $Image = ""

Global $TxtBug = 0
Global $TxtLastStatus = 0

GLOBAL $INI = @ScriptDir&'\settings.ini'
GLOBAL $SECTION = "Config"

_CheckFile()
_Restore()

While 1
	Sleep(27)

	$msg = GUIGetMsg()

    If $msg = $GUI_EVENT_CLOSE Then ExitTool()	;Xử lý khi bấm thoát

	If $msg = $B_StartSpam  Then

		StartSpam()

	EndIf

	If $msg = $B_LoadProject Then

		StartViber()

		Sleep(3000)

		LoadProject()

	EndIf

	If $msg = $B_Download Then

		Download()

	EndIf
WEnd