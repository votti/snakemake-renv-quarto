rule example_input:
    output:
        "results/input/{project}.txt",
    shell:
        "echo 'This is the project {wildcards.project}' > {output}"


rule render_quarto_report_base_env:
    conda:
        "../envs/quarto_r.yaml"
    input:
        input_txt="results/input/{project}.txt",
        # technical inputs
        renv="restored.Rprofile",
        script="workflow/quarto/report_example.qmd",
    output:
        # This will be the name/path of the rendered html report
        report="results/report/{project}_report_base.qmd",
        # Output files
        output_txt="results/test/{project}_base.txt",
    resources:
        mem_mb="8000",
    shell:
        """
        cp {input.script} {output.report}
        WD=$(pwd)
        SCRIPT=$(realpath "{output.report}")
        cd "$(dirname {input.renv})"

        quarto render "$SCRIPT" \
             -P project:{wildcards.project} \
             -P input_txt:{input.input_txt} \
             -P output_txt:{output.output_txt} \
             --execute-dir="$WD"
        """


rule render_quarto_report_second_env:
    conda:
        "../envs/quarto_r.yaml"
    input:
        input_txt="results/input/{project}.txt",
        # technical inputs
        renv="workflow/envs/renv_second/restored.Rprofile",
        script="workflow/quarto/report_example.qmd",
    output:
        # This will be the name/path of the rendered html report
        report="results/report/{project}_report.qmd",
        # Output files
        output_txt="results/test/{project}_test.txt",
    resources:
        mem_mb="8000",
    shell:
        """
        cp {input.script} {output.report}
        WD=$(pwd)
        SCRIPT=$(realpath "{output.report}")
        cd "$(dirname {input.renv})"

        quarto render "$SCRIPT" \
             -P project:{wildcards.project} \
             -P input_txt:{input.input_txt} \
             -P output_txt:{output.output_txt} \
             --execute-dir="$WD"
        """
