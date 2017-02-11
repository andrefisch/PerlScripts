# VIDEOS MUST BE IN FOLLOWING FORMAT:
# 25 L2 Dolniceanu ROU v Yakimenko RUS
#!/usr/bin/perl

use strict;
#use warnings;

my $path = "";
$path = shift;
print "$path/vidlist.txt\n";

open DICT, "< C:/Users/anfis/OneDrive/Documents/Perl/fencers.txt" or die;
open COUNTRIES, "< C:/Users/anfis/OneDrive/Documents/Perl/countries.txt" or die;
open VIDLIST, "< $path/vidlist.txt" or die;
open INFO, "> $path/info2.txt" or die;


print "What city does this tournament take place in?: ";
# 1 : set city tournament is in
my $city = <>;	    	#argument is passed in when script starts
print "What is the name of the tournament?: ";
# 2 : set name of tournament
my $tournament = <>;	#input this when running the script
print "What type of tournament is this?: ";
# 3 : set type of tournament
my $type = <>;	    	#input this when running the script
print "What gender is fencing?: ";
# 3 : set type of tournament
my $gender = <>;		#input this when running the script
print "What weapon is fencing?: ";
# 3 : set type of tournament
my $fencer = <>;		#input this when running the script

my $country = "";	    #from countries dictionary using city
my $round = "";		    #from list of files in directory
my $right_fencer = ""; 	#from fencers dictionary using fencers last name
my $left_fencer = ""; 	#from fencers dictionary using fencers last name

chomp($type);
chomp($city);
chomp($tournament);

print "\n";

my $line;

#import the fencers in dictionary form
my %fencers;
while ($line=<DICT>) {
	chomp($line);
	(my $word1,my $word2) = split /;/, $line;
	$fencers{$word1} = $word2;
}

#import the tournaments in dictionary form
my %tournaments;
while ($line=<COUNTRIES>) {
	chomp($line);
	(my $word1,my $word2) = split /,/, $line;
	$tournaments{$word1} = $word2;
}

# 4 : set country
$country = $tournaments{$city};
chomp($country);

print "\n\n$country\n\n\n";

#import the video list as an array
#only import .avi videos
my @vidlist;
my $line_num = 0;
while ($line=<VIDLIST>) {
	if (($line =~ /\.(avi|mp4)$/) == 1)
	{
		#only add to this array and increment the line number if
		#it is an avi file
		$vidlist[$line_num] = $line;
		$line_num++;
	}
}

print "===========================\n";
print "$line_num videos in this folder.\n";

#now put the data from the vidlist into the info string
my $size = @vidlist;
my @words;
for (my $i = 0; $i < $size; $i++)
{
	#split the string
	@words = split(" ", $vidlist[$i]);

	#5 : set round number : $round = part 1
	$round = $words[1];

	#6 : set fencer on right : $right_fencer = part 2
	$right_fencer = $fencers{$words[2]};
    chomp($right_fencer);
    #$right_fencer = chomp ($right_fencer);
	print "$right_fencer\n";

	#7 : set_fencer on left : $left_fencer = part 5
	$left_fencer = $fencers{$words[5]};
    chomp($left_fencer);
    #$left_fencer = chomp ($left_fencer);
	print "$left_fencer\n";

	#other information is irrelevant so we print now
	# Title info for the videos
	#but first we need to separate the .avi from the fencers country
	my $last = "";
	if (($words[6] =~ /\./) == 1)
	{
		print "Matched: <$&>\n";
		$last = $`;
	}
	elsif (($words[7] =~ /Partial/) == 1 )
	{
		$last = $words[6];
	}
	else
	{
		$last = $words[6];
	}

	# Title info for the videos
	my $title = "$city 2017 - $round - $words[2] $words[3] v $words[5] $last\n\n";

	# Video info for the videos
	my $info = "http://www.facebook.com/pages/CyrusofChaos\nhttps://twitter.com/CyrusofChaos\nhttps://plus.google.com/105213664966119536022/videos\nDogecoin: DCCwW9FrRac7PXLuE3UTonuhPBo9k8GKJ3\n\nThis is a bout in the round of $round at the $tournament, a $gender\'s $weapon $type in $city, $country. $right_fencer is on the right and $left_fencer is on the left.\n\n\n";

	print INFO "$title";
	print INFO "$info";

	print "$title\n";
}

print "Just another Perl hacker...\n";


















































