function global:Timer() {
  param (
    $Min
  )
  if($Min -eq $null) {
    $Min = 3
  }
  param (
    $Song
  )
  if($Song -eq $null) {
    $Song = "dance till your dead"
  }

  $sleepOptions = @{
    Seconds = ($Min)
  }

  Start-Sleep @sleepOptions
  
  $processOptions = @{
    FilePath = "spotify"
    ArgumentList = "play $(Song)"
  }
  
  Start-Process @processOptions
}

Export-ModuleMember -function Timer
