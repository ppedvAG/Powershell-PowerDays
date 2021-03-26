configuration WebServerConfiguration
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    Node "Member1"
    {
        WindowsFeature WebServer
        {
            Name = "web-Server"
            Ensure = "Present"
        }
        WindowsFeature WebManagementTool
        {
            Name= "Web-Mgmt-Tools"
            Ensure = "Present"
            Dependson = "[WindowsFeature]WebServer"
        }
    }
}

WebServerConfiguration -OutputPath C:\KursExamples\DSC\simple\
