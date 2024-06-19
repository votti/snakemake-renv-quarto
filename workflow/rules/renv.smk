wildcard_constraints:
    # Allows renv_dir also to be the empty (=root dir)
    renv_dir=".*",


rule restore_renv:
    conda:
        "../envs/quarto_r.yaml"
    input:
        "{renv_dir}.Rprofile",
        "{renv_dir}renv.lock",
    output:
        "{renv_dir}restored.Rprofile",
    shell:
        """
        R -e 'source("{input[0]}", chdir=TRUE);renv::restore()'
        echo 'source("{input[0]}", chdir=TRUE)' > {output[0]}
        """
