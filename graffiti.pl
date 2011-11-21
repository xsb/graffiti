#!/usr/bin/perl -w
# author: xavi s.b. (xsb@interrupciones.net) 2009-2010

use strict;
use feature "switch";
use Getopt::Long;
 
my ( $destination, $text, $agent, $repeats, $verbose, $background, $foreground );

my $result = GetOptions(
  'd=s'  => \$destination,
  't=s'  => \$text,
  'a=s'  => \$agent,
  'bg=s' => \$background,
  'fg=s' => \$foreground,
  'r=i'  => \$repeats,
  'v'    => \$verbose,
);

sub print_usage {
  print "USAGE:            \n";
  print "  -d  destination \n";
  print "  -t  text        \n";
  print "  -a  user-agent  \n";
  print "  -bg background  \n";
  print "  -fg foreground  \n";
  print "  -r  repeats     \n";
  print "  -v  verbose     \n";
  print "\n";
  print "EXAMPLES:         \n";
  print "  ./graffiti.pl -d www.example.com -t \"funny text\"\n";
  print "  ./graffiti.pl -v -d localhost -t \"testing graffiti\" -r 2\n";
  print "  ./graffiti.pl -d 1.2.3.4 -t \"last example\" -bg . -fg \"#\" -a \"Mozilla\\ Firefox\"\n";
  print "\n";
}

my @a = ("------------NNN---------------------",
         "----------NNNNNNN----NN-------------",
         "---------NNNNNNNNN--NNNN------------",
         "---------NN-----NN---N-NN-----------",
         "---------N------NN------N-----------",
         "---------NN-----N------NN-----------",
         "---------NNNNNNNNNNNNNNN------------",
         "---------NNNNNNNNNNNNNN-------------",
         "---------N--------------------------",
         "------------------------------------");
 
my @b = ("---------N-------------------------N",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------NN------------N------------",
         "---------N-------------NN-----------",
         "---------N-------------NN-----------",
         "---------NNNNN------NNNN------------",
         "----------NNNNNNNNNNNNN-------------",
         "------------NNNNNNNNN---------------",
         "--------------NNNNN-----------------",
         "------------------------------------");
 
my @c = ("-----------NNNNNNNNNNN--------------",
         "----------NNNNNNNNNNNNNN------------",
         "---------NN-----------NN------------",
         "---------N--------------N-----------",
         "---------N--------------N-----------",
         "---------N-------------NN-----------",
         "----------N----------NNN------------",
         "-----------NN-----------------------",
         "------------------------------------");
 
my @d = ("-------------NNNNNNN----------------",
         "-----------NNNNNNNNNNNN-------------",
         "---------NNNNNNNNNNNNNNN------------",
         "---------NN-----------NNN-----------",
         "---------N-------------NN-----------",
         "---------N-------------NN-----------",
         "----------NN----------N------------N",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------N--------------------------",
         "------------------------------------");
 
my @e = ("--------------NNNNN-----------------",
         "-----------NNNNNNNNNNN--------------",
         "----------NNNNNNNNNNNNNN------------",
         "---------NN-----N-----NN------------",
         "---------N------N-------N-----------",
         "---------N------N-------N-----------",
         "---------N------N------NN-----------",
         "----------N-----NNNNNNNN------------",
         "-----------NN---NNNNNN--------------",
         "----------------NNN-----------------",
         "------------------------------------");
 
my @f = ("------------------------N-----------",
         "---------NNNNNNNNNNNNNNNNNNNNNNN----",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNN-",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "------------------------N------NN--N",
         "------------------------N-----NNNNNN",
         "------------------------------NNNNN-",
         "------------------------------------");
 
my @g = ("---NNN-----------NNNN---------------",
         "-NN---NN-NN----NNNNNNNN-------------",
         "NN------NNNNN-NNNNNNNNNN------------",
         "N------NNNNN-NNN------NNN-----------",
         "N------NNNN--N----------N-----------",
         "NN----NNNN---NN--------NN-----------",
         "NN----NNN----NNNN----NNNN-----------",
         "-NNNNNNNN------NNNNNNNNN------------",
         "--NNNNN---------NNNNNN--NNN---------",
         "-------------------------NN---------",
         "------------------------------------");
 
my @h = ("---------N-------------------------N",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "-----------------------N------------",
         "-----------------------NN-----------",
         "-----------------------NN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNN------------",
         "---------NNNNNNNNNNNN---------------",
         "------------------------------------");
 
my @i = ("---------N--------------N-----------",
         "---------NNNNNNNNNNNNNNNN----NNNN---",
         "---------NNNNNNNNNNNNNNNN----NNNN---",
         "---------NNNNNNNNNNNNNNNN-----NN----",
         "------------------------------------");
 
