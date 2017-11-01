use kb_probanno::kb_probannoImpl;

use kb_probanno::kb_probannoServer;
use Plack::Middleware::CrossOrigin;



my @dispatch;

{
    my $obj = kb_probanno::kb_probannoImpl->new;
    push(@dispatch, 'kb_probanno' => $obj);
}


my $server = kb_probanno::kb_probannoServer->new(instance_dispatch => { @dispatch },
				allow_get => 0,
			       );

my $handler = sub { $server->handle_input(@_) };

$handler = Plack::Middleware::CrossOrigin->wrap( $handler, origins => "*", headers => "*");
