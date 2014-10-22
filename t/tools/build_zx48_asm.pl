#!perl

#------------------------------------------------------------------------------
# $Id: build_zx48_asm.pl,v 1.1 2010/11/21 22:08:26 Paulo Exp $
# Convert the disassembly zx48.asm into a format to be compared to the output
# of the disassembler
#------------------------------------------------------------------------------

use strict;
use warnings;

use File::Basename;

BEGIN { use lib 't/tools' }
use Parsezx48;

@ARGV==2 or die "Usage: ",basename($0)," INPUT_ASM OUTPUT_ASM\n";
my($input, $output) = @ARGV;

my $dis = Parsezx48->new($input);
$dis->write($output);
print "Created $output\n";
