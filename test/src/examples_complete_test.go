package test

import (
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

// TestExamplesComplete tests a typical deployment of this module
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	repositories := []string{"repo1", "repo2", "repo3"}

	defer deleteRepo("repo1")
	defer deleteRepo("repo2")
	defer deleteRepo("repo3")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/complete",
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"repositories": repositories,
		},
		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	})

	terraform.InitAndApplyAndIdempotent(t, terraformOptions)

	logger.Log(t, "validating repository_url endpoint exist and not empty")
	// Run `terraform output` to get the value of an output variable
	repositoryUrl := terraform.OutputList(t, terraformOptions, "repository_url")
	// Verify we're getting back the outputs we expect
	assert.NotEmpty(t, repositoryUrl)

	logger.Log(t, "validating registry_id endpoint exist and not empty")
	// Run `terraform output` to get the value of an output variable
	registryId := terraform.OutputList(t, terraformOptions, "registry_id")
	// Verify we're getting back the outputs we expect
	assert.NotEmpty(t, registryId)
}
