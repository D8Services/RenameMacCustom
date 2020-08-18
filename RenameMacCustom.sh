#!/bin/bash


	###############################################################
	#	Copyright (c) 2019, D8 Services Ltd.  All rights reserved.  
	#											
	#	
	#	THIS SOFTWARE IS PROVIDED BY D8 SERVICES LTD. "AS IS" AND ANY
	#	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
	#	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	#	DISCLAIMED. IN NO EVENT SHALL D8 SERVICES LTD. BE LIABLE FOR ANY
	#	DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
	#	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	#	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
	#	ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	#	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	#	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	#
	#
	###############################################################
	# written by Tomos Tyler 2017 - Updated 2020

#Only Run as Root
thisUser=`whoami`
if [[ $thisUser != "root" ]];then
	echo "Can only run as root"
	exit 1
fi

extensionBU="" # could be ${4} parameter from Jamf, i.e. extensionBU="${4}"
#JamfURL=`defaults read /Library/Preferences/com.jamfsoftware.jamf.plist jss_url`
serialNumber=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')

# Trim the serial number to a specific number of chracters from Serial Number
IDNumber=$(echo ${serialNumber} | cut -c 6-12)

# Group the new name to a group of custom extension and serialnumber
MacName="${extensionBU}${IDNumber}"

if [[ -z ${MacName} ]];then
	echo "One or more parameters are missing, exiting."
	exit 2
fi

echo "MacName will be $MacName"
echo "INFO: Resetting Computer Name to ${MacName}"
scutil --set ComputerName "${MacName}"
scutil --set LocalHostName "${MacName}"
scutil --set HostName "${MacName}"
jamf recon
