package Math::Geometry::Planar::GPC::Polygon;
our $VERSION = '0.01';

use 5.006;
use strict;
use warnings;


BEGIN {
	my $dir = __FILE__;
	$dir =~ s#.pm$#/#;
	our $functions = $dir . "functions.c";
	our $include = $dir . "include/";
	# print "functions at begin: $functions\n";
}


our $include;
use Inline (
	C => Config =>
	NAME => 'Math::Geometry::Planar::GPC::Polygon',
	INC => "-I$include",
	VERSION => '0.01',
	# BUILD_NOISY => 1,
	);
our $functions;
#print "functions in: $functions\n";
use Inline C => "$functions";

require Exporter;
our @ISA='Exporter';
our @EXPORT_OK = qw(
	new_gpc
	);

=pod

=head1 NAME

Math::Geometry::Planar::GPC::Polygon - OO wrapper to gpc library

=head1 Status

Brand new and lightly tested.

=head1 AUTHOR

  Eric L. Wilhelm
  ewilhelm at sbcglobal dot net
  http://pages.sbcglobal.net/mycroft/

=head1 Copyright

Copyright 2004 Eric L. Wilhelm

=head1 License

This module and its C source code (functions.c) are freely
redistributable under the GNU general public license (GPL).  See
http://www.gnu.org for details.

The General Polygon Clipping library (gpc.c and gpc.h) is also
distributed under the GPL license.  A copy of these files has been
included with this distribution strictly for convenience purposes.  See
gpc.c for details.  Note that the C library is authored by Alan Murta.

=head1 NO WARRANTY

This code comes with ABSOLUTELY NO WARRANTY of any kind.

=head1 Changes

  0.01 - First public release.

=cut
########################################################################

=head1 Constructors

=head2 new

Traditional constructor, returns a blessed reference to the underlying C struct. 

  use Math::Geometry::Planar::GPC::Polygon;
  my $gpc = Math::Geometry::Planar::GPC::Polygon->new();

=head2 new_gpc

An optionally imported constructor, for those of you who don't like to
type so much.

  use Math::Geometry::Planar::GPC::Polygon qw(new_gpc);
  my $gpc = new_gpc();

=cut
sub new_gpc {
	my $class = __PACKAGE__;
	return(new($class));
} # end subroutine new_gpc definition
########################################################################

=head1 Bound Functions

These are the functions provide by the Inline-C code.

Need to document these.

=cut
########################################################################

=head1 Helper Functions

Pure-perl implementation from here down.

=cut
########################################################################

=head2 as_string

  $gpc->as_string();

=cut
sub as_string {
	my $self = shift;
	my @pgons = $self->get_polygons();
	my @strings;
	foreach my $pgon (@pgons) {
		# print "pgon is $pgon\n";
		# print "@$pgon\n";
		my @pts;
		foreach my $pt (@$pgon) {
			push(@pts, join(", ", map({sprintf("%0.3f", $_)} @$pt)));
		}
		push(@strings, "\t" . join("\n\t", @pts));
	}
	return(join("\n\n", @strings));
} # end subroutine as_string definition
########################################################################
1;
__END__
