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

send_key(key)
{
  SendInput(key)
  Sleep(2)
}

; <ctrl>b
^b::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("{Left}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><ctrl>b
+^b::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("+{Left}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>f
^f::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("{Right}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><ctrl>f
+^f::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("+{Right}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>p
^p::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("{Up}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>n
^n::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("{Down}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>n
!n::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^n")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><ctrl>n
+^n::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("+{Down}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>d
^d::
{ ; V1toV2: Added bracket
  If (is_target() or is_vscode())
    send_key(A_ThisHotkey)
  Else
    send_key("{Del}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>h
^h::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("{BS}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>a
^a::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("{Home}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>e
^e::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("{End}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>e
!e::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^e")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><alt>b
+!b::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("+^{Left}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><alt>f
+!f::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("+^{Right}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>w
^w::
{ ; V1toV2: Added bracket
  If (is_target() or is_vscode())
    send_key(A_ThisHotkey)
  Else
    send_key("^x")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>y
^y::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^v")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>k
; delete chars from cursor to end of line
^k::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("{ShiftDown}{END}{SHIFTUP}")
    Sleep(50)
    send_key("{Del}")
    ;Send ^x
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>u
; delete chars from cursor to beginning of line
^u::
{ ; V1toV2: Added bracket
  If (is_target() or is_vscode())
    send_key(A_ThisHotkey)
  Else
  {
    send_key("{ShiftDown}{HOME}{SHIFTUP}")
    Sleep(50)
    send_key("{Del}")
    ;Send ^x
  }
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>m
; new line(enter)
^m::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("{Enter}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl>\
^\::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^a")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>f
!f::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^f")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>w
!w::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^w")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <shift><alt>t
+!t::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("+^t")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <ctrl><shift>n
+!n::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("+^n")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>a
!a::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^a")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>k
!k::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^k")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>d
!d::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^d")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>y -> <ctrl>y
!y::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^y")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>z -> <ctrl>z
!z::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^z")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>q -> <alt><f4>
!q::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("!{F4}")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>b -> <ctrl>b
!b::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^b")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>i -> <ctrl>i
!i::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^i")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>u -> <ctrl>u
!u::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^u")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt>p -> <ctrl>p
!p::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("^p")
  Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

; <alt><shift>p -> <ctrl><shift>p
+!p::
{ ; V1toV2: Added bracket
  If is_target()
    send_key(A_ThisHotkey)
  Else
    send_key("+^p")
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
  send_key("{Esc}")
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
  send_key(A_ThisHotkey)
  Return
} ; V1toV2: Added bracket in the end
#HotIf

; ===========================================
; window control
; ===========================================

; <shfit> + Wheel for horizontal scrolling
; +WheelDown::WheelRight
; +WheelUp::WheelLeft
; <win>  + Wheel for horizontal scrolling
; #WheelDown::WheelRight
; #WheelUp::WheelLeft

; See https://github.com/pmb6tz/windows-desktop-switcher
; #Include lib\desktop_switcher.ahk
