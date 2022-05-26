package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

// TestSyncSourceRepo tests deploying an ECR repo and syncing a non-existent public repo
func TestSyncSourceRepoInvalid(t *testing.T) {
	t.Parallel()

	defer deleteRepo("terraform-aws-ecr/invalid-test")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../../examples/sync_source_repo_invalid",
		Vars:         map[string]interface{}{},
		NoColor:      true,
	})
	output, err := terraform.InitAndApplyAndIdempotentE(t, terraformOptions)
	assert.Error(t, err)

	fmt.Println(output)
	fmt.Println(err)
}
