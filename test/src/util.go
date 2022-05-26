package test

import (
	"fmt"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ecr"
	"log"
)

// NewSession creates a new AWS session
func NewSession() *ecr.ECR {

	config := &aws.Config{Region: aws.String("us-east-1")}
	svc := ecr.New(session.New(), config)

	return svc
}

// deleteRepo deletes an AWS ECR repo
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
