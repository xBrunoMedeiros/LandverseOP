package Network::Receive::Landverse;
use strict;
use base qw(Network::Receive::kRO::RagexeRE_2021_11_03);
use Globals qw($char $messageSender);
use I18N qw(bytesToString);
use Log qw(debug);

sub new {
	my ( $class ) = @_;
	my $self = $class->SUPER::new( @_ );

	my %packets = (

	);

	$self->{packet_list}{$_} = $packets{$_} for keys %packets;

	my %handlers = qw(
	);

	$self->{packet_lut}{$_} = $handlers{$_} for keys %handlers;

	return $self;
}

1;
