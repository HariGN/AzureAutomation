#!powershell
#Requires -Version 5.1

#AnsibleRequires -CSharpUtil Ansible.Basic
#AnsibleRequires -PowerShell Ansible.ModuleUtils.AddType

$spec = @{
    options = @{
        buildnumber = @{ type = "str"; required = $true }
        regname     = @{ type = "str"; required = $true }
    }
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$buildnumber = $module.Params.buildnumber
$regname = $module.Params.regname
$check_mode = $module.CheckMode

$currentbuildnumber = (Get-ItemProperty -Path "HKLM:\SOFTWARE\$regname" -Name buildnumber -ErrorAction SilentlyContinue).buildnumber 
$willbeChanged = $false
if($currentbuildnumber -ne $buildnumber){
    $willbeChanged = $true
}
$module.Diff.before = @{buildnumber = $currentbuildnumber}
$module.Result.before_value = @{buildnumber = $currentbuildnumber}
if ($check_mode) {
  $module.Diff.after = @{buildnumber = $buildnumber}
  $module.Result.value = @{buildnumber = $buildnumber}
  $module.Result.changed = $willbeChanged
}

try {
    if($willbeChanged -eq $true){
        if(!(Test-Path "HKLM:\SOFTWARE\$regname")){
            New-Item -Path "HKLM:\SOFTWARE\$regname" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\$regname" -Name buildnumber -Value $buildnumber
        $module.Diff.after = @{buildnumber = $buildnumber}
        $module.Result.value = @{buildnumber = $buildnumber}
        $module.Result.changed = $true
    }
    else{
        $module.Diff.after = @{buildnumber = $buildnumber}
        $module.Result.value = @{buildnumber = $buildnumber}
        $module.Result.changed = $false
    }
}
catch {
    $module.FailJson("failure",$_)
}
finally{
  $module.ExitJson()
}