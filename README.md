# RenameMacCustom  

Script to rename a mac based on an Extension provided by parameter 4 from Jamf or via a hard coded value embeded in script. If you use this away from Jamf you should remove the last line of "jamf recon".

Example
Serial Number 4 unique characters - 232FFFF  
```serialNumber=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}' | cut -c 6-12)```   
FFFF1232FFFF = 232FFFF  
custom Extension - HKIT   
HK - Country Code  
IT - Department  

Script will then work through to rename the Mac, to ensure the name is reflected in jamf a jamf recon is included in the script, remove this line if you are not using Jamf.
