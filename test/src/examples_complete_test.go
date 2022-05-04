package main

import (
	"fmt"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ecr"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"log"
	"testing"
)

// create a new session
func NewSession() *ecr.ECR {

	config := &aws.Config{Region: aws.String("us-east-1")}
	svc := ecr.New(session.New(), config)

	return svc
}

// delete repo ecr
func deleteRepo(repo string) {

	result, err := NewSession().DeleteRepository(&ecr.DeleteRepositoryInput{
		Force:          aws.Bool(true),
		RepositoryName: &repo,
	})
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(result)
	fmt.Println("Repo deleted")
}

// TestExamplesComplete tests a typical deployment of this module. It will verify the SSM parameter is set correctly
// and that snapshots are all working as expected.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	repositories := []string{"repo1", "repo2", "repo3"}


	defer deleteRepo("repo1")
	defer deleteRepo("repo2")
	defer deleteRepo("repo3")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			// We also can see how lists and maps translate between terratest and terraform.
			"repositories": repositories,
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	})
	// Variables to pass to our Terraform code using -var options
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