my @j = ("--N---------------------------------",
         "NNNN--------------------------------",
         "NNNN--------------------------------",
         "N-----------------------------------",
         "NNNNNNNNNNNNNNNNNNNNNNNNN----NNN----",
         "-NNNNNNNNNNNNNNNNNNNNNNNN----NNNN---",
         "----NNNNNNNNNNNNNNNNNNNNN----NNN----",
         "------------------------------------");
 
my @k = ("---------N-------------------------N",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------------NNNNNN---------------",
         "-------------NNNNNN-NN--------------",
         "---------NNNNNNNN-----NNN-----------",
         "---------NNNNN---------NN-----------",
         "---------NNN------------------------",
         "---------N--------------------------",
         "------------------------------------");
 
my @l = ("---------N-------------------------N",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "---------NNNNNNNNNNNNNNNNNNNNNNNNNNN",
         "------------------------------------");
 
my @m = ("---------N--------------N-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "-----------------------N------------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNN-------------",
         "----------------------NN------------",
         "---------N------------NNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNN------------",
         "---------N--------------------------",
         "------------------------------------");
 
my @n = ("---------N--------------N-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "-----------------------N------------",
         "-----------------------NN-----------",
         "-----------------------NN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNN------------",
         "---------NNNNNNNNNNNN---------------",
         "------------------------------------");
 
my @o = ("--------------NNNNN-----------------",
         "-----------NNNNNNNNNNN--------------",
         "----------NNNNNNNNNNNNNN------------",
         "---------NN-----------NN------------",
         "---------N--------------N-----------",
         "---------N--------------N-----------",
         "---------N-------------NN-----------",
         "---------NNNN-------NNNN------------",
         "-----------NNNNNNNNNNNN-------------",
         "-------------NNNNNNNN---------------",
         "------------------------------------");
 
my @p = ("N-----------------------N-----------",
         "NNNNNNNNNNNNNNNNNNNNNNNNN-----------",
         "NNNNNNNNNNNNNNNNNNNNNNNNN-----------",
         "NNNNNNNNNNNNNNNNNNNNNNNNN-----------",
         "---------NN------------N------------",
         "---------N-------------NN-----------",
         "---------N-------------NN-----------",
         "---------NNN---------NNNN-----------",
         "----------NNNNNNNNNNNNNN------------",
         "-----------NNNNNNNNNNN--------------",
         "------------------------------------");
 
my @q = ("-------------NNNNNNN----------------",
         "-----------NNNNNNNNNNNN-------------",
         "---------NNNNNNNNNNNNNNN------------",
         "---------NN-----------NNN-----------",
         "---------N-------------NN-----------",
         "---------N-------------NN-----------",
         "----------NN----------N-------------",
         "NNNNNNNNNNNNNNNNNNNNNNNNN-----------",
         "NNNNNNNNNNNNNNNNNNNNNNNNN-----------",
         "N-----------------------N-----------",
         "------------------------------------");
 
my @r = ("---------N--------------N-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------------------NN-------------",
         "----------------------NN------------",
         "--------------------NNNNN-----------",
         "-------------------NNNNNN-----------",
         "-------------------NNNNN------------",
         "------------------------------------");
 
my @s = ("---------NNNN------NN---------------",
         "---------NNNN----NNNNNN-------------",
         "---------NN-----NNNNNNNN------------",
         "---------N-----NNNN-----N-----------",
         "---------N-----NNNN-----N-----------",
         "---------N-----NNNN----NN-----------",
         "---------N----NNNN----NN------------",
         "----------NNNNNNNN---NNNN-----------",
         "-----------NNNNN--------------------",
         "------------------------------------");
 
my @t = ("------------------------N-----------",
         "------------NNNNNNNNNNNNNNNNN-------",
         "---------NNNNNNNNNNNNNNNNNNNN-------",
         "---------NNNNNNNNNNNNNNNNNNNN-------",
         "---------NN-------------N-----------",
         "---------NN-------------------------",
         "-----------N------------------------",
         "------------------------------------");
 
my @u = ("------------------------N-----------",
         "-----------NNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NN-------------------------",
         "---------NN-------------------------",
         "----------N-------------------------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "---------NNNNNNNNNNNNNNNN-----------",
         "------------------------------------");
 
my @v = ("------------------------N-----------",
         "----------------------NNN-----------",
         "------------------NNNNNNN-----------",
         "---------------NNNNNNNNNN-----------",
         "----------NNNNNNNNNN----------------",
         "---------NNNNNNNN-------------------",
         "-------------NNN--------------------",
         "-----------------NNNN---N-----------",
         "---------------------NNNN-----------",
         "------------------------N-----------",
         "------------------------------------");
 
