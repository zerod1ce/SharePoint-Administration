

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Stop
#Allow or disallow List Item Menu Context in SharePoint List.
function Manage-ListItemMenu()
	{
	param ([string]$WebURL,[string]$List,[string]$Field,[bool]$Allow)
		Try
		{
             $Web = Get-SPWeb $WebURL
             $Lst = $web.Lists[$List]
             $Fld = $Lst.Fields[$Field]
             if($Allow -eq $True)
             {
               Write-Host "Allow List Item Menu Context in SharePoint List" -ForegroundColor Green
               $Fld.ListItemMenuAllowed = "Required"
               $msg = "The List Item Menu Context has been allowed for"
             }
            else
            {
               Write-Host "DisAllow List Item Menu Context in SharePoint List" -ForegroundColor Green
               $Fld.ListItemMenuAllowed = "Prohibited"
               $msg = "The List Item Menu Context has been disallowed for"
            }
  
                #Reflect the Update
                $Fld.Update()
                $Lst.Update()
		$Web.Dispose()
                Write-Host $msg $Field "successfully" -ForegroundColor Cyan
			
		}
		Catch
		{
			Write-Host $_.Exception.Message -ForegroundColor Red
		}
	}

Manage-ListItemMenu -WebURL "http://epm:19812/PWA/" -List "LinkToItemMenu" -Field "Allow" -Allow $False

