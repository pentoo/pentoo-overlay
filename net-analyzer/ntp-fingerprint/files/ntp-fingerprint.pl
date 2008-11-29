#!/usr/bin/perl
use IO::Socket;
use Net::hostent;
use Getopt::Std;

my $VERSION = "0.1";

sub usage { # print a short 'usage` message and exit
  print "usage: perl $0 -t <timeserver>\n";
  print"###############################################################\n";
  print"#   NTP finger version $VERSION                                    #\n";
  print"#   Becase we need it...                                      #\n";
  print"#   http://www.arhont.com/index-5.html                        #\n";  
  print"###############################################################\n";
  print"\n";
  


  exit;
}

use vars qw($opt_h $opt_t); # command line options


print "$0, $PgmName, V $VERSION \n";
  # handle the commandline options
  getopts('ht');            # look for -h and -t
  $opt_h && usage;          # -h print usage message and exit
  
  (!$ARGV[0]) && usage;     # no server: print usage message and exit

  my $server = $ARGV[0];
  my $serverIPv4 ="";
  if (gethostbyname($server)) {
    $serverIPv4 = sprintf("%d.%d.%d.%d",unpack("C4",gethostbyname($server)));
  }

my $timeout = 2;



my $ntp_msg;  # NTP message according to NTP/SNTP protocol specification

 sub get_ntp {
 	
  # open the connection to the ntp server,
  # prepare the ntp request packet
  # send and receive

    my ($remote);
    my $ntp_msg;

$ntp_msg = pack "C*", (0x16, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,0x00, 0x00, 0x00, 0x00); 

    # open the connection to the ntp server
    $remote = IO::Socket::INET -> new(Proto => "udp", PeerAddr => $server,
                                      PeerPort => 123,
                                      Timeout => $timeout)
                                  or die "Can't connect to \"$server\"\n";
                    
# send the ntp-request to the server
    $remote -> send($ntp_msg) or return undef;
        

# receive the ntp-message from the server

       sysread( $remote, $ntp_msg, 4096 ) or 
       do { print "Receive error from $server \n"; exit};
       close $remote;
print "#It was possible to gather the following information\n#from the remote NTP host $server #\n ";
        $ntp_msg =~ s/^\s+//;  
        $ntp_msg =~ s/\"//g;               
 @fields = split(/,/, $ntp_msg);
 foreach (@fields) {
 	if ($_=~/version/) {
 	$_=~s/mversion=//i;
 	$_=~ s/^\s+//;
    print "# NTP daemon:$_ #\n";
 	}
 	if ($_=~/processor/) {
    $_=~s/processor=//i;
 	$_=~ s/^\s+//;
    print "# Processor:$_ #\n";
 	}
 	if ($_=~/system/) {
 	$_=~s/system=//i;
 	$_=~ s/^\s+//;
    print "# Operating system:$_ #\n";
 	}
   }

 }


sub ntp_installed
    {
my $ndata;
my $timeout = 2;

    	
$ndata = pack "C*",(0xDB, 0x00, 0x04, 0xFA, 0x00, 0x01,
    	  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
		  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		  0x00, 0x00, 0xBE, 0x78, 0x2F, 0x1D, 0x19, 0xBA,
		  0x00, 0x00);
$remote = IO::Socket::INET -> new(Proto => "udp", PeerAddr => $server,
                                      PeerPort => 123,
                                      Timeout => $timeout);
                                 
                                      
                    if ($remote)
                    {
# send the ntp-request to the server
    $remote -> send($ndata);
        
     
# receive the ntp-message from the server
$SIG{ALRM} = \&timed_out;
  alarm ($timeout);
 eval { $remote -> recv($ndata, length(4096),0);
              close $remote;
              alarm (0);
              } 
             
             }
         if ($ndata)
		  { 
		   
	       return (1);
                   
        
}
return (0);
}            

       

sub get {
my $nlist;
if (ntp_installed)
{
print "************* NTP server found at host $server **************\n";	
 get_ntp;
print "*************************************************************\n";
}

}



$opt_t && get ;