my @w = ("------------------------N-----------",
         "----------------------NNN-----------",
         "------------------NNNNNNN-----------",
         "---------------NNNNNNNNNN-----------",
         "----------NNNNNNNNNN----------------",
         "---------NNNNNNNN-------------------",
         "-------------NNN--------------------",
         "----------NNNNNNNNNN----------------",
         "---------NNNNNNNN-------------------",
         "-------------NNN--------------------",
         "-----------------NNNN---N-----------",
         "---------------------NNNN-----------",
         "------------------------N-----------",
         "------------------------------------");
 
my @x = ("---------N--------------N-----------",
         "---------N-------------NN-----------",
         "---------NNN--------NNNNN-----------",
         "---------N-NNN----NNNNNNN-----------",
         "--------------NNNNNNNN--N-----------",
         "-------------NNNNNNN----------------",
         "---------N-NNNNNNNNN----------------",
         "---------NNNNNN-----NNN-N-----------",
         "---------NNN----------NNN-----------",
         "---------N--------------N-----------",
         "------------------------------------");
 
my @y = ("-N----------------------N-----------",
         "NNN-------------------NNN-----------",
         "NNN---------------NNNNNNN-----------",
         "--NNN----------NNNNNNNNNN-----------",
         "------NNNNNNNNNNNNNN----------------",
         "---------NNNNNNNN-------------------",
         "-------------NNN--------------------",
         "-----------------NNNN---N-----------",
         "---------------------NNNN-----------",
         "------------------------N-----------",
         "------------------------------------");
 
my @z = ("---------------------NNNN-----------",
         "---------NN-----------NNN-----------",
         "---------NNNNN---------NN-----------",
         "---------NNNNNNN--------N-----------",
         "---------N--NNNNNNN-----N-----------",
         "---------N----NNNNNNNN--N-----------",
         "---------N-------NNNNNNNN-----------",
         "---------N----------NNNNN-----------",
         "---------NN------------NN-----------",
         "---------NNNN-----------------------",
         "------------------------------------");
 
my @space = ("------------------------------------",
             "------------------------------------",
             "------------------------------------",
             "------------------------------------",
             "------------------------------------",
             "------------------------------------");
 
sub send_text {
 
  # text to lowercase
  my $text = lc($_[0]);
 
  foreach (0..length($text)-1) {

    # next char
    given (substr($text,$_,1)) {

      when (/a/) { send_character(@a); }
      when (/b/) { send_character(@b); }
      when (/c/) { send_character(@c); }
      when (/d/) { send_character(@d); }
      when (/e/) { send_character(@e); }
      when (/f/) { send_character(@f); }
      when (/g/) { send_character(@g); }
      when (/h/) { send_character(@h); }
      when (/i/) { send_character(@i); }
      when (/j/) { send_character(@j); }
      when (/k/) { send_character(@k); }
      when (/l/) { send_character(@l); }
      when (/m/) { send_character(@m); }
      when (/n/) { send_character(@n); }
      when (/o/) { send_character(@o); }
      when (/p/) { send_character(@p); }
      when (/q/) { send_character(@q); }
      when (/r/) { send_character(@r); }
      when (/s/) { send_character(@s); }
      when (/t/) { send_character(@t); }
      when (/u/) { send_character(@u); }
      when (/v/) { send_character(@v); }
      when (/w/) { send_character(@w); }
      when (/x/) { send_character(@x); }
      when (/y/) { send_character(@y); }
      when (/z/) { send_character(@z); }
      when (/ /) { send_character(@space); }
      default {
        print " >>>  Character '$_' not supported   <<<\n";
      }
    }
  }
}
 
sub send_character {

  foreach (@_) {
    # change theme :)
    s/-/$background/g if $background;
    s/N/$foreground/g if $foreground;

    # I love 404 errors (but would be better/faster without system curl)
    system "curl $destination/$_ -A $agent -I -o /dev/null -s";

    # print line to STDOUT in case of -v
    print "$_\n" if ($verbose);
  }
}
 
#
# Program starts here
#
 
unless ($destination) {
  print "\n  [ERROR]: destination host must be specified\n\n";
  print_usage;
  exit 0;
}
 
unless ($text) {
  print "\n  [ERROR]: text must be specified\n\n";
  print_usage;
  exit 0;
}
 
unless ($agent) {
  $agent = "graffiti";
}

unless ($repeats) {
  $repeats = 1;
}

if ($background) {
  # must be one-character
  $background = substr($background,0,1);
}

if ($foreground) {
  # must be one-character
  $foreground = substr($foreground,0,1);
}

print "Destination ----> $destination   \n";
print "Text -----------> $text          \n";
print "User Agent -----> $agent         \n";
print "Background -----> $background    \n" if $background;
print "Foreground -----> $foreground    \n" if $foreground;
print "Repeats    -----> $repeats     \n\n";
print " ** Use -v to switch verbose mode on **\n\n" unless $verbose;

 
for (1..$repeats) {
  send_text($text);
}

