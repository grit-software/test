##################################################################################
#
#
#  Script name: SetFolderPermission.ps1
#  Author:      goude@powershell.nu
#  Homepage:    www.powershell.nu
#
#
##################################################################################

param ([string]$Path, [string]$Access, [string]$Permission = ("Modify"), [switch]$help)

function GetHelp() {

$HelpText = @"

DESCRIPTION:
NAME: SetFolderPermission.ps1
Sets FolderPermissions for User on a Folder.
Creates folder if not exist.

PARAMETERS: 
-Path			Folder to Create or Modify (Required)
-User			User who should have access (Required)
-Permission		Specify Permission for User, Default set to Modify (Optional)
-help			Prints the HelpFile (Optional)

SYNTAX:
./SetFolderPermission.ps1 -Path C:\Folder\NewFolder -Access Domain\UserName -Permission FullControl

Creates the folder C:\Folder\NewFolder if it doesn't exist.
Sets Full Control for Domain\UserName

./SetFolderPermission.ps1 -Path C:\Folder\NewFolder -Access Domain\UserName

Creates the folder C:\Folder\NewFolder if it doesn't exist.
Sets Modify (Default Value) for Domain\UserName

./SetFolderPermission.ps1 -help

Displays the help topic for the script

Below Are Available Values for -Permission

"@
$HelpText

[system.enum]::getnames([System.Security.AccessControl.FileSystemRights])

}

function CreateFolder ([string]$Path) {

	# Check if the folder Exists

	if (Test-Path $Path) {
		Write-Host "Folder: $Path Already Exists" -ForeGroundColor Yellow
	} else {
		Write-Host "Creating $Path" -Foregroundcolor Green
		New-Item -Path $Path -type directory | Out-Null
	}
}

function SetAcl ([string]$Path, [string]$Access, [string]$Permission) {



	# Remove permissions
	#RemoveInheritance $Path
	#RemoveNTFSPermissions $Path "Authenticated Users" "Modify, ChangePermissions"
	#RemoveNTFSPermissions $Path "Users" "Modify, ChangePermissions"

	# Get ACL on FOlder

	$GetACL = Get-Acl $Path

	# Set up AccessRule

	$Allinherit = [system.security.accesscontrol.InheritanceFlags]"ContainerInherit, ObjectInherit"
	$Allpropagation = [system.security.accesscontrol.PropagationFlags]"None"
	$AccessRule = New-Object system.security.AccessControl.FileSystemAccessRule($Access, $Permission, $AllInherit, $Allpropagation, "Allow")

	# Check if Access Already Exists

	if ($GetACL.Access | Where { $_.IdentityReference -eq $Access}) {

		Write-Host "Modifying Permissions For: $Access" -ForeGroundColor Yellow

		$AccessModification = New-Object system.security.AccessControl.AccessControlModification
		$AccessModification.value__ = 2
		$Modification = $False
		$GetACL.ModifyAccessRule($AccessModification, $AccessRule, [ref]$Modification) | Out-Null
	} else {

		Write-Host "Adding Permission: $Permission For: $Access"

		$GetACL.AddAccessRule($AccessRule)
	}

	Set-Acl -aclobject $GetACL -Path $Path

	Write-Host "Permission: $Permission Set For: $Access" -ForeGroundColor Green
}

function AddNTFSPermissions($path, $object, $permission) {
    $FileSystemRights = [System.Security.AccessControl.FileSystemRights]$permission
    $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit"
    $PropagationFlag = [System.Security.AccessControl.PropagationFlags]"None"
    $AccessControlType =[System.Security.AccessControl.AccessControlType]::Allow
    $Account = New-Object System.Security.Principal.NTAccount($object)
    $FileSystemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Account, $FileSystemRights, $InheritanceFlag, $PropagationFlag, $AccessControlType)
    $DirectorySecurity = Get-ACL $path
    $DirectorySecurity.AddAccessRule($FileSystemAccessRule)
    Set-ACL $path -AclObject $DirectorySecurity
}

function RemoveNTFSPermissions($path, $object, $permission) {
    $FileSystemRights = [System.Security.AccessControl.FileSystemRights]$permission
    $InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]"ContainerInherit, ObjectInherit"
    $PropagationFlag = [System.Security.AccessControl.PropagationFlags]"None"
    $AccessControlType =[System.Security.AccessControl.AccessControlType]::Allow
    $Account = New-Object System.Security.Principal.NTAccount($object)
    $FileSystemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($Account, $FileSystemRights, $InheritanceFlag, $PropagationFlag, $AccessControlType)
    $DirectorySecurity = Get-ACL $path
    $DirectorySecurity.RemoveAccessRuleAll($FileSystemAccessRule)
    Set-ACL $path -AclObject $DirectorySecurity
}

function RemoveInheritance($path) {
    $isProtected = $true
    $preserveInheritance = $true
    $DirectorySecurity = Get-ACL $path
    $DirectorySecurity.SetAccessRuleProtection($isProtected, $preserveInheritance)
    Set-ACL $path -AclObject $DirectorySecurity
}





if ($help) { GetHelp }

if ($Path -AND $Access -AND $Permission) { 
	CreateFolder $Path 
	SetAcl $Path $Access $Permission
	
}

