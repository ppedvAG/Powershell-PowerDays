@{
    AllNodes = @(
        @{
        NodeName = "Member1"
        WindowsFeatures = @(
            @{
                Name = "Web-Server"
                Ensure = "Present"
            },
            @{
                Name = "Web-Mgmt-Tools"
                Ensure = "Present"
                Dependson = "[WindowsFeature]web-server"
            }
          )
        }
    )
}