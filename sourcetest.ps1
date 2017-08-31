workflow sourcetest
{
    Param(
        $VMName,
        $ResourceGroup
    )
    $conn = Get-AutomationConnection -Name AzureRunAsConnection
    Add-AzureRMAccount -ServicePrincipal -Tenant $conn.TenantID -ApplicationID $conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
    Start-AzureRMVM -Name $VMName -ResourceGroupName $ResourceGroup
}