;;
;; An autohotkey script that provides gtk-emacs-key-theme like keybinding on Windows
;; forked from https://github.com/usi3/emacs.ahk
;;
#InstallKeybdHook
#UseHook

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target()
{
  IfWinActive,ahk_class ConsoleWindowClass ; Cygwin
    Return 1
  IfWinActive,ahk_class MEADOW ; Meadow
    Return 1
  IfWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0
    Return 1
  IfWinActive,ahk_class MozillaUIWindowClass ; keysnail on Firefox
    Return 1
  ; Avoid VMwareUnity with AutoHotkey
  IfWinActive,ahk_class VMwareUnityHostWndClass
    Return 1
  IfWinActive,ahk_class Vim ; GVIM
    Return 1
  IfWinActive,ahk_class CASCADIA_HOSTING_WINDOW_CLASS ; Windows Terminal
    Return 1
  IfWinActive,ahk_exe alacritty.exe ; alacritty
    Return 1
  Return 0
}

; <ctrl>b
^b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {Left}
  Return

; <shift><ctrl>b
+^b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send +{Left}
  Return

; <ctrl>f
^f::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {Right}
  Return

; <shift><ctrl>f
+^f::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send +{Right}
  Return

; <ctrl>p
^p::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {Up}
  Return

; <ctrl>n
^n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {Down}
  Return

; <alt>n
!n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^n
  Return

; <shift><ctrl>n
+^n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send +{Down}
  Return

; <ctrl>d
^d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {Del}
  Return

; <ctrl>h
^h::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {BS}
  Return

; <ctrl>a
^a::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {Home}
  Return

; <ctrl>e
^e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {End}
  Return

; <alt>e
!e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^e
  Return

; <shift><alt>b
+!b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send +^{Left}
  Return

; <shift><alt>f
+!f::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send +^{Right}
  Return

; <ctrl>w
^w::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^x
  Return

; <ctrl>y
^y::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^v
  Return

; <ctrl>k
; delete chars from cursor to end of line
^k::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {ShiftDown}{END}{SHIFTUP}
    Sleep 50
    Send {Del}
    ;Send ^x
  Return

; <ctrl>u
; delete chars from cursor to beginning of line
^u::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    Send {ShiftDown}{HOME}{SHIFTUP}
    Sleep 50
    Send {Del}
    ;Send ^x
  }
  Return

; <ctrl>m
; new line(enter)
^m::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send {Enter}
  Return

; <ctrl>\
^\::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^a
  Return

; <alt>f
!f::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^f
  Return

; <alt>w
!w::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^w
  Return

; <shift><alt>t
+!t::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send +^t
  Return

; <ctrl><shift>n
+!n::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send +^n
  Return

; <alt>a
!a::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^a
  Return

; <alt>k
!k::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^k
  Return

; <alt>d
!d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^d
  Return

; <alt>y -> <ctrl>y
!y::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^y
  Return

; <alt>z -> <ctrl>z
!z::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^z
  Return

; <alt>q -> <alt><f4>
!q::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send !{F4}
  Return

; <alt>b -> <ctrl>b
!b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^b
  Return

; <alt>i -> <ctrl>i
!i::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^i
  Return

; <alt>u -> <ctrl>u
!u::
  If is_target()
    Send %A_ThisHotkey%
  Else
    Send ^u
  Return

; ===========================================
; ime control
; ===========================================

#Include lib\IME.ahk

; <esc>
; ime reset. (for vim mode change)
Esc::
  getIMEMode := IME_GET()
  if (getIMEMode = 1) {
    IME_SET(0)
  }
  Send {Esc}
  Return

; <ctrl>[
; ime reset. (for vim mode change)
^[::
  getIMEMode := IME_GET()
  if (getIMEMode = 1) {
    IME_SET(0)
  }
  Send %A_ThisHotkey%
  Return
#IfWinActive

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
#Include lib\desktop_switcher.ahk
