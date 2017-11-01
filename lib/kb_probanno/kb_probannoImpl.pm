package kb_probanno::kb_probannoImpl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org 
our $VERSION = '0.0.1';
our $GIT_URL = '';
our $GIT_COMMIT_HASH = '';

=head1 NAME

kb_probanno

=head1 DESCRIPTION

A KBase module: kb_probanno
This sample module contains one small method - filter_contigs.

=cut

#BEGIN_HEADER
use Bio::KBase::AuthToken;
use AssemblyUtil::AssemblyUtilClient;
use KBaseReport::KBaseReportClient;
use Config::IniFiles;
use Bio::SeqIO;
use Data::Dumper;
#END_HEADER

sub new
{
    my($class, @args) = @_;
    my $self = {
    };
    bless $self, $class;
    #BEGIN_CONSTRUCTOR
    
    my $config_file = $ENV{ KB_DEPLOYMENT_CONFIG };
    my $cfg = Config::IniFiles->new(-file=>$config_file);
    my $scratch = $cfg->val('kb_probanno', 'scratch');
    my $callbackURL = $ENV{ SDK_CALLBACK_URL };
    
    $self->{scratch} = $scratch;
    $self->{callbackURL} = $callbackURL;
    
    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



=head2 runProbAnno

  $output = $obj->runProbAnno($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a kb_probanno.probAnnoInputParams
$output is a kb_probanno.probAnnoOutputPrams
probAnnoInputParams is a reference to a hash where the following keys are defined:
	genome_name has a value which is a string
	genome_ref has a value which is a string
	template_id has a value which is a string
	workspace has a value which is a string
probAnnoOutputPrams is a reference to a hash where the following keys are defined:
	probAnno_outputFile has a value which is a string
	model_ref has a value which is a string

</pre>

=end html

=begin text

$params is a kb_probanno.probAnnoInputParams
$output is a kb_probanno.probAnnoOutputPrams
probAnnoInputParams is a reference to a hash where the following keys are defined:
	genome_name has a value which is a string
	genome_ref has a value which is a string
	template_id has a value which is a string
	workspace has a value which is a string
probAnnoOutputPrams is a reference to a hash where the following keys are defined:
	probAnno_outputFile has a value which is a string
	model_ref has a value which is a string


=end text



=item Description



=back

=cut

sub runProbAnno
{
    my $self = shift;
    my($params) = @_;

    my @_bad_arguments;
    (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"params\" (value was \"$params\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to runProbAnno:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'runProbAnno');
    }

    my $ctx = $kb_probanno::kb_probannoServer::CallContext;
    my($output);
    #BEGIN runProbAnno
    #END runProbAnno
    my @_bad_returns;
    (ref($output) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"output\" (value was \"$output\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to runProbAnno:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'runProbAnno');
    }
    return($output);
}




=head2 status 

  $return = $obj->status()

=over 4

=item Parameter and return types

=begin html

<pre>
$return is a string
</pre>

=end html

=begin text

$return is a string

=end text

=item Description

Return the module status. This is a structure including Semantic Versioning number, state and git info.

=back

=cut

sub status {
    my($return);
    #BEGIN_STATUS
    $return = {"state" => "OK", "message" => "", "version" => $VERSION,
               "git_url" => $GIT_URL, "git_commit_hash" => $GIT_COMMIT_HASH};
    #END_STATUS
    return($return);
}

=head1 TYPES



=head2 probAnnoInputParams

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
genome_name has a value which is a string
genome_ref has a value which is a string
template_id has a value which is a string
workspace has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
genome_name has a value which is a string
genome_ref has a value which is a string
template_id has a value which is a string
workspace has a value which is a string


=end text

=back



=head2 probAnnoOutputPrams

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
probAnno_outputFile has a value which is a string
model_ref has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
probAnno_outputFile has a value which is a string
model_ref has a value which is a string


=end text

=back



=cut

1;
