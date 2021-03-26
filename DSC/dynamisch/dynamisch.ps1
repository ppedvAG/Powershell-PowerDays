configuration WebServerConfiguration
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    node $AllNodes.NodeName
    {
        foreach($Feature in $Node.WindowsFeatures)
        {
            WindowsFeature $Feature.Name
            {
                Name = $Feature.Name
                Ensure = $Feature.Ensure                
            }
        }
    }
}

WebServerConfiguration -OutputPath C:\KursExamples\DSC\dynamisch\ -ConfigurationData C:\KursExamples\DSC\dynamisch\dynamisch-configurationdata.psd1 -Verbose
