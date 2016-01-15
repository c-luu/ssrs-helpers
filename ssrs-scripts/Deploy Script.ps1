function Deploy-RDLToReplicated (
    [string] $reportName,
    [switch] $goLive
)
{
    $rssPath = ""
    $reportServerURL = ""
    $reportFolder = "reportFolder=''"
    $reportShare = "reportShare='" + $reportName + ".rdl'" 
    $reportName = "reportName='" + $reportName + "'"
    $dataSourceName = "datasourceName=''"
    $dataSourceFullPath = "datasourceFullPath=''"
    $reportHidden = "reportHidden='FALSE'"
    
    $oneLine = "rs.exe -i $rssPath -s $reportServerURL -v $reportFolder -v $reportShare -v $reportName -v $dataSourceName -v $dataSourceFullPath -v $reportHidden"
    if (!$goLive) {
        Invoke-Expression $oneLine
    }
    
    else {
        Invoke-Expression $oneLine
        $reportFolder = "reportFolder=''"
        $dataSoureName = "datasourceName=''"
        $dataSourceFullPath = "datasourceFullPath=''"
        Invoke-Expression $oneLine
    }
}

Deploy-RDLToReplicated '' -goLive
