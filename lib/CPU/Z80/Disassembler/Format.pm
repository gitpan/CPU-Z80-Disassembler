# $Id: Format.pm,v 1.4 2011/03/24 16:46:11 Paulo Exp $

package CPU::Z80::Disassembler::Format;

#------------------------------------------------------------------------------

=head1 NAME

CPU::Z80::Disassembler::Format - Format output of disassembler

=cut

#------------------------------------------------------------------------------

use strict;
use warnings;

our $VERSION = '0.04';

#------------------------------------------------------------------------------

=head1 SYNOPSYS

  use CPU::Z80::Disassembler::Format;
  print format_hex($x), format_hex2($x), format_hex4($x); format_bin8($x);
  print format_dis($x), format_str($x);

=head1 DESCRIPTION

Exports functions to format output values in the disassembler listing.

=head1 EXPORTS

Exports all functions by default.

=head1 FUNCTIONS

=cut
#------------------------------------------------------------------------------
use Exporter 'import';
our @EXPORT = qw( format_hex format_hex2 format_hex4 
				  format_bin8
				  format_dis format_str );
#------------------------------------------------------------------------------

=head2 format_hex

Returns the string representation of a value in hexadecimal..

=cut

#------------------------------------------------------------------------------
sub format_hex { 
	$_[0] < 0 ? sprintf("-0x%02X", -$_[0]) : sprintf("0x%02X", $_[0]);
}
#------------------------------------------------------------------------------

=head2 format_hex2

Returns the string representation of a byte in hexadecimal as 0xHH.

=cut

#------------------------------------------------------------------------------
sub format_hex2 { 
	sprintf("0x%02X", $_[0] & 0xFF) 
}
#------------------------------------------------------------------------------

=head2 format_hex4

Returns the string representation of a word in hexadecimal as 0xHHHH.

=cut

#------------------------------------------------------------------------------
sub format_hex4 { 
	sprintf("0x%04X", $_[0] & 0xFFFF) 
}
#------------------------------------------------------------------------------

=head2 format_bin8

Returns the string representation of a word in binary as 0b01010101.

=cut

#------------------------------------------------------------------------------
sub format_bin8 {
	my($val) = @_;

	my $sign = '';
	if ($val < 0) {
		$val = -$val;
		$sign = '-';
	}

	my $digits = '';
	while ($val != 0 || length($digits) < 8) {
		$digits = (($val & 1) ? '1' : '0') . $digits;
		$val >>= 1;
	}
	
	return $sign.'0b'.$digits;
}
#------------------------------------------------------------------------------

=head2 format_dis

Returns the string representation of a signed byte in decimal as +0xHH, -0xHH or
empty string for zero.

=cut

#------------------------------------------------------------------------------
sub format_dis {
	my($arg) = @_;
	$arg < 0 ? '-'.format_hex(-$arg) : 
	$arg > 0 ? '+'.format_hex( $arg) : 
	''; 
}
#------------------------------------------------------------------------------

=head2 format_str

Returns the string representation of an assembly string: single-quted, all
single-quotes inside are doubled.

=cut

#------------------------------------------------------------------------------
sub format_str {
	my($str) = @_;
	$str =~ s/'/''/g;
	return "'$str'";
}
#------------------------------------------------------------------------------

=head1 BUGS, FEEDBACK, AUTHORS, COPYRIGHT and LICENCE

See L<CPU::Z80::Disassembler|CPU::Z80::Disassembler>.

=cut

1;
