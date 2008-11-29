NTPd servers always give away information about the OS they are running under. 
This seems to be a reliable and simple method of remote OS fingerprinting. 
Sometimes the output is limited:

$ perl ntp.pl -t cisco2600
ntp-fingerprint.pl, , v 0.1
************* NTP server found at host 192.168.66.202 *******
#It was possible to gather the following information        #
#from the remote NTP host 192.168.66.202                    #
# Operating system: cisco                                   #
*************************************************************

But sometimes it's not:
$ perl ntp.pl -t pingo
ntp-fingerprint.pl, , v 0.1
************* NTP server found at host pingo ********************************
#It was possible to gather the following information                        #
#from the remote NTP host pingo                                             #
# NTP daemon:ôoversion=ntpd 4.2.0@1.1161-r Sun Nov  7 22:50:28 GMT 2004 (1) #
# Processor:i686                                                            #
# Operating system:Linux/2.6.10-gentoo-r5                                   #
*****************************************************************************
So, it is useful to have a utility to query NTPd for OS versions. 
