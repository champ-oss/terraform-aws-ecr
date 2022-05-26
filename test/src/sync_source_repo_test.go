package test

import (
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

// TestSyncSourceRepo tests deploying an ECR repo and syncing a public repo
func TestSyncSourceRepo(t *testing.T) {
	t.Parallel()

	defer deleteRepo("terraform-aws-ecr/ubuntu-test")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/sync_source_repo",
		Vars:         map[string]interface{}{},
		NoColor:      true,
	})
	terraform.InitAndApplyAndIdempotent(t, terraformOptions)

	logger.Log(t, "validating repository_url endpoint exist and not empty")
	repositoryUrl := terraform.Output(t, terraformOptions, "repository_url")
	assert.NotEmpty(t, repositoryUrl)

	logger.Log(t, "validating registry_id endpoint exist and not empty")
	registryId := terraform.Output(t, terraformOptions, "registry_id")
	assert.NotEmpty(t, registryId)
}
