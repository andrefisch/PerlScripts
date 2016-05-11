#!/usr/bin/env perl
do
{
    print(":");
    $_x = <>;
    chomp $_x;
    print(eval($_x)."\n")
}
while($_x ne "q")
