Run the scripts in create.sh to build up pipeline (do it in the order they appear). 
The last script installs and initates a pipeline it is called: pipelinerun.yaml

To re-rerun pipelines re-create the pipelinerun script with: 

oc create -f pipelinerun.yaml

This will create a new pipeline run which can be viewed via the developer console (pipelines)

# tekton-pipeline
# tekton-pipeline

