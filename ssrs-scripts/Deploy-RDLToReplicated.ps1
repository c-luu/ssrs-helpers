# NOTE: Deploy-RDLToReplicated deploys reports to the Replicated path on SSRS and Live if the flag is set.
# TODO: Secure sensitive parameter values. Have try catching. Be able to choose Replicated And/Or Live folders.

function Deploy-RDLToReplicated (
    [string] $reportName,
    [switch] $goLive
)
{
    . Get-ScriptDirectory + "\Variables.ps1"
    
    $rssPath = $varRSSPath
    $reportServerURL = $varReportServerURL
    $reportFolder = $varReportFolder
    $reportShare = $varReportShare + $reportName + ".rdl'" 
    $reportName = "reportName='" + $reportName + "'"
    $dataSourceName = $varDataSourceName
    $dataSourceFullPath = $varDataSourceFullPath
    $reportHidden = $varReportHidden
    $oneLine = "rs.exe -i $rssPath -s $reportServerURL -v $reportFolder -v $reportShare -v $reportName -v $dataSourceName -v $dataSourceFullPath -v $reportHidden"
    
    if (!$goLive) {
        Invoke-Expression $oneLine
    }
    
    else {
        Invoke-Expression $oneLine
        
        $reportFolder = $varLiveReportFolder
        $dataSourceName = $varLiveDataSourceName
        $dataSourceFullPath = $varLiveDataSourceFullPath
        $oneLine = "rs.exe -i $rssPath -s $reportServerURL -v $reportFolder -v $reportShare -v $reportName -v $dataSourceName -v $dataSourceFullPath -v $reportHidden"
        
        Invoke-Expression $oneLine
    }
}

function Get-ScriptDirectory {
    return $MyDir = Split-Path $MyInvocation.MyCommand.Definition
}
