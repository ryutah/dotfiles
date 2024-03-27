;;
;; An autohotkey script that provides gtk-emacs-key-theme like keybinding on Windows
;; forked from https://github.com/usi3/emacs.ahk
;;
InstallKeybdHook()
#UseHook

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay(0)

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target()
{
  if WinActive("ahk_class ConsoleWindowClass") ; Cygwin
    Return 1
  if WinActive("ahk_class MEADOW") ; Meadow
    Return 1
  if WinActive("ahk_class cygwin/x X rl-xterm-XTerm-0")
    Return 1
  if WinActive("ahk_class MozillaUIWindowClass") ; keysnail on Firefox
    Return 1
  ; Avoid VMwareUnity with AutoHotkey
  if WinActive("ahk_class VMwareUnityHostWndClass")
    Return 1
  if WinActive("ahk_class Vim") ; GVIM
    Return 1
  if WinActive("ahk_class CASCADIA_HOSTING_WINDOW_CLASS") ; Windows Terminal
    Return 1
  if WinActive("ahk_exe alacritty.exe") ; alacritty
    Return 1
  Return 0
}

is_vscode()
{
  if WinActive("ahk_exe Code.exe") ; VSCode
    Return 1
}

; <ctrl>b
^b::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("{Left}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><ctrl>b
+^b::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("+{Left}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>f
^f::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("{Right}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><ctrl>f
+^f::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("+{Right}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>p
^p::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("{Up}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>n
^n::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("{Down}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>n
!n::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^n")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><ctrl>n
+^n::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("+{Down}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>d
^d::
{ ; V1toV2: Added bracket
  If (is_target() or is_vscode())
    Send(A_ThisHotkey)
  Else
    Send("{Del}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>h
^h::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("{BS}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>a
^a::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("{Home}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>e
^e::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("{End}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>e
!e::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^e")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><alt>b
+!b::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("+^{Left}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><alt>f
+!f::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("+^{Right}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>w
^w::
{ ; V1toV2: Added bracket
  If (is_target() or is_vscode())
    Send(A_ThisHotkey)
  Else
    Send("^x")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>y
^y::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^v")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>k
; delete chars from cursor to end of line
^k::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("{ShiftDown}{END}{SHIFTUP}")
    Sleep(50)
    Send("{Del}")
    ;Send ^x
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>u
; delete chars from cursor to beginning of line
^u::
{ ; V1toV2: Added bracket
  If (is_target() or is_vscode())
    Send(A_ThisHotkey)
  Else
  {
    Send("{ShiftDown}{HOME}{SHIFTUP}")
    Sleep(50)
    Send("{Del}")
    ;Send ^x
  }
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>m
; new line(enter)
^m::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("{Enter}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>\
^\::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^a")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>f
!f::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^f")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>w
!w::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^w")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><alt>t
+!t::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("+^t")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl><shift>n
+!n::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("+^n")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>a
!a::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^a")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>k
!k::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^k")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>d
!d::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^d")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>y -> <ctrl>y
!y::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^y")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>z -> <ctrl>z
!z::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^z")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>q -> <alt><f4>
!q::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("!{F4}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>b -> <ctrl>b
!b::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^b")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>i -> <ctrl>i
!i::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^i")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>u -> <ctrl>u
!u::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^u")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>p -> <ctrl>p
!p::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("^p")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt><shift>p -> <ctrl><shift>p
+!p::
{ ; V1toV2: Added bracket
  If is_target()
    Send(A_ThisHotkey)
  Else
    Send("+^p")
  Return
}

; ===========================================
; ime control
; ===========================================

#Include "lib\IME.ahk"

; <esc>
; ime reset. (for vim mode change)
Esc::
{ ; V1toV2: Added bracket
  getIMEMode := IME_GET()
  if (getIMEMode = 1) {
    IME_SET(0)
  }
  Send("{Esc}")
  Return
}

; <ctrl>[
; ime reset. (for vim mode change)
^[::
{
  getIMEMode := IME_GET()
  if (getIMEMode = 1) {
    IME_SET(0)
  }
  Send(A_ThisHotkey)
  Return
} ; V1toV2: Added bracket in the end
#HotIf

; ===========================================
; window control
; ===========================================

; <shfit> + Wheel for horizontal scrolling
+WheelDown::WheelRight
+WheelUp::WheelLeft
; <win>  + Wheel for horizontal scrolling
#WheelDown::WheelRight
#WheelUp::WheelLeft

; See https://github.com/pmb6tz/windows-desktop-switcher
; #Include lib\desktop_switcher.ahk
