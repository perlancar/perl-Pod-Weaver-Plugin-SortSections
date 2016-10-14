package Pod::Weaver::Plugin::SortSections;

# DATE
# VERSION

use 5.010001;
use Moose;

with 'Pod::Weaver::Role::Finalizer';
with 'Pod::Weaver::Role::SortSections';

use namespace::autoclean;

has section => (
    is => 'rw',
);

sub mvp_multivalue_args { qw(section) }

sub finalize_document {
    my ($self, $document, $input) = @_;

    my $spec = [];
    for my $section (@{ $self->section // [] }) {
        if ($section =~ m#\A/.*/\z#) {
            $section = qr/$section/;
        }
        push @$spec, $section;
    }

    $self->sort_sections($document, $spec);
}

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Sort POD sections

=for Pod::Coverage ^(finalize_document)$

=head1 SYNOPSIS

In your F<weaver.ini>:

 [-SortSections]
 section=NAME
 section=VERSION
 section=SYNOPSIS
 section=DESCRIPTION
 ; put everything else here
 section=/./
 section=FUNCTIONS
 section=EXPORTS
 section=ATTRIBUTES
 section=METHODS
 section=ENVIRONMENT
 section=FILES
 section=HOMEPAGE
 section=SOURCE
 section=BUGS
 section=SEE ALSO
 section=AUTHOR
 section=COPYRIGHT AND LICENSE


=head1 DESCRIPTION

This plugin lets you sort POD sections.


=head1 SEE ALSO

L<Pod::Weaver::Role::SortSections>
