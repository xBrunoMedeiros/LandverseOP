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
		'01D5' => ['npc_talk_text', 'v a4 a*',              [qw(len ID text)]],
	);


	$self->{packet_list}{$_} = $packets{$_} for keys %packets;

	my %handlers = qw(
	);

	return $self;
}

sub reconstruct_npc_talk_text() {
	my ( $self, $args ) = @_;
	$args->{len} -= 1;
}

1;
