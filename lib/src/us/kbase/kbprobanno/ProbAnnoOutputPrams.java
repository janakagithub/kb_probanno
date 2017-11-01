
package us.kbase.kbprobanno;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: probAnnoOutputPrams</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "probAnno_outputFile",
    "model_ref"
})
public class ProbAnnoOutputPrams {

    @JsonProperty("probAnno_outputFile")
    private String probAnnoOutputFile;
    @JsonProperty("model_ref")
    private String modelRef;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("probAnno_outputFile")
    public String getProbAnnoOutputFile() {
        return probAnnoOutputFile;
    }

    @JsonProperty("probAnno_outputFile")
    public void setProbAnnoOutputFile(String probAnnoOutputFile) {
        this.probAnnoOutputFile = probAnnoOutputFile;
    }

    public ProbAnnoOutputPrams withProbAnnoOutputFile(String probAnnoOutputFile) {
        this.probAnnoOutputFile = probAnnoOutputFile;
        return this;
    }

    @JsonProperty("model_ref")
    public String getModelRef() {
        return modelRef;
    }

    @JsonProperty("model_ref")
    public void setModelRef(String modelRef) {
        this.modelRef = modelRef;
    }

    public ProbAnnoOutputPrams withModelRef(String modelRef) {
        this.modelRef = modelRef;
        return this;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public String toString() {
        return ((((((("ProbAnnoOutputPrams"+" [probAnnoOutputFile=")+ probAnnoOutputFile)+", modelRef=")+ modelRef)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
