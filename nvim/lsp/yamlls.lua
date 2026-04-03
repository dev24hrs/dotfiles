return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
    root_markers = { ".git" },
    settings = {
        -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
        redhat = { telemetry = { enabled = false } },
        yaml = {
            format = { enable = true },
            validate = true,
            hover = true,
            completion = true,
            schemaStore = { enable = false, url = "" },
            schemas = {
                -- Kubernetes
                ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.0-standalone-strict/all.json"] = {
                    "k8s/**/*.yaml",
                    "kubernetes/**/*.yaml",
                },
                -- Docker Compose
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                    "docker-compose*.yaml",
                    "docker-compose*.yml",
                    "compose*.yaml",
                    "compose*.yml",
                },
                -- GitHub Actions
                ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yaml",
                ["https://json.schemastore.org/github-action.json"] = ".github/actions/*/action.yaml",
                -- GitLab CI
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
            },
        },
    },
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = true
    end,
}
