$SpotifyLoc = "C:\Users\steph\AppData\Roaming\Spotify\Spotify"
$LogLoc = "C:\Users\steph\Scripts\functions.log"
$ErrorLoc = "C:\Users\steph\Scripts\error.log"
$AutoHotkeyLoc = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\AutoHotkey\AutoHotkey"
$ZoomLoc = "C:\Users\steph\AppData\Roaming\Zoom\bin\Zoom"
$EdgeLoc = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$DiscordLoc = "C:\Users\steph\AppData\Local\Discord\app-1.0.9003\Discord.exe"

function global:Edge() {
  param (
    [switch] $s,
    [switch] $p
  )
  $ProfileDir = "Default"
  if ($s) {
    $ProfileDir = "Profile 1"
  }

  $processOptions = @{
    FilePath = ($EdgeLoc)
    WindowStyle = "maximized"
    ArgumentList = "$('--profile-directory="')$ProfileDir$('"')"
    PassThru = ($true)
  }
  Start-Process @processOptions >> ($LogLoc)  
}

function global:discord() {
  $processOptions = @{
    FilePath = ($DiscordLoc)
    WindowStyle = "maximized"
    RedirectStandardOutput = ($LogLoc)
    RedirectStandardError = ($ErrorLoc)
  }
  Start-Process @processOptions
}

Set-Alias -Name vim -Value "C:\Program Files\Git\usr\bin\vim.exe"

function global:Start-Spotify() {
  $processOptions = @{
    FilePath = ($SpotifyLoc)
    WindowStyle = "maximized"
  }
  Start-Process @processOptions >> ($LogLoc)  
}

function global:ahk() {
  param (
    $FilePath
  )
  $processOptions = @{
    FilePath = ($AutoHotkeyLoc)
    ArgumentList = ($FilePath)
    PassThru = ($true)
  }
  Start-Process @processOptions
}


function global:exp() {
  param (
    $Location
  )
  if($Location -eq $null) {
    $Location = "."
  }
  Start-Process -FilePath "explorer" -ArgumentList ($Location) >> ($LogLoc)
}

function global:Zoom() {
  param (
    $MeetingId,
    [switch] $c
  )
  if($MeetingId -ne $null) {
    $MeetingId = "--url=`"$MeetingId`""
  } else {
    $MeetingId = " "
  }
  if ($c -eq $true) {
    Set-Clipboard "https://berkeley.zoom.us/my/skrider"
  }
  Start-Process -Filepath ($ZoomLoc) -ArgumentList ($MeetingId) >> ($LogLoc)
}

Export-ModuleMember -function Edge
Export-ModuleMember -function Start-Spotify
Export-ModuleMember -function exp
Export-ModuleMember -function Zoom
