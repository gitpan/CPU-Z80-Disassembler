#!perl 

#------------------------------------------------------------------------------
# parse the ZX Spectrum ROM disassembly file
package TestAsm;

use strict;
use warnings;

use Test::More;
use File::Slurp;

use Exporter 'import';
our @EXPORT = (qw( test_assembly lines_equal ));

#------------------------------------------------------------------------------
# try to assemble file to check if the result is the same binary file
sub test_assembly {
	my($asm, $bmk_bin) = @_;
	eval { require CPU::Z80::Assembler };
	if ($@) {
		diag "CPU::Z80::Assembler not found, test_assembly skipped";
		return;
	}
	
	my $bin = CPU::Z80::Assembler::z80asm("#include '$asm'");
	ok $bin eq read_file($bmk_bin, binmode => ':raw'), "$asm assembles to $bmk_bin";
}

#------------------------------------------------------------------------------
# Compare two strings, ignore line-ending differences
sub lines_equal {
	my($a, $b) = @_;
	
	for ($a, $b) {
		s/\r//g;
	}
	my $ok = $a eq $b;
	return $ok;
}
	
1;
