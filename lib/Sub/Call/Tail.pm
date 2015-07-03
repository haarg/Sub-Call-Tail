package Sub::Call::Tail;
# ABSTRACT: Tail calls for subroutines and methods

use strict;
use warnings;

require 5.008001;
use parent qw(Exporter DynaLoader);
use B::Hooks::OP::Check::EntersubForCV;

our $VERSION = '0.07';

our @EXPORT = our @EXPORT_OK = qw(tail);
our %EXPORT_TAGS = ( all => \@EXPORT_OK );

__PACKAGE__->bootstrap($VERSION);

pop our @ISA;

# ex: set sw=4 et:

__PACKAGE__

__END__

=pod

=head1 SYNOPSIS

    use Sub::Call::Tail;

    # instead of @_ = ( $object, @args ); goto $object->can("method")
    tail $object->method(@args);

    # instead of @_ = @blah; goto &foo
    tail foo(@blah);

=head1 DESCRIPTION

This module provides a C<tail> modifier for subroutine and method calls that
will cause the invocation to have the same semantics as C<goto &sub>.

When the C<tail> modifier is compiled the inner subroutine call is transformed
at compile time into a goto.

=head1 USAGE WARNING

<B>WARNING! The author does not endorse using this module for anything real.
It was written primarily to demonstrate that such quackery can be achieved.
Use at your own risk!

=head1 SEE ALSO

L<B::Hooks::OP::Check::EntersubForCV>

L<CPS>

=cut
