import json

config = {
	"program": "/home/msrinivasan/idseq-bact-resistance-pipeline/reflow-workflows/run_srst2_parametrized.rf",
	"runs_file": "AMR_sample_inputs.csv"
}

with open('config.json', 'w') as f:
	json.dump(config, f)
