package kb_probanno::kb_probannoImpl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org
our $VERSION = '0.0.1';
our $GIT_URL = 'https://github.com/janakagithub/kb_probanno.git';
our $GIT_COMMIT_HASH = '35d83c6a73ac32c602395697797562896590144a';

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
use UUID::Random;
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
	report_name has a value which is a string
	report_ref has a value which is a string

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
	report_name has a value which is a string
	report_ref has a value which is a string


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


    system ("/kb/dev_container/modules/ProbAnno-Standalone scripts/ms-probanno-standalone.py genomes/1415167.3.PATRIC.faa templates/GramNegative.json /kb/module/work/tmp/1415167.3.probanno.out");


    my $reporter_string = "ProbAnno output created and stored in /kb/module/work/tmp/1415167.3.probanno.out";

    print "$reporter_string\n";

    my $reportHandle = new KBaseReport::KBaseReportClient( $self->{'callbackURL'},
                                                            ( 'service_version' => 'dev',
                                                              'async_version' => 'dev',
                                                            )
                                                          );

    my $file_path1= {
        path => '/kb/module/work/tmp/1415167.3.probanno.out',
        name => 'probanno_outputFile',
        description => 'probanno_outputFile'
    };

    my $uid = UUID::Random::generate;
    my $report_context = {
      message => $reporter_string,
      objects_created => [],
      workspace_name => 'janakakbase:narrative_1509540289573',
      warnings => [],
      html_links => [],
      file_links =>[$file_path1],
      report_object_name => "Report"."ProbAnnoOutput"."-".UUID::Random::generate
    };

    my $report_response;
    eval {
      $report_response = $reportHandle->create_extended_report($report_context);
    };
    if ($@){
      print "Exception message: " . $@->{"message"} . "\n";
      print "JSONRPC code: " . $@->{"code"} . "\n";
      print "Method: " . $@->{"method_name"} . "\n";
      print "Client-side exception:\n";
      print $@;
      print "Server-side exception:\n";
      print $@->{"data"};
      die $@;
    }

    print "Report is generated: name and the ref as follows\n";
    print &Dumper ($report_response);
     my $report_out = {
      report_name => $report_response->{name},
      report_ref => $report_response->{ref}
    };
    return $report_out;

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
report_name has a value which is a string
report_ref has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string


=end text

=back



=cut

1;
