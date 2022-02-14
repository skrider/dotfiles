$UpperAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
$LowerAlphabet = "abcdefghijklmnopqrstuvwxyz"
$NumberAlphabet = "0123456789"
$SymbolAlphabet = "!@#$%&*()?"

function global:Gen-Password() {
  param (
    [switch] $u,
    [switch] $l,
    [switch] $n,
    [switch] $s,
    [switch] $Copy,
    [int] $Length
  )

  $Alphabet = ""
  $AlphabetLength = 0
  if ($u) {
    $Alphabet = ($UpperAlphabet)
    $AlphabetLength = $UpperAlphabet.length
  }
  
  if ($l) {
    $Alphabet = "$($Alphabet)$($LowerAlphabet)"
    $AlphabetLength = ($AlphabetLength + $LowerAlphabet.length)
  }

  if ($l) {
    $Alphabet = "$($Alphabet)$($NumberAlphabet)"
    $AlphabetLength = ($AlphabetLength + $NumberAlphabet.length)
  }

  if ($l) {
    $Alphabet = "$($Alphabet)$($SymbolAlphabet)"
    $AlphabetLength = ($AlphabetLength + $SymbolAlphabet.length)
  }
  
  if ($AlphabetLength -eq 0) {
    $Alphabet = "$($LowerAlphabet)$($UpperAlphabet)$($NumberAlphabet)"
    $AlphabetLength = 62
  }

  if ($Length -eq $null) {
    $Length = 12
  }

  $Password = ""
  for (($i = 0); $i -lt $Length; $i++) {
    $Index = Get-Random -Maximum ($AlphabetLength)
    $Password = "$($Password)$($Alphabet.substring($Index, 1))"
  }

  if ($Copy) {
    Set-Clipboard -Value ($Password)
  }
  
  return $Password
}

Export-ModuleMember -function Gen-Password
