use strict;
use warnings;

use lib 'inc';
use ExtUtils::MakeMaker::Dist::Zilla::Develop;

use ExtUtils::Depends 0.302;
my $pkg = ExtUtils::Depends->new('Sub::Call::Tail' => 'B::Hooks::OP::Check::EntersubForCV');

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'Sub::Call::Tail',
    VERSION_FROM => 'lib/Sub/Call/Tail.pm',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
    NORECURS => 1,
    $pkg->get_makefile_vars,
    DL_FUNCS => { 'Sub::Call::Tail' => [] },
);

use Devel::PPPort;
Devel::PPPort::WriteFile();
system("$^X ppport.h --compat-version=5.008001 --quiet *.xs");
