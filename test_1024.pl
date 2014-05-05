#!/usr/bin/perl
`make &> compile_results1`;
`grep -B 7 "matmul-1024-opt\.c:.*" compile_results1 > compile_results2`;
`grep -E \'matmul-1024-opt\.c:.*|  .*|^$\' compile_results2 > compile_results3`;
`awk \'FNR>7\' compile_results3 > compile_results`;
open( FILE, "< path" ) or die "Can't open path : $!";
my $path = <FILE>;
chomp $path;
close FILE;
my $results_filename = ($path . "matmul-1024-results");
my $opt_results_filename = ($path . "matmul-1024-opt-results");
my $difference_filename = ($path . "matmul-1024-results");
`rm -f  difference $opt_results_filename matmul-1024-opt-time compile_results1 compile_results2 compile_results3`;
print "===Compile summary===\n";
open( FILE, "< compile_results" ) or die "Can't open compile_results : $!";
while( <FILE> ) {
        print;
}
close FILE;
print "\n=====Unoptimized=====\nTime:                    ";
open( FILE, "< matmul-1024-time" ) or die "Can't open matmul-1024-time : $!";
while( <FILE> ) {
        print;
}
close FILE;
print "======Optimized======\nTime:                    ";
`./matmul-1024-opt 1> $opt_results_filename 2> matmul-1024-opt-time`;
`diff $results_filename $opt_results_filename > difference`;
open( FILE, "< matmul-1024-opt-time" ) or die "Can't open matmul-1024-opt-time : $!";
while( <FILE> ) {
        print;
}
close FILE;
print "=======Summary=======\nDifference:              ";
print -s 'difference';
my $time1;
my $time2;
open( FILE, "< matmul-1024-time" ) or die "Can't open matmul-1024-time : $!";
while( <FILE> ) {
        chomp;
	($time1) = split /s/;
	last;
}
open( FILE, "< matmul-1024-opt-time" ) or die "Can't open matmul-1024-opt-time : $!";
while( <FILE> ) {
        chomp;
	($time2) = split /s/;
	last;
}
my $diff = $time1 - $time2;
print "\nImprovement:             ";
print $diff;
print "s\n";

