/*
A KBase module: kb_probanno
This sample module contains one small method - filter_contigs.
*/

module kb_probanno {

    typedef structure {
        string genome_name;
        string genome_ref;
        string template_id;
        string workspace;
    } probAnnoInputParams;



	   typedef structure {
        string report_name;
        string report_ref;
	 }probAnnoOutputPrams;

    funcdef runProbAnno(probAnnoInputParams params)
        returns (probAnnoOutputPrams output) authentication required;
};
