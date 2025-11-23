package Network::Send::Landverse;
use strict;
use base    qw(Network::Send::kRO::RagexeRE_2021_11_03);
use Globals qw($net %config);
use Utils   qw(getTickCount);
use Log     qw(debug);

sub new {
	my ( $class ) = @_;
	my $self = $class->SUPER::new( @_ );

	my %packets = (
	);

	$self->{packet_list}{$_} = $packets{$_} for keys %packets;

	my %handlers = qw(
	);

	return $self;
}

1;
