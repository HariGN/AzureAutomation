workflow sourcetest
{
    Param(
        $VM,
        $ResourceGroup
    )
    $conn = Get-AutomationConnection -Name AzureRunAsConnection
    Add-AzureRMAccount -ServicePrincipal -Tenant $conn.TenantID -ApplicationID $conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
    Start-AzureRMVM -Name $VM -ResourceGroupName $ResourceGroup
}
