#!/usr/bin/perl

#WordPress Grab Info
#Coded By Mohamed Riahi 08/020/2017
#don't Change my Fucking Rights

#[Detect User]
#[Detect Version]    
#[Detect Theme]  
#[Detect Plugins]

use LWP::UserAgent;
use Term::ANSIColor;
use HTTP::Request::Common qw(GET);
use URI::URL;
use Getopt::Long;
$ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");
$ua->timeout (10);

GetOptions(
	"u=s" => \$site,
);

unless ($site) { help(); }
if ($site) { banner(); }



sub banner() {
print q(
           ____                      ,
          /---.'.__             ____//
               '--.\           /.---'
          _______  \\         //
        /.------.\  \|      .'/  ______
       //  ___  \ \ ||/|\  //  _/_----.\__
      |/  /.-.\  \ \:|< >|// _/.'..\   '--'
         //   \'. | \'.|.'/ /_/ /  \\
        //     \ \_\/" ' ~\-'.-'    \\
       //       '-._| :H: |'-.__     \\
      //           {/'==='\}'-._\     ||
      ||                        \\    \|
      ||                         \\    '
      |/                          \\
                                   ||
        WP Grab Info v2            ||
     Coded BY Mohamed Riahi        \\
                                    '
);
print "  [+] $site\n";
user();
Version();
Theme();
Plugin();
}

sub help() {
print " Usage: perl WP-Grab.pl -u http://website.com/";
}
#################### GET USER ####################
sub user(){
$user = $site . '/?author=1';

$getuser = $ua->get($user)->content;
if($getuser =~/author\/(.*?)\//){
print "  [-] User: $1\n";
}else{
print "  [-] Can't Get Username\n";
}
}

#################### GET VERSION ####################
sub Version(){
$getversion = $ua->get($site)->content;
if($getversion =~/content="WordPress (.*?)"/) {
print "  [-] Version: $1\n";
}else{
print "  [-] Can't Get Version\n";
}
}

#################### GET THEME ####################
sub Theme(){
$getheme = $ua->get($site)->content;
if($getheme =~/\/themes\/(.*?)\//){
print "  [-] Theme: $1\n";
}else{
print "  [-] Can't Get Theme\n";
}
}

#################### GET PLUGINs ####################
sub Plugin(){
$getplugin = $ua->get($site)->content;

my %seen;
while($getplugin =~m/\/wp-content\/plugins\/(.*?)\//g){ 
  $plu=$1;
  next if $seen{$plu}++; # already seen
  print "  [-] Plugin: $plu \n";
}
}
