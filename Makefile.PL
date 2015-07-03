use strict;
use warnings;

# these bits are exactly the same as the original code from Module::Install
# In the future we will probably want to switch to ExtUtils::HasCompiler.
unless ( can_cc() ) {
    print "Unresolvable missing external dependency.\n";
    print "This package requires a C compiler.\n";
    print STDERR "NA: Unable to build distribution on this platform.\n";
    exit(0);
}

sub can_cc {
    my @chunks = split(/ /, $Config::Config{cc}) or return;
    # $Config{cc} may contain args; try to find out the program part
    while (@chunks) {
        return can_run("@chunks") || (pop(@chunks), next);
    }
    return;
}

sub can_run {
    my ($cmd) = @_;
    my $_cmd = $cmd;
    return $_cmd if (-x $_cmd or $_cmd = MM->maybe_command($_cmd));
    for my $dir ((split /$Config::Config{path_sep}/, $ENV{PATH}), '.') {
        next if $dir eq '';
        require File::Spec;
        my $abs = File::Spec->catfile($dir, $cmd);
        return $abs if (-x $abs or $abs = MM->maybe_command($abs));
    }
    return;
}

use ExtUtils::Depends 0.302;
my $pkg = ExtUtils::Depends->new('Sub::Call::Tail' => 'B::Hooks::OP::Check::EntersubForCV');

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'Sub::Call::Tail',
    VERSION_FROM => 'lib/Sub/Call/Tail.pm',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
    $pkg->get_makefile_vars,
    DL_FUNCS => { 'Sub::Call::Tail' => [] },
);
